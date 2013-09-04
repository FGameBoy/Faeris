#include "action/FsPauseAction.h"

NS_FS_BEGIN

const char* PauseAction::className()
{
	return FS_PAUSE_ACTION_CLASS_NAME;
}

PauseAction* PauseAction::create(float time)
{
	return new PauseAction(time);
}


bool PauseAction::run(StageElement* target,float dt)
{
	m_elapse+=dt;
	if(m_elapse>=m_lifeTime)
	{
		return true;
	}
	return false;
}


PauseAction::PauseAction(float time)
{
	m_elapse=0;
	m_lifeTime=0;
}


NS_FS_END



