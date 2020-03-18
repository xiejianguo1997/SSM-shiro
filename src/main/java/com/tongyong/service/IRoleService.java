package com.tongyong.service;

import java.util.List;

import com.tongyong.pojo.entity.addition.RoleQuery;
import com.tongyong.pojo.entity.Role;
import com.tongyong.pojo.entity.RolePermission;

/**
 * 角色-业务逻辑层接口
 * @author monkey
 * @date 2016年6月14日 下午6:56:07
 */
public interface IRoleService extends IBaseService<Role, RoleQuery, Role> {

	/**
	 * 判断名称是已经存在
	 * @param name
	 * @return
	 * @throws Exception
	 */
	boolean isExists(String name)throws Exception;

	/**
	 * 批量禁用
	 * @param id
	 */
	void roleBatchDisable(int... ids);
	
    /**
     * 为角色设置权限时先删除该角色的所有权限
     * @author monkey
     * @date 2016年6月21日 上午9:47:22
     * @param roleId
     * @return
     * @throws Exception
     */
    public int deleteBatchByRoleId(int roleId)throws Exception;
    
    /**
     * 为角色分配权限，根据角色id和菜单权限id集合批量插入
     * 
     * @author monkey
     * @date 2016年6月21日 上午9:47:51
     * @param roleId 角色id
     * @param menuIds 菜单id集合
     * @throws Exception
     */
    public void insertRolePermissionBatch(int roleId, String menuIds)throws Exception;
    
    /**
     * 批量插入角色权限关联表数据
     * @author monkey
     * @date 2016年6月21日 上午9:56:51
     * @param list
     * @throws Exception
     */
    public void insertBatch(List<RolePermission> list)throws Exception;

    /**
     * 设置角色权限
     * @author sunmeng
     * @date 2016年6月21日 上午11:26:46
     * @param roleId
     * @param menuIds
     */
	void setPermission(int roleId, String menuIds) throws Exception;
}
