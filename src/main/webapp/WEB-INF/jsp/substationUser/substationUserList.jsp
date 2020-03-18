<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="projectPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>分局管理</title>

    <link href="${projectPath }/css/bootstrap.min.css" rel="stylesheet">
    <link href="${projectPath }/css/font-awesome.min.css" rel="stylesheet">
    <link href="${projectPath }/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
    <link href="${projectPath }/css/animate.min.css" rel="stylesheet">
    <link href="${projectPath }/css/style.min.css" rel="stylesheet">

</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">

        <!-- Panel Other -->
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>分局列表</h5>
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
                            	<form id="search-form" class="form-inline" role="form">
								    <!-- <div class="form-group">
						    		    <label>姓名：</label>
						    		    <input type="text" name="substationUser.realName" class="form-control">
						  		    </div>
						  		    <div class="form-group">
						    		    <label>状态：</label>
						    		    <select name="substationUser.dataStatus" class="form-control">
						    		    	<option value="">请选择</option>
						    		    	<option value="0">禁用</option>
						    		    	<option value="1">启用</option>
						    		    </select>
						  		    </div>
						  		    <button id="search" type="button" class="btn btn-success">搜索</button> -->
								</form>
                            	<div class="btn-group hidden-xs" id="exampleToolbar" role="group">
                                    <button id="add" type="button" class="btn btn-outline btn-default" title="添加">
                                        <i class="glyphicon glyphicon-plus" aria-hidden="true"></i>  添加
                                    </button>
                                    <button id="edit" type="button" class="btn btn-outline btn-default" title="编辑">
                                        <i class="glyphicon glyphicon-edit" aria-hidden="true"></i>  编辑
                                    </button>
                                    <button id="del" type="button" class="btn btn-outline btn-default" title="删除">
                                        <i class="glyphicon glyphicon-off" aria-hidden="true"></i>  删除
                                    </button>
                                </div>
                                <table id="substationUserListTable" 
                                data-toggle="table"
                                data-method="post"
                                data-url="${projectPath }/substationUser/substationUserListData.action" 
                                data-content-type="application/x-www-form-urlencoded"
                                data-query-params-type=""
						    	data-pagination="true"
						    	data-side-pagination="server"
						        data-toolbar="#exampleToolbar"
						        data-show-export="true"
						        data-id-field="id"
						        data-show-refresh="true"
						        data-click-to-select="true"
						       	data-single-select="true"
						       	data-icon-size="outline"
						       	data-query-params="queryParams"
						        data-show-footer="false"
                                data-mobile-responsive="true">
                                    <thead>
                                        <tr>
                                        	<th data-checkbox="true" data-align="center"></th>
                                            <th data-field="username" data-align="center">操作人</th>
                                            <th data-field="substationName" data-align="center">分局名称</th>
                                            <th data-field="roleName" data-align="center">权限角色</th>
                                            <th data-field="dataStatus" data-align="center" data-formatter="statusFormatter">状态</th>
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
    <script src="${projectPath }/js/jquery.min.js"></script>
    <script src="${projectPath }/js/bootstrap.min.js"></script>
    <script src="${projectPath }/js/content.min.js"></script>
    <script src="${projectPath }/js/plugins/layui/layer/layer.js" ></script>
    <script src="${projectPath }/js/plugins/bootstrap-table/bootstrap-table.min.js" ></script>
    <script src="${projectPath }/js/plugins/bootstrap-table/bootstrap-table-mobile.min.js"></script>
    <script src="${projectPath }/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
    <script src="${projectPath }/js/common.js"></script>
    <script type="text/javascript">
    var $substationUserListTable = $("#substationUserListTable");
    $(document).on('click','#add',function(){
		layer.open({
			type: 2, 
			title:'<i class="glyphicon glyphicon-substationUser"></i> 添加分局',
			area: ['800px', '400px'],
			content: '${projectPath}/substationUser/substationUserAdd.action'
		});
	});
    $(document).on('click','#edit',function(){
    	var rows = $substationUserListTable.bootstrapTable('getSelections');
		if(rows.length!=1){
			layer.alert('请选择一行',{icon:0});
			return false;
		}
		layer.open({
			type: 2, 
			title:'<i class="glyphicon glyphicon-substationUser"></i> 编辑分局',
			area: ['800px', '300px'],
			content: '${projectPath}/substationUser/substationUserEdit.action?id='+rows[0].id
		});
	});
    $(document).on('click','#del',function(){
    	var rows = $substationUserListTable.bootstrapTable('getSelections');
		if(rows.length==0){
			layer.alert('请选择一行',{icon:0});
			return false;
		}
		layer.confirm('确定删除选中的分局？', function(index){
			/* layer.close(index);
			var ids = '';
			$.each(rows,function(index,obj){
				ids += 'ids=' + obj.id + '&';
			}) */
			$.ajax({
				type:"POST",
				url:'${projectPath}/substationUser/substationUserDelete.action?id=' + rows[0].id,
				success:function(data){
					if(data.resultInfo.success){
						$substationUserListTable.bootstrapTable("refresh");
						layer.alert(data.resultInfo.message,{icon: 1});
					}
				}
			}); 
		}); 
    });
    
    function statusFormatter(value,row,index){
		if(value==1)return '启用';
		else if(value==0)return '禁用';
	}
    
    function queryParams(params){
    	var b= $.extend({},params,$("#search-form").serializeJson());
    	return b;
    }
    
    $(document).on('click','#search',function(){
    	$substationUserListTable.bootstrapTable("refresh");
    })
    </script>
</body>

</html>