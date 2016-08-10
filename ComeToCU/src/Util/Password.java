package Util;

import java.security.*;

public class Password {
	public String createHash(String data) throws Exception{
		if(data==null){
			throw new NullPointerException();
		}
		
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		byte[] raw = md.digest(data.getBytes("UTF-8"));
		
		StringBuffer result = new StringBuffer();
		for(int i=0;i<raw.length;i++){
			result.append(Integer.toHexString(raw[i]&0xff));
		}
		return result.toString();
	}
	
}
