package com.rwhz.secure;

public class Fs_UpdateInfo {
	/*
	 * ����
				http://host:port/apk?pn=com.huizhi.runner&ver=1
				��Ӧ��
				{
					ret:0,
					msg:'',
					url:http://host:port/apk/runner-1.0.apk,
					isForce:1
					version:12
				}
	 * *
	 */
	private  String  apkUrl; //���µ�ַ
	private int  result; //���ؽ��
	private int isForce;  // 1ǿ�Ƹ��� 0 ��ǿ��
	private int version; //�汾��
	
	private String msg; // ������Ϣ ��result Ϊ��

	public String getApkUrl() {
		return apkUrl;
	}

	public void setApkUrl(String apkUrl) {
		this.apkUrl = apkUrl;
	}

	public int getResult() {
		return result;
	}

	public void setResult(int result) {
		this.result = result;
	}

	public int getIsForce() {
		return isForce;
	}

	public void setIsForce(int isForce) {
		this.isForce = isForce;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	

}
