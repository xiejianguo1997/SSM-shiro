package com.tongyong.serviceImp;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tongyong.exception.CustomException;
import com.tongyong.mapper.DepartmentMapper;
import com.tongyong.mapper.UserMapper;
import com.tongyong.pojo.entity.addition.LoginUser;
import com.tongyong.pojo.entity.addition.MenuTree;
import com.tongyong.pojo.entity.addition.UserCustom;
import com.tongyong.pojo.entity.addition.UserQuery;
import com.tongyong.pojo.entity.Permission;
import com.tongyong.pojo.entity.User;
import com.tongyong.process.context.MyConfig;
import com.tongyong.process.result.ResultInfo;
import com.tongyong.process.result.ResultUtil;
import com.tongyong.service.IPermissionService;
import com.tongyong.service.IUserService;
import com.tongyong.util.MD5;
import com.tongyong.util.Md5Util;
import com.tongyong.util.Util;

/**
 * 用户-业务逻辑层实现类
 * 
 * @author Administrator
 *
 */
@Service
public class UserServiceImpl implements IUserService {

	@Autowired
	private UserMapper userMapper;

	@Autowired
	private DepartmentMapper departmentMapper;
	@Autowired
	private IPermissionService permissionService;

	@Override
	public int insert(User entity) throws Exception {
		// 判断用户名是否存在
		if (isExists(entity.getUsername())) {
			ResultUtil.throwCustomExcepion(101);
		}
		String salt = Util.randomNubmer4();
		entity.setPassword(new MD5().md5(entity.getPassword() , salt));
		entity.setSalt(salt);
		entity.setCreateTime(new Date());
		entity.setDataStatus(MyConfig.DATA_STATUS_YES);
		return userMapper.insert(entity);
	}

	@Override
	public int deleteByPrimaryKey(Integer id) throws Exception {
		return userMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int update(User entity) throws Exception {
		return userMapper.update(entity);
	}

	@Override
	public User selectByPrimaryKey(Integer id) throws Exception {
		return userMapper.selectByPrimaryKey(id);
	}

	@Override
	public List<UserCustom> selectList(UserQuery query) throws Exception {
		return userMapper.selectList(query);
	}

	@Override
	public int selectListCount(UserQuery query) throws Exception {
		return userMapper.selectListCount(query);
	}

	@Override
	public boolean isExists(String username) throws Exception {
		Boolean result = true;
		int count = userMapper.selectCountByUsername(username);
		if (count == 0) {
			result = false;
		}
		return result;
	}

	@Override
	public void userBatchDisable(int[] ids) {
		userMapper.userBatchDisable(ids);
	}

	/**
	 * 根据用户名查找用户
	 * 
	 * @author monkey
	 * @date 2016年6月22日 上午10:19:13
	 * @param username
	 * @return
	 * @throws Exception
	 */
	@Override
	public UserCustom selectByUsername(String username) throws Exception {
		return userMapper.selectByUsername(username);
	}

	@Override
	public void updatePassword(Integer userId, String md5NewPassword) {
		userMapper.updatePassword(userId, md5NewPassword);
	}

	@Override
	public LoginUser authenticat(String userCode, String password) {
		/**
		 * 认证过程： 根据用户身份（账号）查询数据库，如果查询不到用户不存在 对输入的密码 和数据库密码 进行比对，如果一致，认证通过
		 */
		// 根据用户账号查询数据库
		UserCustom sysUser = null;
		try {
			sysUser = this.selectByUsername(userCode);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		if (sysUser == null) {
			// 抛出异常
			throw new CustomException(new ResultInfo(1, 1, "用户账号不存在"));
		}

		// 数据库密码 (md5密码 )
		String password_db = sysUser.getPassword();
		String salt_db = sysUser.getSalt();
		System.out.println(password_db);
		System.out.println(new MD5().md5(password, salt_db));
		System.out.println(salt_db);

		// 对输入的密码 和数据库密码 进行比对，如果一致，认证通过
		// 对页面输入的密码 进行md5加密
		String password_input_md5 = new MD5().md5(password, salt_db);

		if (!password_input_md5.equalsIgnoreCase(password_db)) {
			// 抛出异常
			throw new CustomException(new ResultInfo(1, 4, "用户名或密码 错误"));
		}
		// 得到用户id
		int userid = sysUser.getId();
		// 根据用户id查询菜单
		List<MenuTree> menus = null;
		try {
			//menus = permissionService.selectAllMenus();
			menus = permissionService.selectMenusByUserId(userid);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// 根据用户id查询权限url
		//List<Permission> permissions = null;
		try {
		//	permissions = permissionService.findPermissionListByUserId(userid);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// 认证通过，返回用户身份信息
		LoginUser activeUser = new LoginUser();
		activeUser.setUserId(sysUser.getId());
		activeUser.setUsername(userCode);
		activeUser.setRealName(sysUser.getUsername());// 用户名称
		activeUser.setRoleName(sysUser.getRoleName());
		// 放入权限范围的菜单和url
		activeUser.setMenus(menus);
		//activeUser.setPermissions(permissions);
		System.out.println("123456");
		System.out.println(menus.toString());
		System.out.println(activeUser.getMenus().toString());
		//System.out.println(permissions.toString());
		return activeUser;
	}

}
