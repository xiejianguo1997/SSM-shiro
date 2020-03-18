package com.tongyong.pojo.entity.addition;

import com.tongyong.pojo.entity.Role;

/**
 * 角色-查询条件类
 * @author monkey
 * @date 2016年6月14日 下午6:32:46
 */
public class RoleQuery {
	
	private PageQuery pageQuery;
	private Role role;
	public PageQuery getPageQuery() {
		return pageQuery;
	}
	public void setPageQuery(PageQuery pageQuery) {
		this.pageQuery = pageQuery;
	}
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
}
