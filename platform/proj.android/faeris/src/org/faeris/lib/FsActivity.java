package org.faeris.lib;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.ViewGroup;
import android.widget.FrameLayout;


public abstract class FsActivity extends Activity
{
	/* attibute */
	private FsGLSurfaceView m_view;


	
	/* method */

	@Override 
	protected void onCreate(final Bundle save_state)
	{
		super.onCreate(save_state);
		this.init();
	}
	
	@Override 
	protected void onResume()
	{
		super.onResume();
		this.m_view.onResume();
	}

	@Override
	protected void onPause()
	{
		super.onPause();
		this.m_view.onPause();
	}
	
	protected void init()
	{

		m_view=new FsGLSurfaceView(this);
		FsGLRender r=new FsGLRender();
		
		m_view.setFsGLRender(r);
		this.setContentView(m_view);
		FsAndroidInfo.init(this);
	}
	
	
	protected void exit()
	{
		FsEngine.moduleExit();
	}
	
	
	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
	    	// exit program when key back is entered
			Log.v("key","onKeyEvent");
	    	if (keyCode == KeyEvent.KEYCODE_BACK) {
	    		android.os.Process.killProcess(android.os.Process.myPid());
	    	}
	        return super.onKeyDown(keyCode, event);
	}
}
