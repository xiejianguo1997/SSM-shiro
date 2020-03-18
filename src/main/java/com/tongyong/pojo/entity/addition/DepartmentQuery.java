package com.tongyong.pojo.entity.addition;

import com.tongyong.pojo.entity.Department;

/**
 * 部门-查询条件类
 * 
 * @author monkey
 * @date 2016年6月3日 上午10:46:56
 */
public class DepartmentQuery {
	// 分页对象
	private PageQuery pageQuery;

	// 包装这个字段进来，是为了方便查询
	private Department department;
	
	public PageQuery getPageQuery() {
		return pageQuery;
	}

	public void setPageQuery(PageQuery pageQuery) {
		this.pageQuery = pageQuery;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}
}
