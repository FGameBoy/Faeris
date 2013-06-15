package com.faeris.lib;

public class Fs_Jni {
	
	/* Init add Exit FsEngine Module */
	public static native void moduleInit();
	public static native void moduleExit();
	
	
	
	/* sys event */
	public static native void onForeground();
	public static native void onBackground();
	
	/* touches event */
	public static native void onTouchesBegin(int id,float x,float y);
	public static native void onTouchesPointerDown(int id,float x,float y);
	public static native void onTouchesMove(int pointer_nu,final int[] ids,final float[] xs,final float[] ys);
	public static native void onTouchesPointerUp(int id,float x,float y);
	public static native void onTouchesEnd(int id,float x,float y);
	
	/* menu event */
	public static native void onKeyEventBack();
	public static native void onKeyEventMenu();
	
	/* input method */
	
	
	/* surface event */
	public static native void onResize(int width,int height);

	/* update event */
	public static native float onUpdate(float dt);
	
	/* destory event */
	public static native void onDestroy();
	
	
	/* env */
	public static native void setEnv(String name,String value);
	
	public static native boolean schedulerStop();

}
