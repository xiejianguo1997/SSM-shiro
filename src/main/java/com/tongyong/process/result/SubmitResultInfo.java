package com.tongyong.process.result;

/**
 * 系统提交后统一响应结果类型
 * 
 * @author monkey
 * @date 2016年6月6日 下午6:27:45
 */
public class SubmitResultInfo {
	public SubmitResultInfo(ResultInfo resultInfo){
		this.resultInfo = resultInfo;
	}
	
	//操作结果信息
	private ResultInfo resultInfo;
	
	public ResultInfo getResultInfo() {
		return resultInfo;
	}

	public void setResultInfo(ResultInfo resultInfo) {
		this.resultInfo = resultInfo;
	}
}
