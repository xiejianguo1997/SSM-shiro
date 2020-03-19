package com.tongyong.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.tongyong.util.Md5Util;
import com.tongyong.pojo.entity.addition.DepartmentCustom;
import com.tongyong.pojo.entity.addition.DepartmentQuery;
import com.tongyong.pojo.entity.addition.PageQuery;
import com.tongyong.pojo.entity.addition.RoleQuery;
import com.tongyong.pojo.entity.addition.UserCustom;
import com.tongyong.pojo.entity.addition.UserQuery;
import com.tongyong.pojo.entity.addition.ZTree;
import com.tongyong.pojo.entity.Role;
import com.tongyong.pojo.entity.User;
import com.tongyong.process.context.MyConfig;
import com.tongyong.process.result.DataGridResultInfo;
import com.tongyong.process.result.ResultUtil;
import com.tongyong.process.result.SubmitResultInfo;
import com.tongyong.service.IDepartmentService;
import com.tongyong.service.IRoleService;
import com.tongyong.service.IUserService;

/**
 * 用户-控制器
 * @author sunmeng
 * @date 2016年6月17日 上午9:27:35
 */
@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private IUserService userService;
	
	@Autowired
	private IDepartmentService departmentService;
	
	@Autowired
	private IRoleService roleService;
	
	//用户搜索建议数据
	@RequestMapping("/userSuggestListData")
	@ResponseBody
	public Object userSuggestListData(UserQuery userQuery) throws Exception{
		PageQuery pageQuery=new PageQuery(1, Integer.MAX_VALUE);
		userQuery.setPageQuery(pageQuery);
		
		//查询数据
		List<UserCustom> users = userService.selectList(userQuery);
		Map<String,Object> map = new HashMap<>();
		map.put("value", users);
		return map;
	}
	
	//列表页面
	@RequestMapping("/userList")
	public String userList(Model model)throws Exception{
		RoleQuery roleQuery = new RoleQuery();
		roleQuery.setPageQuery(new PageQuery(1, Integer.MAX_VALUE));
		List<Role> roles = roleService.selectList(roleQuery);
		model.addAttribute("roles", roles);
		
		return "user/userList";
	}
	

	//列表数据
	@RequestMapping("/userListData")
	@ResponseBody
	public Object userListData(UserQuery userQuery, int pageNumber, int pageSize) throws Exception{
		PageQuery pageQuery=new PageQuery(pageNumber, pageSize);
		userQuery.setPageQuery(pageQuery);
		
		//查询数据
		List<UserCustom> users = userService.selectList(userQuery);
		int count = userService.selectListCount(userQuery);
		
		DataGridResultInfo dataGridResultInfo=new DataGridResultInfo();
		dataGridResultInfo.setRows(users);
		dataGridResultInfo.setTotal(count);
		
		return dataGridResultInfo;
	}
	
	private String getDepartmentsJson(Integer deptId) throws Exception{
		DepartmentQuery departmentQuery = new DepartmentQuery();
		departmentQuery.setPageQuery(new PageQuery(1, Integer.MAX_VALUE));
		List<DepartmentCustom> departments = departmentService.selectList(departmentQuery);
		List<ZTree> zTrees = new ArrayList<ZTree>();
		ZTree tree = null;
		for (DepartmentCustom dc : departments) {
			tree = new ZTree();
			tree.setId(dc.getId());
			tree.setParentId(dc.getParentId());
			tree.setName(dc.getDeptName());
			tree.setOpen(false);
			if(dc.getId().equals(deptId)){
				tree.setChecked(true);
			}
			zTrees.add(tree);
		}
		return JSON.toJSONString(zTrees);
	}
	
	//新增页面
	@RequestMapping(value="/userAdd",method=RequestMethod.GET)
	public String userAdd(Model model)throws Exception{
		
		//查询角色列表
		PageQuery pageQuery_role = new PageQuery(1, Integer.MAX_VALUE);
		RoleQuery roleQuery = new RoleQuery();
		roleQuery.setPageQuery(pageQuery_role);
		Role role = new Role();
		role.setDataStatus(MyConfig.DATA_STATUS_YES);
		roleQuery.setRole(role);
		List<Role> roles = roleService.selectList(roleQuery);
		model.addAttribute("roles", roles);
		
		model.addAttribute("getDepartmentsJson", getDepartmentsJson(null));
		return "user/userAdd";
	}
	
	//新增提交
	@RequestMapping(value="/userAdd",method=RequestMethod.POST)
	@ResponseBody
	public SubmitResultInfo userAdd(User user)throws Exception{
		userService.insert(user);
		return ResultUtil.getSuccessSubmitResult();
	}
	
	//修改页面
	@RequestMapping(value="/userEdit",method=RequestMethod.GET)
	public String userEdit(Integer id,Model model)throws Exception{
		//根据id查询查实体
		User user = userService.selectByPrimaryKey(id);
		model.addAttribute("user", user);
		//查询角色列表
		PageQuery pageQuery_role = new PageQuery(1, Integer.MAX_VALUE);
		RoleQuery roleQuery = new RoleQuery();
		roleQuery.setPageQuery(pageQuery_role);
		Role role = new Role();
		role.setDataStatus(MyConfig.DATA_STATUS_YES);
		roleQuery.setRole(role);
		List<Role> roles = roleService.selectList(roleQuery);
		model.addAttribute("roles", roles);
		
		model.addAttribute("getDepartmentsJson", getDepartmentsJson(user.getDeptId()));
		return "user/userEdit";
	}
		
	//修改提交
	@RequestMapping(value="/userEdit",method=RequestMethod.POST)
	@ResponseBody
	public SubmitResultInfo userEdit(User user)throws Exception{
		userService.update(user);
		
		return ResultUtil.getSuccessSubmitResult();
	}
	
	//批量禁用
	@RequestMapping(value="/userBatchDisable",method=RequestMethod.POST)
	@ResponseBody
	public SubmitResultInfo userBatchDisable(int[] ids)throws Exception{
		userService.userBatchDisable(ids);
		return ResultUtil.getSuccessSubmitResult();
	}
	
	//重置密码
	@RequestMapping(value="/userResetPassword")
	@ResponseBody
	public SubmitResultInfo userResetPassword(Integer id) throws Exception{
		User user = userService.selectByPrimaryKey(id);
		//默认密码+用户原来的salt
		String password = Md5Util.md5Hex(MyConfig.INIT_PASSWORD+user.getSalt());
		user.setPassword(password);
		userService.update(user);
		return ResultUtil.getSuccessSubmitResult();
	}
	
}
