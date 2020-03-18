package com.tongyong.process.result;

import java.util.List;

import com.tongyong.exception.CustomException;
import com.tongyong.process.context.MyConfig;


/**
 * 系统结果工具类
 * 
 * @author xie
 * @date 2016年4月24日 下午9:11:48
 */
public class ResultUtil {
	/**
	 * 创建错误结果
	 * 
	 * @param MESSAGE
	 * @return
	 */
	public static ResultInfo createFail(String fileName, int messageCode, Object[] objs) {
		String message = null;
		if (objs == null) {
			message = ResourcesUtil.getValue(fileName, messageCode + "");
		} else {
			message = ResourcesUtil.getValue(fileName, messageCode + "", objs);
		}
		return new ResultInfo(ResultInfo.TYPE_RESULT_FAIL, messageCode, message);
	}

	/**
	 * 创建敬告提示结果
	 */
	public static ResultInfo createWarning(String fileName, int messageCode, Object[] objs) {
		String message = null;
		if (objs == null) {
			message = ResourcesUtil.getValue(fileName, messageCode + "");
		} else {
			message = ResourcesUtil.getValue(fileName, messageCode + "", objs);
		}
		return new ResultInfo(ResultInfo.TYPE_RESULT_WARN, messageCode, message);
	}

	/**
	 * 创建成功提示结果
	 */
	public static ResultInfo createSuccess(String fileName, int messageCode, Object[] objs) {

		String message = null;
		if (objs == null) {
			message = ResourcesUtil.getValue(fileName, messageCode + "");
		} else {
			message = ResourcesUtil.getValue(fileName, messageCode + "", objs);
		}
		return new ResultInfo(ResultInfo.TYPE_RESULT_SUCCESS, messageCode, message);
	}

	/**
	 * 创建普通信息提示结果
	 */
	public static ResultInfo createInfo(String fileName, int messageCode, Object[] objs) {

		String message = null;
		if (objs == null) {
			message = ResourcesUtil.getValue(fileName, messageCode + "");
		} else {
			message = ResourcesUtil.getValue(fileName, messageCode + "", objs);
		}
		return new ResultInfo(ResultInfo.TYPE_RESULT_INFO, messageCode, message);
	}

	/**
	 * 简单处理，抛出异常
	 * @param messageCode 异常代码
	 * @throws CustomException
	 */
	public static void throwCustomExcepion(int messageCode) throws CustomException {
		String message=ResourcesUtil.getValue(MyConfig.MESSAGE, String.valueOf(messageCode));
		ResultInfo resultInfo=new ResultInfo(ResultInfo.TYPE_RESULT_FAIL, messageCode, message);
		throw new CustomException(resultInfo);
	}
	
	/**
	 * 简单处理，抛出异常
	 * @param message 异常消息
	 * @throws CustomException
	 */
	public static void throwCustomExcepion(String message) throws CustomException {
		ResultInfo resultInfo=new ResultInfo(ResultInfo.TYPE_RESULT_FAIL, 0, message);
		throw new CustomException(resultInfo);
	}
	
	/**
	 * 抛出异常
	 * 
	 * @param resultInfo
	 * @throws ExceptionResultInfo
	 */
	public static void throwExcepion(ResultInfo resultInfo) throws CustomException {
		//throw new ExceptionResultInfo(resultInfo);
		throw new CustomException(resultInfo);
	}

	public static void throwExcepion(ResultInfo resultInfo, List<ResultInfo> details) throws CustomException {
		if (resultInfo != null) {
			resultInfo.setDetails(details);
		}
		throw new CustomException(resultInfo);
	}
	
	/**
	 * 创建成功的提交结果信息
	 * 
	 * @param resultInfo
	 * @return
	 */
	public static SubmitResultInfo getSuccessSubmitResult() {
		return new SubmitResultInfo(ResultUtil.createSuccess(MyConfig.MESSAGE, 100, null));
	}

	/**
	 * 创建提交结果信息
	 * 
	 * @param resultInfo
	 * @return
	 */
	public static SubmitResultInfo createSubmitResult(ResultInfo resultInfo) {
		return new SubmitResultInfo(resultInfo);
	}

	/**
	 * 创建提交结果信息，包括明细信息
	 * 
	 * @param resultInfo
	 * @param details
	 * @return
	 */
	public static SubmitResultInfo createSubmitResult(ResultInfo resultInfo, List<ResultInfo> details) {
		if (resultInfo != null) {
			resultInfo.setDetails(details);
		}
		return new SubmitResultInfo(resultInfo);
	}

	public static void main(String[] args) {

	}
}
