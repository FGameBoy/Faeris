#include "stage/FsDirector.h"
#include "sys/event/FsTouchDispatcher.h"
#include "FsGlobal.h"
#include "support/util/FsArray.h"
#include "math/FsVector2.h"
#include "stage/FsScene.h"

NS_FS_BEGIN

class DirectorTouchEventListener:public TouchEventListener
{
	public:
		static DirectorTouchEventListener* create(Director* director);

	public:
		virtual void touchBegin(float x,float y);
		virtual void touchMove(float x,float y);
		virtual void touchEnd(float x,float y);

		virtual void touchesBegin(TouchEvent* event);
		virtual void touchesPointerDown(TouchEvent* event);
		virtual void touchesMove(TouchEvent* event);
		virtual void touchesPointerUp(TouchEvent* event);
		virtual void touchesEnd(TouchEvent* event);


	protected:
		DirectorTouchEventListener(Director* director);
		~DirectorTouchEventListener();
	private:
		Director* m_director;
};

DirectorTouchEventListener* DirectorTouchEventListener::create(Director* director)
{
	DirectorTouchEventListener* ret=new DirectorTouchEventListener(director);
	return ret;
}


void DirectorTouchEventListener::touchBegin(float x,float y)
{
	m_director->touchBegin(x,y);
}

void DirectorTouchEventListener::touchMove(float x,float y)
{
	m_director->touchMove(x,y);
}

void DirectorTouchEventListener::touchEnd(float x,float y)
{
	m_director->touchEnd(x,y);
}


void DirectorTouchEventListener::touchesBegin(TouchEvent* event)
{
	m_director->touchesBegin(event);
}

void DirectorTouchEventListener::touchesPointerDown(TouchEvent* event)
{
	m_director->touchesPointerDown(event);
}


void DirectorTouchEventListener::touchesMove(TouchEvent* event)
{
	m_director->touchesMove(event);
}
void DirectorTouchEventListener::touchesPointerUp(TouchEvent* event)
{
	m_director->touchesPointerUp(event);
}


void DirectorTouchEventListener::touchesEnd(TouchEvent* event)
{
	m_director->touchesEnd(event);
}


DirectorTouchEventListener::DirectorTouchEventListener(Director* director)
{
	m_director=director;
}
DirectorTouchEventListener::~DirectorTouchEventListener()
{
}


class DirectorKeypadEventListener:public KeypadEventListener
{
	public:
		static DirectorKeypadEventListener* create(Director* director)
		{
			return new DirectorKeypadEventListener(director);
		}

	public:
		virtual void onKeypadEvent(int type,int keycode)
		{
			m_director->keypadEvent(type,keycode);
		}


	protected:
		DirectorKeypadEventListener(Director* director)
		{
			m_director=director;
		}
		~DirectorKeypadEventListener()
		{
		}
	private:
		Director* m_director;
};

Director* Director::create()
{
	Director* ret=new Director;
	return ret;
}

const char* Director::className()
{
	return FS_DIRECTOR_CLASS_NAME;
}

void Director::update(int priority,float dt)
{
	if(m_sceneChange)
	{
		if(m_current)
		{
			m_current->exit();
			m_current->decRef();
		}

		if(m_next)
		{
			m_next->enter();
			
		}

		m_current=m_next;
		m_next=NULL;
		m_sceneChange=false;
	}
	if(m_stop)
	{
		return ;
	}
	if(!m_current) return;

	switch(priority)
	{
		case Scheduler::MIDDLE:
			update(dt);
			break;
		case Scheduler::LOW:
			draw();
			break;
	}
}
void Director::push()
{
	if(m_current)
	{
		m_secenQueue->push(m_current);
	}
	FS_TRACE_WARN_ON(m_current==NULL,"No Current Exist");
}
void Director::pop()
{
	if(m_secenQueue->size()==0)
	{
		FS_TRACE_WARN("No Scene in Queue");
		return ;
	}
	Scene* scene=(Scene*)m_secenQueue->get(m_secenQueue->size()-1);
	m_secenQueue->pop();

	repace(scene);
}

void Director::run(Scene* scene)
{
	repace(scene);
}
Scene* Director::current()
{
	FS_SAFE_ADD_REF(m_current);
	return m_current;
}

void Director::pause()
{
	m_stop=true;
}
void Director::start()
{
	m_stop=false;
}
bool Director::isRunning()
{
	return !m_stop;
}
void Director::setAutoSwapBuffers(bool swap)
{
	m_autoSwapBuffers=swap;
}



Director::Director()
{
	init();
}

Director::~Director()
{
	destroy();
}
void Director::init()
{
	m_current=NULL;
	m_next=NULL;
	m_sceneChange=false;
	m_secenQueue=FsArray::create();
	m_stop=false;
	m_autoSwapBuffers=false;

	m_touchEventListener=DirectorTouchEventListener::create(this);
	Global::touchDispatcher()->addListener(m_touchEventListener);

	m_keypadEventListener=DirectorKeypadEventListener::create(this);
	Global::keypadDispatcher()->addListener(m_keypadEventListener);

}
void Director::destroy()
{
	if(m_current)
	{
		m_current->exit();
		m_current->decRef();
		m_current=NULL;
	}

	if(m_next)
	{
		m_next->decRef();
		m_next=NULL;
	}

	m_secenQueue->decRef();

	Global::touchDispatcher()->removeListener(m_touchEventListener);
	m_touchEventListener->decRef();

	Global::keypadDispatcher()->removeListener(m_keypadEventListener);
	m_keypadEventListener->decRef();
}

void Director::repace(Scene* scene)
{
	FS_SAFE_ASSIGN(m_next,scene);
	m_sceneChange=true;

}

void Director::draw()
{

	//FS_TRACE_INFO("Draw");

	Render* render=Global::render();
	if(!render) return;

	render->clear();

	if(m_current)
	{
		m_current->draw(render);
	}
	if(m_autoSwapBuffers)
	{
		render->swapBuffers();
	}

}

void Director::update(float dt)
{
	if(m_current)
	{
		m_current->update(dt);
	}
}

void Director::touchBegin(float x,float y)
{
	if(m_stop) return;
	if(!m_current) return;

	m_current->touchBegin(x,y);
}

void Director::touchMove(float x,float y)
{
	if(m_stop) return;
	if(!m_current) return;

	m_current->touchMove(x,y);
}

void Director::touchEnd(float x,float y)
{
	if(m_stop) return;
	if(!m_current) return;

	m_current->touchEnd(x,y);
}

void Director::touchesBegin(TouchEvent* event)
{
	if(m_stop) return;
	if(!m_current) return;

	m_current->touchesBegin(event);
}

void Director::touchesPointerDown(TouchEvent* event)
{
	if(m_stop) return;
	if(!m_current) return;

	m_current->touchesPointerDown(event);
}
void Director::touchesMove(TouchEvent* event)
{
	if(m_stop) return;
	if(!m_current) return;

	m_current->touchesMove(event);
}
void Director::touchesPointerUp(TouchEvent* event)
{
	if(m_stop) return;
	if(!m_current) return;

	m_current->touchesPointerUp(event);
}

void Director::touchesEnd(TouchEvent* event)
{
	if(m_stop) return;
	if(!m_current) return;
	m_current->touchesEnd(event);
}

void Director::keypadEvent(int type,int keycode)
{
	if(m_stop) return;
	if(!m_current) return;
	m_current->keypadEvent(type,keycode);
}













NS_FS_END





















