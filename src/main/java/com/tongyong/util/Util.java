package com.tongyong.util;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * 工具类
 * @author sunmeng
 * @date 2017年7月5日上午11:19:49
 */
public class Util {

	/**
	 * 获取四位随机数字
	 * @author sunmeng
	 * @date 2016年6月17日 上午11:40:13
	 * @return
	 */
	public static String randomNubmer4(){
		int max=9999;
        int min=1000;
        Random random = new Random();

        int s = random.nextInt(max)%(max-min+1) + min;
        return String.valueOf(s);
	}
	
	/**
	 * 获取六位随机数字
	 * @author sunmeng
	 * @date 2016年6月17日 上午11:40:13
	 * @return
	 */
	public static String randomNubmer6(){
		int s = new Random().nextInt(999999);
        return String.format("%06d", s);
	}
	
	/**
	 * 四舍五入，保留指定位数的小数
	 * @author monkey
	 * @date 2016年7月20日 下午6:35:59
	 * @param value 要操作的数值
	 * @param num 指定小数位数
	 * @return
	 */
	public static double formatDouble(double value,int num) {
		BigDecimal bigDecimal=new BigDecimal(value);
		return bigDecimal.setScale(num, BigDecimal.ROUND_HALF_UP).doubleValue();
	}
	
	/**
	 * 四舍五入，保留2位数的小数
	 * @author monkey
	 * @date 2016年7月20日 下午6:35:59
	 * @param value 要操作的数值
	 * @return
	 */
	public static double formatDouble(double value) {
		BigDecimal bigDecimal=new BigDecimal(value);
		return bigDecimal.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
	}
	
	/**
	 * 判断是否是闰年
	 * @param year
	 * @return
	 */
	public static boolean isLeapYear(int year){
		if(year % 100 == 0){
			if(year % 400 == 0){
				return true;
			}
		}else{
			if(year % 4 == 0){
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 获取六位随机数字
	 * @author sunmeng
	 * @date 2016年6月17日 上午11:40:13
	 * @return
	 */
	public static String contractNumber(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		Date now = new Date();
		String contractNumber = "XC" + sdf.format(now);
		
		int max=99;
        int min=10;
        Random random = new Random();
        int s = random.nextInt(max)%(max-min+1) + min;
        return contractNumber + String.valueOf(s);
	}
	
	/**
	 * 截取身份证号码的后六位
	 * @param idCardNo 身份证号码
	 * @return
	 */
	public static String idCardNoAfterSix(String idCardNo){
		return idCardNo.substring(idCardNo.length() - 6);
	}
	
}
