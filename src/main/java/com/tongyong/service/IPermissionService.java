package com.tongyong.service;

import java.util.List;

import com.tongyong.pojo.entity.Permission;
import com.tongyong.pojo.entity.addition.MenuTree;
import com.tongyong.pojo.entity.addition.ZTree;






/**
 * 权限-业务逻辑层接口
 * @author monkey
 * @date 2016年6月16日 下午5:59:20
 */
public interface IPermissionService extends IBaseService<Permission, Permission, Permission> {

	/**
     * 根据父节点查找所有的子节点
     * @author monkey
     * @date 2016年6月16日 下午5:57:06
     * @param parentId 父节点id
     * @return 所有的子节点集合
     * @throws Exception
     */
    public List<Permission> selectListByParentId(int parentId)throws Exception;
    
	/**
	 * 根据父节点加载菜单树--角色设置权限页面使用
	 * @author monkey
	 * @date 2016年6月21日 上午9:38:38
	 * @param roleId
	 * @return
	 * @throws Exception
	 */
	public List<ZTree> selectMenuPermissionTree(Integer roleId)throws Exception;
	
	/**
	 * 根据用户id获取菜单列表
	 * @author monkey
	 * @date 2016年6月23日 上午8:43:21
	 * @param userId 用户id
	 * @return
	 * @throws Exception
	 */
	public List<MenuTree> selectMenusByUserId(int userId)throws Exception;
	
	/**
	 * 根据用户id获取用户的所有权限
	 * @author monkey
	 * @date 2016年6月23日 上午8:44:04
	 * @param userId 用户id
	 * @return
	 * @throws Exception
	 */
	public List<Permission> findPermissionListByUserId(int userId)throws Exception;
	
	/**
	 * 获取所有的菜单
	 * @author monkey
	 * @date 2016年6月23日 上午9:19:36
	 * @return
	 * @throws Exception
	 */
	public List<MenuTree> selectAllMenus()throws Exception;

	public List<Permission> selectMenusByUserIdshiro(int userId);
}
