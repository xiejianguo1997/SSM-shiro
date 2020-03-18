package com.tongyong.exception;

import com.tongyong.process.result.ResultInfo;

/**
 * 自定义统一的异常类
 * 
 * @author xie
 * @date 2016年6月3日 上午11:30:53
 */
public class CustomException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2022891679933859197L;

	// 系统统一使用的结果类，包括了 提示信息类型和信息内容
	private ResultInfo resultInfo;

	public CustomException(ResultInfo resultInfo) {
		super(resultInfo.getMessage());//把错误消息传出去
		this.resultInfo = resultInfo;
	}

	public ResultInfo getResultInfo() {
		return resultInfo;
	}

	public void setResultInfo(ResultInfo resultInfo) {
		this.resultInfo = resultInfo;
	}

}
