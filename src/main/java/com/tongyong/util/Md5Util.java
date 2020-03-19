package com.tongyong.util;

import org.apache.commons.codec.digest.DigestUtils;

/**
 * md5的工具类
 * @author monkey
 * @date 2016年6月2日 下午5:30:43
 */
public class Md5Util {

	/**
	 * md5加密小写,默认是utf-8格式
	 * 
	 * @author monkey
	 * @date 2016年6月2日 下午5:42:08
	 * @param data 要加密的字符串
	 * @return md5加密后的小写的字符串
	 */
	public static String md5Hex(String data){
    	return DigestUtils.md5Hex(data);
    }
	
	/**
	 * md5加密大写,默认是utf-8格式
	 * @author monkey
	 * @date 2016年6月2日 下午5:52:02
	 * @param data
	 * @return md5加密后的大写的字符串
	 */
	public static String md5HexUpperCase(String data){
    	return DigestUtils.md5Hex(data).toUpperCase();
    }
	
	public static void main(String[] args) {
		System.err.println(md5Hex("1237990"));
		System.err.println(md5HexUpperCase("123456"));
		System.err.println(md5Hex("111111"));
	}
}
