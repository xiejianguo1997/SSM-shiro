package com.tongyong.serviceImp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tongyong.mapper.RoleMapper;
import com.tongyong.pojo.entity.addition.RoleQuery;
import com.tongyong.pojo.entity.Role;
import com.tongyong.pojo.entity.RolePermission;
import com.tongyong.process.context.MyConfig;
import com.tongyong.process.result.ResultUtil;
import com.tongyong.service.IRoleService;

/**
 * 角色-业务逻辑层接口-实现类
 * @author monkey
 * @date 2016年6月14日 下午6:57:31
 */
@Service
public class RoleServiceImpl implements IRoleService {

	@Autowired
	private RoleMapper roleMapper;
	
	@Override
	public int insert(Role entity) throws Exception {
		
		// 判断角色名称是否存在
		if(isExists(entity.getRoleName())){
			ResultUtil.throwCustomExcepion(101);
		}
		
		entity.setDataStatus(MyConfig.DATA_STATUS_YES);
		entity.setCreateTime(new Date());
		return roleMapper.insert(entity);
	}

	@Override
	public int deleteByPrimaryKey(Integer id) throws Exception {
		return roleMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int update(Role entity) throws Exception {
		//原来的等于现在的，那么可以修改
		Role oldRole = roleMapper.selectByPrimaryKey(entity.getId());
		if(oldRole.getRoleName().equals(entity.getRoleName())){
			return roleMapper.update(entity);
		}
		//原来的不等于现在的，检查名称不能重复
		if(isExists(entity.getRoleName())){
			ResultUtil.throwCustomExcepion(101);
		}
		return roleMapper.update(entity);
	}

	@Override
	public Role selectByPrimaryKey(Integer id) throws Exception {
		return roleMapper.selectByPrimaryKey(id);
	}

	@Override
	public List<Role> selectList(RoleQuery query) throws Exception {
		return roleMapper.selectList(query);
	}

	@Override
	public int selectListCount(RoleQuery query) throws Exception {
		return roleMapper.selectListCount(query);
	}

	@Override
	public boolean isExists(String name) throws Exception {
		Boolean result=true;
		int count = roleMapper.selectCountByName(name);
		if (count==0) {
			result=false;
		}
		return result;
	}

	@Override
	public void roleBatchDisable(int... ids) {
		roleMapper.roleBatchDisable(ids);
	}

	/**
     * 为角色设置权限时先删除该角色的所有权限
     * @author monkey
     * @date 2016年6月21日 上午9:47:22
     * @param roleId
     * @return
     * @throws Exception
     */
	@Override
	public int deleteBatchByRoleId(int roleId) throws Exception {
		return roleMapper.deleteBatchByRoleId(roleId);
	}

	/**
     * 为角色分配权限，根据角色id和菜单权限id集合批量插入
     * 
     * @author monkey
     * @date 2016年6月21日 上午9:47:51
     * @param roleId 角色id
     * @param menuIds 菜单id集合
     * @throws Exception
     */
	@Override
	public void insertRolePermissionBatch(int roleId, String menuIds) throws Exception {
		//先去掉结尾的分隔符
		if (menuIds!=null&&!menuIds.equals("")) {
			//去掉最后的逗号
			menuIds=menuIds.substring(0, menuIds.length()-1);
			
			//装配list
			List<RolePermission> list=new ArrayList<RolePermission>();
			String[] ids=menuIds.split(",");
			for (String id : ids) {
				RolePermission rolemenu=new RolePermission();
				rolemenu.setRoleId(roleId);
				rolemenu.setPermissionId(Integer.valueOf(id));
				list.add(rolemenu);
			}
			
			//执行插入
			this.insertBatch(list);
		}
	}

	/**
     * 批量插入角色权限关联表数据
     * @author monkey
     * @date 2016年6月21日 上午9:56:51
     * @param list
     * @throws Exception
     */
	@Override
	public void insertBatch(List<RolePermission> list) throws Exception {
		roleMapper.insertBatch(list);
	}

	@Override
	public void setPermission(int roleId, String menuIds) throws Exception {
		this.deleteBatchByRoleId(roleId);
		this.insertRolePermissionBatch(roleId, menuIds);
	}

}
