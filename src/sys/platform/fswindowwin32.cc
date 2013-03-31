#include <Windows.h>
#include "GL/glew.h"
#include "sys/FsWindow.h"
#include "util/FsLog.h"
#include "common/FsGlobal.h"
#include "scheduler/FsSchedulerTarget.h"
#include "scheduler/FsScheduler.h"
#include "event/FsTouchDispatcher.h"


#define FS_DEFAULT_WINDOW_WIDTH 640 
#define FS_DEFAULT_WINDOW_HEIGHT 480
#define FS_DEFAULT_WINDOW_BITS 32

NS_FS_BEGIN

class PlatformWindow;
class EventGraper:public SchedulerTarget
{
	public:
		static EventGraper* create(PlatformWindow* win);

	public:
		void update(int priority,float dt);

	protected:
		EventGraper();
	private:
		PlatformWindow* m_window;
};

EventGraper::EventGraper()
{
	m_window=NULL;
}

EventGraper* EventGraper::create(PlatformWindow* win)
{
	EventGraper* ret=new EventGraper;
	ret->m_window=win;
	return ret;
}

void EventGraper::update(int priority,float dt)
{
	MSG msg;
	while(PeekMessage(&msg,NULL,0,0,PM_REMOVE))
	{
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}
}



static bool pointInView(float x,float y)
{
	if(x>=0&&x<=1.0f)
	{
		if(y>=0&&y<=1.0f)
		{
			return true;
		}
	}
	return false;
}
static void transformViewPoint(float* x,float* y)
{
	int width=Global::window()->getWidth();
	int height=Global::window()->getHeight();
	*x=*x/width;
	*y=*y/height;
	*y=1.0f-*y;
}
static bool s_mouse_capture=false;

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
				float x=(float)LOWORD(lparam);
				float y=(float)HIWORD(lparam);
				transformViewPoint(&x,&y);
				if(pointInView(x,y))
				{
					Global::touchDispatcher()->dispatchTouchEvent(
							TouchDispatcher::TOUCH_BEGIN,x,y);
					s_mouse_capture=true;
					SetCapture(hwnd);
				}


			}
			break;
		case WM_MOUSEMOVE:
			{
				if(wparam==MK_LBUTTON&&s_mouse_capture)
				{
					float x=(float)LOWORD(lparam);
					float y=(float)HIWORD(lparam);
					transformViewPoint(&x,&y);
					if(pointInView(x,y))
					{
						Global::touchDispatcher()->dispatchTouchEvent(
								TouchDispatcher::TOUCH_MOVE,x,y);
					}
				}
			}
			break;
		case WM_LBUTTONUP:
			{
				if(s_mouse_capture)
				{
					float x=(float)LOWORD(lparam);
					float y=(float)HIWORD(lparam);
					transformViewPoint(&x,&y);
					if(pointInView(x,y))
					{
						Global::touchDispatcher()->dispatchTouchEvent(
								TouchDispatcher::TOUCH_END,x,y);
						ReleaseCapture();
						s_mouse_capture=false;
					}
				}
			}
			break;

		case WM_CLOSE:
			Global::sysDispatcher()->dispatchSysEvent(SysDispatcher::QUIT);
			break;

		case WM_DESTROY:
			Global::scheduler()->stop();
			break;

		case WM_KEYDOWN:
			break;
		case WM_KEYUP:
			break;
		case WM_SIZE:
			switch(wparam)
			{
				case SIZE_RESTORED:
					Global::sysDispatcher()->dispatchSysEvent(SysDispatcher::FOREGROUND);
					break;
				case SIZE_MINIMIZED:
					Global::sysDispatcher()->dispatchSysEvent(SysDispatcher::BACKGROUND);
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
		EventGraper* m_eventGrap;
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
	UnregisterClass("FaerisWindow",hinstance);
	Global::scheduler()->remove(m_eventGrap,Scheduler::HIGHEST);
	m_eventGrap->decRef();
}

PlatformWindow::PlatformWindow()
{
	hwnd=0;
	hrc=0;
	hdc=0;
	hinstance=0;
	m_eventGrap=EventGraper::create(this);
	Global::scheduler()->add(m_eventGrap,Scheduler::HIGHEST);
}



bool PlatformWindow::initWin()
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
	wc.lpszClassName="FaerisWindow";
	if(!RegisterClass(&wc))
	{
		FS_TRACE_WARN("RegisterClass Failed");
		return false;
	}


	hwnd=CreateWindowEx(
			WS_EX_APPWINDOW|WS_EX_WINDOWEDGE,
			"FaerisWindow",
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

bool PlatformWindow::initGL()
{
	hdc=GetDC(hwnd);
	SetupPixelFormat(hdc);
	hrc=wglCreateContext(hdc);
	wglMakeCurrent(hdc,hrc);
	const GLubyte* gl_version=glGetString(GL_VERSION);
	FsUtil_Log("OpenGL Version=%s",gl_version);
	if(atof((char*)gl_version)<1.5)
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


Window* Window::create()
{
	PlatformWindow* plt_window=PlatformWindow::create();
	if(plt_window==NULL)
	{
		return NULL;
	}
	Window* ret=new Window;
	ret->m_window=plt_window;
	return ret;
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

void Window::setCaption(const char* name)
{

	if(m_window)
	{
		SetWindowTextA(m_window->hwnd,name);
		m_caption=name;
	}
}

void Window::setPosition(int x,int y)
{
	if(m_window)
	{
		SetWindowPos(m_window->hwnd, 0, x, y, 0, 0, SWP_NOCOPYBITS | SWP_NOSIZE | SWP_NOOWNERZORDER | SWP_NOZORDER);
	}
}

void Window::setSize(uint width,uint height)
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

void Window::setStyle(long flags)
{
}

void Window::setFullScreen(bool full)
{
}

int Window::getWidth() 
{
	if(m_window)
	{
		RECT rect;
		GetClientRect(m_window->hwnd,&rect);
		return rect.right-rect.left;
	}
	return 0;
}

int Window::getHeight()
{
	if(m_window)
	{
		RECT rect;
		GetClientRect(m_window->hwnd,&rect);
		return rect.bottom-rect.top;
	}
	return 0;
}

int Window::getPosX()
{
	if(m_window)
	{
		RECT w_rect;
		GetWindowRect(m_window->hwnd,&w_rect);
		return w_rect.left;
	}
	return 0;
}

int Window::getPosY() 
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

