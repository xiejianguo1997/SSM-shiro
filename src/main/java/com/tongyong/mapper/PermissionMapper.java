package com.tongyong.mapper;

import java.util.List;

import com.tongyong.pojo.entity.Permission;
import com.tongyong.pojo.entity.addition.MenuTree;


/**
 *  权限-数据访问层接口
 * @author monkey
 * @date 2016年6月16日 下午5:57:10
 */
public interface PermissionMapper extends BaseMapper<Permission, Permission, Permission> {
	
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
     * 根据角色id获取权限列表
     * @author sunmeng
     * @date 2016年6月21日 上午10:32:33
     * @param roleId
     * @return
     */
	public List<Permission> selectListByRoleId(int roleId);
	
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

	public List<Permission> selectAll();
}