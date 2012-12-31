#include <Windows.h>
#include "GL/glew.h"
#include "fsys/FsWindow.h"
#include "fsys/FsFrame.h"
#include "util/FsLog.h"

//#include "fsys/FsEventDispatch.h"

#define FS_DEFAULT_WINDOW_WIDTH 640 
#define FS_DEFAULT_WINDOW_HEIGHT 480
#define FS_DEFAULT_WINDOW_BITS 32

NS_FS_BEGIN
class WindowFrameListener;


static Window* s_shareWindow=NULL;
static WindowFrameListener* s_frameListener=NULL;




LRESULT CALLBACK s_winproc(
		HWND hwnd,
		UINT umsg,
		WPARAM wparam,
		LPARAM lparam
		)
{

	switch(umsg)
	{
		case WM_LBUTTONDOWN:
		{
			FsInt x=(FsInt)LOWORD(lparam);
			FsInt y=(FsInt)HIWORD(lparam);
			break;
		}

		case WM_MOUSEMOVE:
			break;
		case WM_LBUTTONUP:
			break;


		case WM_CLOSE:
			break;

		case WM_KEYDOWN:
			break;
		case WM_KEYUP:
			break;
		case WM_SIZE:
			switch(wparam)
			{
				case SIZE_RESTORED:
					break;
				case SIZE_MINIMIZED:
					break;
			}
			break;


		default:
			return DefWindowProc(hwnd,umsg,wparam,lparam);
	}
	return 0;
	
}




static void SetupPixelFormat(HDC hDC)
{
    int pixelFormat;

    PIXELFORMATDESCRIPTOR pfd =
    {
        sizeof(PIXELFORMATDESCRIPTOR),  // size
        1,                          // version
        PFD_SUPPORT_OPENGL |        // OpenGL window
        PFD_DRAW_TO_WINDOW |        // render to window
        PFD_DOUBLEBUFFER,           // support double-buffering
        PFD_TYPE_RGBA,              // color type
        32,                         // prefered color depth
        0, 0, 0, 0, 0, 0,           // color bits (ignored)
        0,                          // no alpha buffer
        0,                          // alpha bits (ignored)
        0,                          // no accumulation buffer
        0, 0, 0, 0,                 // accum bits (ignored)
        16,                         // depth buffer
        0,                          // no stencil buffer
        0,                          // no auxiliary buffers
        PFD_MAIN_PLANE,             // main layer
        0,                          // reserved
        0, 0, 0,                    // no layer, visible, damage masks
    };

    pixelFormat = ChoosePixelFormat(hDC, &pfd);
    SetPixelFormat(hDC, pixelFormat, &pfd);
}



class PlatformWindow
{
	public:
		HGLRC hrc; 
		HDC hdc;
		HWND hwnd;
		HINSTANCE hinstance;
	protected:
		bool initWin();
		bool initGL();

	public:
		static PlatformWindow* create();
		PlatformWindow();
		~PlatformWindow();
		
};



PlatformWindow* PlatformWindow::create()
{
	PlatformWindow* ret=new PlatformWindow;
	if(!ret->initWin())
	{
		delete ret;
		return NULL;
	}
	return ret;
}
PlatformWindow::~PlatformWindow()
{
			if(hrc)
			{
				wglMakeCurrent(NULL,NULL);
				wglDeleteContext(hrc);
			}
			if(hdc)
			{
				ReleaseDC(hwnd,hdc);
			}
			if(hwnd)
			{
				DestroyWindow(hwnd);
			}
			UnregisterClass(L"FaerisWindow",hinstance);
}
PlatformWindow::PlatformWindow()
{
	hwnd=0;
	hrc=0;
	hdc=0;
	hinstance=0;
}
FsBool PlatformWindow::initWin()
{

	hinstance=GetModuleHandle(NULL);

	/* window class */
	WNDCLASS wc;
	wc.style=CS_HREDRAW|CS_VREDRAW|CS_OWNDC;
	wc.lpfnWndProc=(WNDPROC) s_winproc;
	wc.cbClsExtra=0;
	wc.cbWndExtra=0;
	wc.hInstance=hinstance;
	wc.hIcon=LoadIcon(NULL,IDI_WINLOGO);
	wc.hCursor=LoadCursor(NULL,IDC_ARROW);
	wc.hbrBackground=NULL;
	wc.lpszMenuName=NULL;
	wc.lpszClassName=L"FaerisWindow";
	if(!RegisterClass(&wc))
	{
		FS_TRACE_WARN("RegisterClass Failed");
		return false;
	}


	hwnd=CreateWindowEx(
			WS_EX_APPWINDOW|WS_EX_WINDOWEDGE,
			L"FaerisWindow",
			TEXT(FS_DEFAULT_WINDOW_NAME),
			WS_CAPTION|WS_POPUPWINDOW|WS_MINIMIZEBOX,
			0,0,
			FS_DEFAULT_WINDOW_WIDTH,
			FS_DEFAULT_WINDOW_HEIGHT,
			NULL,
			NULL,
			hinstance,
			NULL);
	if(!hwnd)
	{
		FS_TRACE_WARN("CreateWindow Failed");
		return false;
	}
	if(!initGL())
	{
		return false;
	}

	return true;
}

FsBool PlatformWindow::initGL()
{
	hdc=GetDC(hwnd);
	SetupPixelFormat(hdc);
	hrc=wglCreateContext(hdc);
	wglMakeCurrent(hdc,hrc);
	const GLubyte* gl_version=glGetString(GL_VERSION);
	FsUtil_Log("OpenGL Version=%s",gl_version);
	if(atof((FsChar*)gl_version)<1.5)
	{
		char str_compain[256]={0};
		sprintf(str_compain,"OpenGL 1.5 or higher is required(your version is %s), \
				please upgrade the driver of your video card",gl_version);
		FsUtil_Log("%s",str_compain);
		return false;
	}
	GLenum ret=glewInit();
	if(ret!=GLEW_OK)
	{
		FsUtil_Log("Init Glew Failed %s",glewGetErrorString(ret));
		return false;
	}
	return true;

}


class WindowFrameListener:public FrameListener 
{
	public:
		virtual void frameBegin(FsLong diff)
		{
			if(s_shareWindow)
			{
				PlatformWindow* plt_window=s_shareWindow->getPlatformWindow();
				if(plt_window)
				{
					MSG msg;
					while(PeekMessage(&msg,NULL,0,0,PM_REMOVE))
					{
						TranslateMessage(&msg);
						DispatchMessage(&msg);
					}
				}
			}
		}
};


Window* Window::shareWindow()
{
	if(s_shareWindow==NULL)
	{
		PlatformWindow* platform_window=PlatformWindow::create();
		if(!platform_window)
		{
			return NULL;
		}
		Window* ret=new Window;
		ret->m_window=platform_window;
		s_shareWindow =ret;

		s_frameListener=new WindowFrameListener;
		Frame::shareFrame()->addListener(s_frameListener);
	}
	return s_shareWindow;
}
void Window::purgeShareWindow()
{
	Frame::shareFrame()->removeListener(s_frameListener);
	s_frameListener=NULL;
	delete s_shareWindow;
	s_shareWindow=NULL;

}

void Window::makeCurrent(Render* r)
{
	if(m_window)
	{
		wglMakeCurrent(m_window->hdc,m_window->hrc);
	}
	m_render=r;
}
void Window::loseCurrent(Render* r)
{
	if(m_window)
	{
		wglMakeCurrent(NULL,m_window->hrc);
	}
	m_render=NULL;
}
void Window::swapBuffers()
{
	if(m_window)
	{
		SwapBuffers(m_window->hdc);
	}
}

void Window::setCaption(const FsChar* name)
{

	if(m_window)
	{
		SetWindowTextA(m_window->hwnd,name);
		m_caption=name;
	}
}
void Window::setPosition(FsInt x,FsInt y)
{
	if(m_window)
	{
		SetWindowPos(m_window->hwnd, 0, x, y, 0, 0, SWP_NOCOPYBITS | SWP_NOSIZE | SWP_NOOWNERZORDER | SWP_NOZORDER);
	}
}
void Window::setSize(FsUint width,FsUint height)
{
	if(!m_window)
	{
		return;
	}
	RECT w_rect;
	RECT c_rect;
	GetWindowRect(m_window->hwnd,&w_rect);
	GetClientRect(m_window->hwnd,&c_rect);
	POINT diff;
	diff.x=(w_rect.right-w_rect.left)-c_rect.right;
	diff.y=(w_rect.bottom-w_rect.top)-c_rect.bottom;

	c_rect.right=c_rect.left+width;
	c_rect.bottom=c_rect.top+height;

	AdjustWindowRectEx(&c_rect,
			GetWindowLong(m_window->hwnd,GWL_STYLE),
			FALSE,
			GetWindowLong(m_window->hwnd,GWL_EXSTYLE)
			);

	SetWindowPos(m_window->hwnd,0,0,0,width+diff.x,height+diff.y,
			SWP_NOCOPYBITS|SWP_NOMOVE|SWP_NOOWNERZORDER|SWP_NOZORDER
			);
}
void Window::show()
{
	if(m_window)
	{
		ShowWindow(m_window->hwnd,SW_SHOW);
	}

}
void Window::hide()
{
	if(m_window)
	{
		ShowWindow(m_window->hwnd,SW_HIDE);
	}
}
void Window::setStyle(FsLong flags)
{
}
void Window::setFullScreen(FsBool full)
{
}
FsInt Window::getWidth() 
{
	if(m_window)
	{
		RECT rect;
		GetClientRect(m_window->hwnd,&rect);
		return rect.right-rect.left;
	}
	return 0;
}
FsInt Window::getHeight()
{
	if(m_window)
	{
		RECT rect;
		GetClientRect(m_window->hwnd,&rect);
		return rect.bottom-rect.top;
	}
	return 0;
}
FsInt Window::getPosX()
{
	if(m_window)
	{
		RECT w_rect;
		GetWindowRect(m_window->hwnd,&w_rect);
		return w_rect.left;
	}
	return 0;
}
FsInt Window::getPosY() 
{
	if(m_window)
	{
		RECT w_rect;
		GetWindowRect(m_window->hwnd,&w_rect);
		return w_rect.top;
	}
	return 0;
}


Window::~Window()
{
	if(m_render)
	{
		m_render->setRenderTarget(NULL);
		m_render=NULL;
	}
	delete m_window;
	m_window=NULL;

}






NS_FS_END 

