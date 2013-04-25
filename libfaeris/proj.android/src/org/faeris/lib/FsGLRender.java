package org.faeris.lib;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

import android.util.Log;

public class FsGLRender implements GLSurfaceView.Renderer
{
	private boolean m_init=false;
	private long m_now;
	private long m_last;
	@Override 
	public void onDrawFrame(final GL10 gl)
	{
		m_now=System.currentTimeMillis() ;
		float diff=m_now-m_last;
		float sleep_time=FsEngine.onUpdate(diff);
		if(sleep_time>0)
		{
			try
			{
				Thread.sleep((long) sleep_time);
			}
			catch(final Exception e)
			{
			}
		}
		m_last=m_now;
	}
	public void setIsDraw(boolean draw)
	{
	}
	public boolean getIsDraw()
	{
		return true;
	}

	@Override
	public void onSurfaceChanged(GL10 gl, int width, int height)
	{
		FsEngine.onResize(width, height);
		
	} 

	@Override
	public void onSurfaceCreated(GL10 gl, EGLConfig config) 
	{
		if(!this.m_init)
		{
			Log.v("key","init:"+this.m_init);
			FsEngine.moduleInit();
			this.m_init=true;
			Log.v("key","init:"+this.m_init);
		}
		m_now=System.currentTimeMillis();
		m_last=m_now;
	}

}
