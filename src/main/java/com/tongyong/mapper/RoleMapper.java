package com.tongyong.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.tongyong.pojo.entity.addition.RoleQuery;
import com.tongyong.pojo.entity.Role;
import com.tongyong.pojo.entity.RolePermission;

/**
 * 角色-数据访问层接口
 * @author monkey
 * @date 2016年6月14日 下午6:51:42
 */
public interface RoleMapper extends BaseMapper<Role, RoleQuery, Role> {

	/**
	 * 根据名称查询记录数
	 * @param name
	 * @return
	 */
	int selectCountByName(String name);

	/**
	 * 批量禁用
	 * @param id
	 */
	void roleBatchDisable(@Param("ids")int... ids);
	
    /**
     * 为角色设置权限时先删除该角色的所有权限
     * @author monkey
     * @date 2016年6月21日 上午9:51:02
     * @param roleId
     * @return
     * @throws Exception
     */
    public int deleteBatchByRoleId(int roleId)throws Exception;
    
    /**
     * 批量插入角色权限关联表数据
     * @author monkey
     * @date 2016年6月21日 上午9:58:28
     * @param list
     * @throws Exception
     */
    public void insertBatch(List<RolePermission> list)throws Exception;
}