package com.tongyong.process.context;

/**
 * 基础配置类
 * @author sunmeng
 * @date 2017年7月5日上午11:19:00
 */
public class MyConfig {
	
	/**
	 * 提示信息配置文件名
	 */
	public static final String MESSAGE = "resources.messages";
	
	/**
	 * 公共权限，登录后即可访问，不需要权限
	 */
	public static final String COMMON_URL = "properties.commonUrl";
	
	/**
	 * 匿名权限，用户无需登录即可访问
	 */
	public static final String ANONYMOUS_URL = "properties.anonymousUrl";

	/**
	 * session中存放登录用户的key名称
	 */
	public static final String LOGINUSER_KEY = "loginUser";
	
	/**
	 * session中存放登录从业人员的key名称
	 */
	public static final String LOGIN_EMPLOYEE_KEY = "loginEmployee";
	
	/**
	 * 顶级菜单的level
	 */
	public static final int ROOT_MENULEVEL=1;
	
	/**
	 * 二级菜单的level
	 */
	public static final int PARENT_MENULEVEL=2;
	
	/**
	 * 最后一级菜单的level
	 */
	public static final int LAST_MENULEVEL=3;
	
	/**
	 * 操作按钮的level
	 */
	public static final int OPERATION_LEVEL=0;
	
	/**
	 * 数据状态可用
	 */
	public static final int DATA_STATUS_YES=1;
	
	/**
	 * 登录失效
	 */
	public static final int LOGIN_FAILURE=106;
	
	/**
	 * 没有操作权限
	 */
	public static final int NO_PERMISSION=103;
	
	/**
	 * 错误页面
	 */
	public static final String ERROR_PAGE_URL="500";
	
	/**
	 * 退出跳转页面
	 */
	public static final String LOGOUT_PAGE_URL="logout";
	
	/**
	 * 没有权限，访问被拒绝跳转页面
	 */
	public static final String REFUSE_PAGE_URL="refuse";
	
	/**
	 * 用户初始密码
	 */
	public static final String INIT_PASSWORD = "123456";

	/**
	 * 客运企业负责人角色
	 */
	public static final int ROLE_PASSENGER_TRANSPORT_RESPONSIBILITY = 1;
	
	/**
	 * 客运安全员角色
	 */
	public static final int ROLE_PASSENGER_TRANSPORT_SECURITY = 2;
	
	/**
	 * 货运企业负责人角色
	 */
	public static final int ROLE_GOODS_TRANSPORT_RESPONSIBILITY = 5;
	
	/**
	 * 货运安全员角色
	 */
	public static final int ROLE_GOODS_TRANSPORT_SECURITY = 6;
	
	/**
	 * 公路客运行业
	 */
	public static final int INDUSTRY_PASSENGER_TRANSPORT = 1;
	
	/**
	 * 危险品货运行业
	 */
	public static final int INDUSTRY_GOODS_TRANSPORT = 2;
	
	/**
	 * session中存放视频学习的照片ID
	 */
	public static final String COURSE_PHOTO_ID = "coursePhotoId";

	/**
	 * session中存放测评学习的照片ID
	 */
	public static final String EXAM_PHOTO_ID= "examPhotoId";
	
	/**
	 * 获取企业负责人角色id
	 * @param industryId 行业id
	 * @return
	 */
	public static int getResponsibilityRoleId(int industryId){
		switch (industryId) {
		case INDUSTRY_PASSENGER_TRANSPORT:
			return ROLE_PASSENGER_TRANSPORT_RESPONSIBILITY;
		case INDUSTRY_GOODS_TRANSPORT:
			return ROLE_GOODS_TRANSPORT_RESPONSIBILITY;
		}
		return 0;
	}
	
	/**
	 * 获取企业安全员角色id
	 * @param industryId 行业id
	 * @return
	 */
	public static int getSecurityRoleId(int industryId){
		switch (industryId) {
		case INDUSTRY_PASSENGER_TRANSPORT:
			return ROLE_PASSENGER_TRANSPORT_SECURITY;
		case INDUSTRY_GOODS_TRANSPORT:
			return ROLE_GOODS_TRANSPORT_SECURITY;
		}
		return 0;
	}
}
