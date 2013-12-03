package com.ihuizhi.secure;

import org.json.JSONObject;

import com.ihuizhi.vo.ParseBaseVo;

public class Fs_UpdateInfo extends ParseBaseVo {

	public static final int UPDATEAPK_FORCE = 1;
	public static final int UPDATEAPK_UFORCE = 0;

	/*
	 * ���� http://host:port/apk?pn=com.huizhi.runner&ver=1 ��Ӧ�� { ret:0, msg:'',
	 * url:http://host:port/apk/runner-1.0.apk, isForce:1 version:12 } *
	 * 			 			Info.setResult(req.getInt("ret"));
				 			Info.setApkUrl(req.getString("url"));
			 			Info.setStatus(req.getInt("status"));
						 			Info.setMsg(req.getString("msg"));
						 			Info.setVersion(req.getInt("version"));							 			

	 */
	private String apkUrl; // ���µ�ַ
	private int result; // ���ؽ��
	private int status; // 1ǿ�Ƹ��� 0 ��ǿ��
	private int version; // �汾��

	private String msg; // ������Ϣ ��result Ϊ��

	public void parseJson(JSONObject obj) {
		
		if (!obj.isNull("url")) {
			apkUrl = getString(obj, "url");
		}
		if (!obj.isNull("ret")) {
			result = getInt(obj, "ret");
		}
		if (!obj.isNull("status")) {
			status = getInt(obj, "status");
		}
		if (!obj.isNull("version")) {
			version = getInt(obj, "version");
		}		
		if (!obj.isNull("msg")) {
			msg = getString(obj, "msg");
		}
	}

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

	public int getStatus() {
		return status;
	}

	public void setStatus(int isForce) {
		this.status = isForce;
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
