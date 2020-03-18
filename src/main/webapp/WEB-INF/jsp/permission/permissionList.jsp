<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="projectPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>权限管理</title>

    <link href="${projectPath }/css/bootstrap.min.css" rel="stylesheet">
    <link href="${projectPath }/css/font-awesome.min.css" rel="stylesheet">
    <link href="${projectPath }/css/plugins/ztree/metroStyle/metroStyle.css" rel="stylesheet"/>
    <link href="${projectPath }/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
    <link href="${projectPath }/css/animate.min.css" rel="stylesheet">
    <link href="${projectPath }/css/style.min.css" rel="stylesheet">

</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-3">
		        <!-- Panel Other -->
		        <div class="ibox float-e-margins">
		            <div class="ibox-title">
		                <h5>权限树形列表</h5>
		                <div class="ibox-tools">
		                    <a class="collapse-link">
		                        <i class="fa fa-chevron-up"></i>
		                    </a>
		                </div>
		            </div>
		            <div class="ibox-content">
		                <div class="row row-lg">
		                    <div class="col-sm-12">
		                        <!-- Example Card View -->
		                        <div class="example-wrap">
		                            <h4 class="example-title"></h4>
		                            <div class="example">
		                            	<ul id="tree" class="ztree"></ul>
		                            </div>
		                        </div>
		                        <!-- End Example Card View -->
		                    </div>
		                </div>
		            </div>
		        </div>
		        <!-- End Panel Other -->
	        </div>
	        <div class="col-sm-9">
		        <!-- Panel Other -->
		        <div class="ibox float-e-margins">
		            <div class="ibox-title">
		                <h5>权限列表</h5>
		                <div class="ibox-tools">
		                    <a class="collapse-link">
		                        <i class="fa fa-chevron-up"></i>
		                    </a>
		                </div>
		            </div>
		            <div class="ibox-content">
		                <div class="row row-lg">
		                    <div class="col-sm-12">
		                        <!-- Example Card View -->
		                        <div class="example-wrap">
		                            <h4 class="example-title"></h4>
		                            <div class="example">
		                            	<div class="btn-group hidden-xs" id="exampleToolbar" role="group">
		                                    <button id="add" type="button" class="btn btn-outline btn-default" title="添加">
		                                        <i class="glyphicon glyphicon-plus" aria-hidden="true"></i>
		                                    </button>
		                                    <button id="edit" type="button" class="btn btn-outline btn-default" title="编辑">
		                                        <i class="glyphicon glyphicon-edit" aria-hidden="true"></i>
		                                    </button>
		                                    <button id="del" type="button" class="btn btn-outline btn-default" title="删除">
		                                        <i class="glyphicon glyphicon-trash" aria-hidden="true"></i>
		                                    </button>
		                                </div>
		                            	<table id="permissionListTable" 
		                                data-toggle="table"
		                                data-method="post"
		                                data-url="${projectPath }/permission/getMenuPermission.action" 
		                                data-content-type="application/x-www-form-urlencoded"
		                                data-query-params-type=""
								    	data-pagination="true"
								    	data-side-pagination="server"
								        data-toolbar="#exampleToolbar"
								        data-show-export="true"
								        data-id-field="id"
								        data-show-refresh="false"
								        data-click-to-select="true"
								       	data-single-select="true"
								       	data-icon-size="outline"
								       	data-query-params="queryParams"
								        data-show-footer="false"
		                                data-mobile-responsive="true">
		                                    <thead>
		                                        <tr>
		                                        	<th data-checkbox="true" data-align="center"></th>
		                                            <th data-field="permiName" data-align="center">权限名称</th>
		                                            <th data-field="url" data-align="center">地址</th>
		                                            <th data-field="permiType" data-align="center" data-formatter="permiTypeFormatter">类型</th>
		                                            <th data-field="permiLevel" data-align="center">级别</th>
		                                            <th data-field="sort" data-align="center">排序值</th>
		                                            <th data-field="description" data-align="center">描述</th>
		                                            <th data-field="createTime" data-align="center">创建时间</th>
		                                        </tr>
		                                    </thead>
		                                </table>
		                            </div>
		                        </div>
		                        <!-- End Example Card View -->
		                    </div>
		                </div>
		            </div>
		        </div>
		        <!-- End Panel Other -->
	        </div>
        </div>
    </div>
    <script src="${projectPath }/js/jquery.min.js"></script>
    <script src="${projectPath }/js/bootstrap.min.js"></script>
    <script src="${projectPath }/js/content.min.js"></script>
    <script src="${projectPath }/js/plugins/layui/layer/layer.js" ></script>
    <script src="${projectPath }/js/plugins/bootstrap-table/bootstrap-table.min.js" ></script>
    <script src="${projectPath }/js/plugins/bootstrap-table/bootstrap-table-mobile.min.js"></script>
    <script src="${projectPath }/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
    <script src="${projectPath }/js/plugins/ztree/jquery.ztree.all.min.js"></script>
    <script src="${projectPath }/js/common.js"></script>
    <script type="text/javascript">
    var setting = {
			view: {
				selectedMulti: false
			},
				async: {
				enable: true,
				autoParam:["id"],
				dataType:"JSON",
				url:"${projectPath}/permission/permissionTreeJson.action"
			},
			callback: {
				onClick: function(event,treeId,treeNode){
					var query = {'parentId':treeNode.id};
					$("#permissionListTable").bootstrapTable('refresh',{query:query});
				}
			}
	};
	
	var tree = $.fn.zTree.init($("#tree"), setting);
	
	$(document).on('click','#add',function(){
		var treeObj = $.fn.zTree.getZTreeObj("tree");
		var nodes = treeObj.getSelectedNodes();
		var pid = nodes.length>0?nodes[0].id:'';
		layer.open({
			type: 2, 
			title:'添加权限',
			area: ['800px', '550px'],
			content: '${projectPath}/permission/permissionAdd.action?pid='+pid
		});
	});
	
	$(document).on('click','#edit',function(){
		var rows = $("#permissionListTable").bootstrapTable('getSelections');
		if(rows.length==0){
			layer.alert('请选择一行编辑',{icon:0});
			return false;
		}
		layer.open({
			type: 2, 
			title:'编辑权限',
			area: ['800px', '550px'],
			content: '${projectPath}/permission/permissionEdit.action?id='+rows[0].id
		});
	});
	
	$(document).on('click','#del',function(){
		var rows = $("#permissionListTable").bootstrapTable('getSelections');
		if(rows.length==0){
			layer.alert('请选择一行',{icon:0});
			return false;
		}
		layer.confirm('确定删除这条记录吗？', function(index){
			layer.close(index);
			var ids = '';
			
			$.ajax({
				type:"POST",
				url:'${projectPath}/permission/deleteList.action',
				data:{ids:rows[0].id},
				success:function(data){
					if(data.resultInfo.success){
						var treeObj = $.fn.zTree.getZTreeObj("tree");
						var nodes = treeObj.getSelectedNodes();
						treeObj.reAsyncChildNodes(nodes[0], 'refresh', true);
						
						$("#permissionListTable").bootstrapTable("refresh",{query:{parentId:nodes[0].id}});
						layer.alert(data.resultInfo.message,{icon: 1});
					}
				}
			}); 
		}); 
	});
	
	
	function permiTypeFormatter(value,row,index){
		if(value==0)return '菜单';
		else if(value==1)return '按钮';
	}
	
	function queryParams(params){
    	var b= $.extend({},params);
    	return b;
    }
    </script>
</body>

</html>