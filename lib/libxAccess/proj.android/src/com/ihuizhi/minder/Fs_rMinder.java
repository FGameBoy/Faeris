 package com.ihuizhi.minder;

import android.app.Activity;
import android.app.ProgressDialog;
import android.util.Log;

import com.faeris.lib.Fs_Activity;
import com.tendcloud.tenddata.TCAgent;

public class Fs_rMinder {

	public static Fs_rMinder mMinder =  null;
	public static Fs_Activity mContext = null;
	
	public static Fs_rMindHandler mHandler = null;
	public static ProgressDialog Fs_rProgressdialog = null;
	
	public static Fs_rMinder  createMinder(Fs_Activity context , ProgressDialog dialog)
	{
		if (mMinder ==null  || mHandler == null || context == null )
		{
		   mMinder = new Fs_rMinder(context);	
		   mHandler  = new Fs_rMindHandler(context);
		   Fs_rProgressdialog  =  dialog;
		}		 
		return mMinder;
	}
	
	
	public Fs_rMinder(Fs_Activity  context)
	{
		mContext = context;
		init();
	}
	
	/* ****************************
	 *  ��      Talkingdata       Ԥ���ӿڣ�
	 * **************************/
	public void init()
	{
		TCAgent.init(mContext);
				
		//��ʼ��		
		Log.i("Delo", "Fs_rMinder:init()");	
	}
	
	
	public void onResume(Activity context){
		// �ָ�
		
		TCAgent.onResume(mContext);
		mHandler.onResume(mContext);		
		Log.i("Delo", "Fs_rMiner:onResume()");
	}
	
	public void onPause(Activity context){
		//��ͣ
		TCAgent.onPause(mContext);
		
		Log.i("Delo","Fs_rMiner:onPause()");
	}
	
}
