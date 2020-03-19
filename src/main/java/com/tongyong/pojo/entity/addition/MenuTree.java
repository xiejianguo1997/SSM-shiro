package com.tongyong.pojo.entity.addition;

import java.util.List;

/**
 * 系统菜单树-登录后用
 * @author monkey
 * @date 2016年6月22日 下午5:36:38
 */
public class MenuTree {

	/**
	 * 二级菜单
	 */
	private List<MenuTree> menus;
	
	/**
	 * 菜单id、模块id
	 */
	private String menuid;
	
	/**
	 * 菜单图标
	 */
	private String icon;
	
	/**
	 * 菜单名称/模块名称
	 */
	private String menuname;
	
	/**
	 * 菜单链接
	 */
	private String url;

	public List<MenuTree> getMenus() {
		return menus;
	}

	public void setMenus(List<MenuTree> menus) {
		this.menus = menus;
	}

	public String getMenuid() {
		return menuid;
	}

	public void setMenuid(String menuid) {
		this.menuid = menuid;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getMenuname() {
		return menuname;
	}

	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Override
	public String toString() {
		return "MenuTree [menus=" + menus + ", menuid=" + menuid + ", icon=" + icon + ", menuname=" + menuname
				+ ", url=" + url + "]";
	}
	
}
