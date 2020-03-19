package com.tongyong.shiro;

import java.util.ArrayList;
import java.util.List;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import com.tongyong.pojo.entity.Permission;
import com.tongyong.pojo.entity.addition.LoginUser;
import com.tongyong.pojo.entity.addition.MenuTree;
import com.tongyong.pojo.entity.addition.UserCustom;
import com.tongyong.service.IPermissionService;
import com.tongyong.service.IUserService;

/**
 * 
 * <p>
 * Title: CustomRealm
 * </p>
 * <p>
 * Description:自定义realm
 * </p>
 * 
 * @author 
 * @date 2015-3-23下午4:54:47
 * @version 1.0
 */
public class CustomRealm extends AuthorizingRealm {
	
	//注入service
	//@Autowired
	//private SysService sysService;
	@Autowired
	private IUserService userService;

	@Autowired
	private IPermissionService permissionService;
	// 设置realm的名称
	@Override
	public void setName(String name) {
		super.setName("customRealm");
	}

	// 用于认证
	//没有连接数据库的方法
	/*@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken token) throws AuthenticationException {
		
		// token是用户输入的用户名和密码 
		// 第一步从token中取出用户名
		String userCode = (String) token.getPrincipal();

		// 第二步：根据用户输入的userCode从数据库查询
		// ....
	

		// 如果查询不到返回null
		//数据库中用户账号是zhangsansan
		if(!userCode.equals("zhangsansan")){//
			return null;
		}
		
		
		// 模拟从数据库查询到密码
		String password = "111111";

		// 如果查询到返回认证信息AuthenticationInfo
		
		//activeUser就是用户身份信息
		ActiveUser activeUser = new ActiveUser();
		
		activeUser.setUserid("zhangsan");
		activeUser.setUsercode("zhangsan");
		activeUser.setUsername("张三");
		//..
		
		//根据用户id取出菜单
		//通过service取出菜单 
		List<SysPermission> menus  = null;
		try {
			menus = sysService.findMenuListByUserId("zhangsan");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//将用户菜单 设置到activeUser
		activeUser.setMenus(menus);
		
		
		//将activeUser设置simpleAuthenticationInfo
		SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(
				activeUser, password, this.getName());

		return simpleAuthenticationInfo;
	}*/
	
	//realm的认证方法，从数据库查询用户信息
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken token) throws AuthenticationException {
		
		// token是用户输入的用户名和密码 
		// 第一步从token中取出用户名
		String userCode = (String) token.getPrincipal();

		// 第二步：根据用户输入的userCode从数据库查询
		UserCustom userCustom = null;
		try {
			userCustom = userService.selectByUsername(userCode);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		// 如果查询不到返回null
		if(userCustom==null){//
			return null;
		}
		// 从数据库查询到密码
		String password = userCustom.getPassword();
		
		//盐
		String salt = userCustom.getSalt();

		// 如果查询到返回认证信息AuthenticationInfo
		
		//activeUser就是用户身份信息
		//ActiveUser activeUser = new ActiveUser();
		
		//activeUser.setUserid(userCustom.getId());
		//activeUser.setUsercode(userCustom.getUsercode());
		//activeUser.setUsername(userCustom.getUsername());
		//..
		//登录的用户用这个封装类
		LoginUser loginUser=new LoginUser();
		loginUser.setUserId(userCustom.getId());
		loginUser.setUsername(userCustom.getUsername());
		loginUser.setRealName(userCustom.getRealName());
		loginUser.setDeptId(userCustom.getDeptId());
		loginUser.setPosiId(userCustom.getPosiId());
		loginUser.setRoleId(userCustom.getRoleId());
		loginUser.setRoleName(userCustom.getRoleName());
		//根据用户id取出菜单
		List<MenuTree> menus  = null;
		try {
			//通过service取出菜单 
			menus = permissionService.selectMenusByUserId(loginUser.getUserId());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//将用户菜单 设置到activeUser
		loginUser.setMenus(menus);
		System.out.println(menus);
		//将activeUser设置simpleAuthenticationInfo
		SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(
				loginUser, password,ByteSource.Util.bytes(salt), this.getName());

		return simpleAuthenticationInfo;
	}
	
	

	// 用于授权
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(
			PrincipalCollection principals) {
		
		//从 principals获取主身份信息
		//将getPrimaryPrincipal方法返回值转为真实身份类型（在上边的doGetAuthenticationInfo认证通过填充到SimpleAuthenticationInfo中身份类型），
		LoginUser activeUser =  (LoginUser) principals.getPrimaryPrincipal();
		
		//根据身份信息获取权限信息
		//从数据库获取到权限数据
		List<Permission> permissionList = null;
		try {
			permissionList = permissionService.selectMenusByUserIdshiro(activeUser.getUserId());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//单独定一个集合对象 
		List<String> permissions = new ArrayList<String>();
		if(permissionList!=null){
			for(Permission sysPermission:permissionList){
				//将数据库中的权限标签 符放入集合
				permissions.add(sysPermission.getPercode());
			}
		}
		
		
	/*	List<String> permissions = new ArrayList<String>();
		permissions.add("user:create");//用户的创建
		permissions.add("item:query");//商品查询权限
		permissions.add("item:add");//商品添加权限
		permissions.add("item:edit");//商品修改权限
*/		//....
		
		//查到权限数据，返回授权信息(要包括 上边的permissions)
		SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
		//将上边查询到授权信息填充到simpleAuthorizationInfo对象中
		simpleAuthorizationInfo.addStringPermissions(permissions);

		return simpleAuthorizationInfo;
	}
	
	//清除缓存
	public void clearCached() {
		PrincipalCollection principals = SecurityUtils.getSubject().getPrincipals();
		super.clearCache(principals);
	}


}

