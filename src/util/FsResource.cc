#include "util/FsResourceMgr.h"
#include "util/FsResource.h"

FAERIS_NAMESPACE_BEGIN
Resource::Resource()
{
	m_mgr=NULL;
}

Resource::~Resource() {}

void Resource::onDestroy()
{
	if(m_mgr)
	{
		m_mgr->remove(this);
	}
	delete this;
}
FAERIS_NAMESPACE_END

