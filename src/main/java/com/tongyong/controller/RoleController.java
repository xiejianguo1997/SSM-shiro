package com.tongyong.controller;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.tongyong.pojo.entity.addition.PageQuery;
import com.tongyong.pojo.entity.addition.RoleQuery;
import com.tongyong.pojo.entity.Role;
import com.tongyong.process.result.DataGridResultInfo;
import com.tongyong.process.result.ResultUtil;
import com.tongyong.process.result.SubmitResultInfo;
import com.tongyong.service.IPermissionService;
import com.tongyong.service.IRoleService;

/**
 * 角色-控制器
 * 
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/role")
public class RoleController {

	@Autowired
	private IRoleService roleService;
	@Autowired
	private IPermissionService permissionService;

	// 列表页面
	@RequestMapping("/roleList")
	public String roleList() throws Exception {
		return "role/roleList";
	}

	// 列表数据
	@RequiresPermissions("role:query")
	@RequestMapping("/roleListData")
	@ResponseBody
	public Object roleListData(RoleQuery roleQuery, int pageNumber, int pageSize) throws Exception {
		PageQuery pageQuery = new PageQuery(pageNumber, pageSize);
		roleQuery.setPageQuery(pageQuery);

		// 查询数据
		List<Role> roles = roleService.selectList(roleQuery);
		int count = roleService.selectListCount(roleQuery);

		DataGridResultInfo dataGridResultInfo = new DataGridResultInfo();
		dataGridResultInfo.setRows(roles);
		dataGridResultInfo.setTotal(count);
		return dataGridResultInfo;
	}

	// 新增页面
	@RequiresPermissions("role:add")
	@RequestMapping(value = "/roleAdd", method = RequestMethod.GET)
	public String roleAdd(Model model) throws Exception {
		return "role/roleAdd";
	}

	// 新增提交
	@RequiresPermissions("role:add")
	@RequestMapping(value = "/roleAdd", method = RequestMethod.POST)
	@ResponseBody
	public SubmitResultInfo roleAdd(Role role) throws Exception {
		roleService.insert(role);
		return ResultUtil.getSuccessSubmitResult();
	}

	// 修改页面
	@RequiresPermissions("role:edit")
	@RequestMapping(value = "/roleEdit", method = RequestMethod.GET)
	public String roleEdit(Integer id, Model model) throws Exception {
		// 根据id查询查实体
		Role role = roleService.selectByPrimaryKey(id);
		model.addAttribute("role", role);
		
		return "role/roleEdit";
	}

	// 修改提交
	@RequiresPermissions("role:edit")
	@RequestMapping(value = "/roleEdit", method = RequestMethod.POST)
	@ResponseBody
	public SubmitResultInfo roleEdit(Role role) throws Exception {

		roleService.update(role);

		return ResultUtil.getSuccessSubmitResult();
	}

	// 批量删除
	@RequiresPermissions("role:delete")
	@RequestMapping(value = "/roleBatchDisable", method = RequestMethod.POST)
	@ResponseBody
	public SubmitResultInfo roleBatchDisable(int[] ids) throws Exception {
		roleService.roleBatchDisable(ids);
		return ResultUtil.getSuccessSubmitResult();
	}

	// 为角色设置权限-页面
	@RequiresPermissions("perimission:update")
	@RequestMapping(value = "/setPerimission", method = RequestMethod.GET)
	public String setPerimission(Integer roleId, Model model) throws Exception {
		model.addAttribute("roleId", roleId);// 角色id
		
		model.addAttribute("rolePerimissionJson", JSON.toJSONString(permissionService.selectMenuPermissionTree(roleId)));
		return "role/setPerimission";
	}

	// 为角色设置权限-动作
	@RequiresPermissions("perimission:update")
	@RequestMapping(value = "/setPerimission", method = RequestMethod.POST)
	@ResponseBody
	public Object setPerimission(Integer roleId, String menuIds) throws Exception {
//		roleService.deleteBatchByRoleId(roleId);
//		roleService.insertRolePermissionBatch(roleId, menuIds);
		roleService.setPermission(roleId, menuIds);
		return ResultUtil.getSuccessSubmitResult();
	}
}
