package com.tongyong.pojo.entity.addition;

import com.tongyong.pojo.entity.User;

/**
 * 用户-查询结果类，可以在里面扩展很多字段
 * @author monkey
 * @date 2016年6月3日 上午10:27:46
 */
public class UserCustom extends User {
	
	private String deptName;//部门名称
	
	private String posiName;//岗位名称
	
	private String roleName;//角色名称
	
	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getPosiName() {
		return posiName;
	}

	public void setPosiName(String posiName) {
		this.posiName = posiName;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

}
