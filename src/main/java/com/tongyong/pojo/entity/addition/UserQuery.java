package com.tongyong.pojo.entity.addition;

import com.tongyong.pojo.entity.User;

/**
 * 用户-查询条件类
 * @author monkey
 * @date 2016年6月14日 下午6:00:59
 */
public class UserQuery {
	
	private PageQuery pageQuery;
	private User user;
	public PageQuery getPageQuery() {
		return pageQuery;
	}
	public void setPageQuery(PageQuery pageQuery) {
		this.pageQuery = pageQuery;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
}
