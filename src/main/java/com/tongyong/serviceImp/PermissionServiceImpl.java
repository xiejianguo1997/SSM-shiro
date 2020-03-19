package com.tongyong.serviceImp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tongyong.mapper.PermissionMapper;
import com.tongyong.pojo.entity.Permission;
import com.tongyong.pojo.entity.addition.MenuTree;
import com.tongyong.pojo.entity.addition.ZTree;
import com.tongyong.process.context.MyConfig;
import com.tongyong.process.result.ResultUtil;
import com.tongyong.service.IPermissionService;

/**
 * 权限-业务逻辑层接口-实现类
 * 
 * @author monkey
 * @date 2016年6月16日 下午6:01:17
 */
@Service
public class PermissionServiceImpl implements IPermissionService {

	@Autowired
	private PermissionMapper permissionMapper;

	@Override
	public int insert(Permission entity) throws Exception {
		// 获取父节点
		Permission parent = this.selectByPrimaryKey(entity.getParentId());

		int permiType = 0;// 默认为菜单
		int permiLevel = 1;// 默认1级
		//判断父元素是否最后一级菜单
		if (parent.getPermiLevel() == MyConfig.LAST_MENULEVEL) {
			permiType = 1;
			permiLevel = MyConfig.OPERATION_LEVEL;
		} else {
			permiLevel = parent.getPermiLevel() + 1;
		}

		entity.setPermiType(permiType);
		entity.setPermiLevel(permiLevel);
		entity.setDataStatus(MyConfig.DATA_STATUS_YES);
		entity.setCreateTime(new Date());

		return permissionMapper.insert(entity);
	}

	@Override
	public int deleteByPrimaryKey(Integer id) throws Exception {
		//判断下面是否有子节点
		List<Permission> children=this.selectListByParentId(id);
		if(children!=null && children.size()>0){
			ResultUtil.throwCustomExcepion(102);
		}
		
		//FIXME 判断是否已经分配给角色了
		
		return permissionMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int update(Permission entity) throws Exception {
		return permissionMapper.update(entity);
	}

	@Override
	public Permission selectByPrimaryKey(Integer id) throws Exception {
		return permissionMapper.selectByPrimaryKey(id);
	}

	@Override
	public List<Permission> selectList(Permission query) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int selectListCount(Permission query) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Permission> selectListByParentId(int parentId) throws Exception {
		return permissionMapper.selectListByParentId(parentId);
	}

	/**
	 * 根据父节点加载菜单树--角色设置权限页面使用
	 * @author monkey
	 * @date 2016年6月21日 上午9:38:38
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<ZTree> selectMenuPermissionTree(Integer roleId) throws Exception {
		//根据父id获取菜单
		List<Permission> permissions= permissionMapper.selectAll();
		//角色的权限列表
		List<Permission> rolePermissions = permissionMapper.selectListByRoleId(roleId);
		List<ZTree> list=new ArrayList<ZTree>();
		for (Permission permission : permissions) {
			
			ZTree node=new ZTree();
			node.setId(permission.getId());
			node.setName(permission.getPermiName());
			node.setParentId(permission.getParentId());
			node.setOpen(true);
			//控制节点是否被选中
			for (Permission rolePermission : rolePermissions) {
				if(rolePermission.getId().equals(permission.getId())){
					node.setChecked(true);
				}
			}
			list.add(node);
		}
		return list;
	}

	@Override
	public List<MenuTree> selectMenusByUserId(int userId) throws Exception {
		
		List<MenuTree> list=new ArrayList<MenuTree>();
		//超级用户拥有所有菜单
		if (userId==1) {
			list=permissionMapper.selectAllMenus();
		}else {
			list=permissionMapper.selectMenusByUserId(userId);
		}
		
		return list;
	}

	@Override
	public List<Permission> findPermissionListByUserId(int userId) throws Exception {
		return permissionMapper.findPermissionListByUserId(userId);
	}

	@Override
	public List<MenuTree> selectAllMenus() throws Exception {
		return permissionMapper.selectAllMenus();
	}

	@Override
	public List<Permission> selectMenusByUserIdshiro(int userId) {
		return permissionMapper.selectMenusByUserIdshiro( userId);
	}

}
