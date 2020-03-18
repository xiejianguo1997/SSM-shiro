package com.tongyong.pojo.entity.addition;

import com.tongyong.pojo.entity.Department;

/**
 * 部门-查询结果的扩展类，通常继承字段较多的一个类
 * @author monkey
 * @date 2016年6月3日 上午10:48:17
 */
public class DepartmentCustom extends Department {
	
	private Integer childrenCount;

	public Integer getChildrenCount() {
		return childrenCount;
	}

	public void setChildrenCount(Integer childrenCount) {
		this.childrenCount = childrenCount;
	}
}
