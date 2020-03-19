package com.tongyong.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tongyong.pojo.entity.addition.ZTree;
import com.tongyong.pojo.entity.Permission;
import com.tongyong.process.result.DataGridResultInfo;
import com.tongyong.process.result.ResultUtil;
import com.tongyong.process.result.SubmitResultInfo;
import com.tongyong.service.IPermissionService;

/**
 * 目录权限-控制器
 * 
 * @author monkey
 * @date 2016年6月16日 下午6:37:38
 */
@Controller
@RequestMapping("/permission")
public class PermissionController {

	@Autowired
	private IPermissionService permissionService;
	
	// 列表页面
	@RequiresPermissions("perimission:query")
	@RequestMapping("/permissionList")
	public String permissionList() {
		return "permission/permissionList";
	}

	// 列表数据- 根据父id获取菜单和权限
	@RequiresPermissions("perimission:query")
	@RequestMapping("/getMenuPermission")
	@ResponseBody
	public Object getMenuPermission(String parentId) throws Exception {
		if (StringUtils.isBlank(parentId)) {
			parentId = "1";
		}

		List<Permission> list = permissionService.selectListByParentId(Integer.parseInt(parentId));
		int count = list.size();

		DataGridResultInfo dataGridResultInfo = new DataGridResultInfo();
		dataGridResultInfo.setRows(list);
		dataGridResultInfo.setTotal(count);

		return dataGridResultInfo;
	}
	
	//列表页面的数据
	@RequiresPermissions("perimission:query")
	@RequestMapping("/permissionTreeJson")
	@ResponseBody
	public Object permissionTreeJson(String id) throws Exception {
		Integer pid = 0;
		if (id != null && !id.equals("")) {
			pid = Integer.parseInt(id);
		}

		List<Permission> list = permissionService.selectListByParentId(pid);
		
		List<ZTree> zTrees = new ArrayList<ZTree>();
		ZTree tree = null;
		for (Permission p : list) {
			tree = new ZTree();
			tree.setId(p.getId());
			tree.setIsParent(true);
			tree.setName(p.getPermiName());
			tree.setOpen(true);
			zTrees.add(tree);
		}
		return zTrees;
	}

	// 新增页面
	@RequiresPermissions("perimission:add")
	@RequestMapping(value = "/permissionAdd", method = RequestMethod.GET)
	public String add(String pid, Model model) throws Exception {
		if (StringUtils.isBlank(pid)) {
			pid = "1";
		}

		// 根据父id获取父菜单
		Permission permission = permissionService.selectByPrimaryKey(Integer.parseInt(pid));
		model.addAttribute("parentPermi", permission);

		return "permission/permissionAdd";
	}

	// 新增提交
	@RequiresPermissions("perimission:add")
	@RequestMapping(value = "/permissionAdd", method = RequestMethod.POST)
	@ResponseBody
	public Object permissionAdd(Permission permission) throws Exception {

		permissionService.insert(permission);

		return ResultUtil.getSuccessSubmitResult();
	}

	// 修改页面
	@RequiresPermissions("perimission:update")
	@RequestMapping(value = "/permissionEdit", method = RequestMethod.GET)
	public String permissionEdit(Integer id, Model model) throws Exception {

		Permission permission = permissionService.selectByPrimaryKey(id);
		model.addAttribute("permission", permission);

		return "permission/permissionEdit";
	}

	// 修改提交
	@RequiresPermissions("perimission:update")
	@RequestMapping(value = "/permissionEdit", method = RequestMethod.POST)
	@ResponseBody
	public Object permissionEdit(Permission permission) throws Exception {

		permissionService.update(permission);

		return ResultUtil.getSuccessSubmitResult();
	}

	// 删除
	@RequiresPermissions("perimission:delete")
	@RequestMapping("/deleteList")
	@ResponseBody
	public SubmitResultInfo deleteList(String[] ids) throws Exception {

		if (ids != null && ids.length > 0) {
			permissionService.deleteByPrimaryKey(Integer.parseInt(ids[0]));
		}

		return ResultUtil.getSuccessSubmitResult();
	}

}
