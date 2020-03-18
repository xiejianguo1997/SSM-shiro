<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="projectPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>权限管理-添加权限</title>

    <link href="${projectPath }/css/bootstrap.min.css" rel="stylesheet">
    <link href="${projectPath }/css/font-awesome.min.css" rel="stylesheet">
    <link href="${projectPath }/css/animate.min.css" rel="stylesheet">
    <link href="${projectPath }/css/style.min.css" rel="stylesheet">

</head>

<body>
    <div class="wrapper wrapper-content animated fadeInRight">

        <form class="form-horizontal m-t" id="permissionForm" action="${projectPath }/permission/permissionAdd.action" method="post">
            <div class="form-group">
                <label class="col-sm-3 control-label">上级权限：</label>
                <div class="col-sm-8">
                	<input type="hidden" name="parentId" value="${parentPermi.id }">
                    <p class="form-control-static">${parentPermi.permiName }</p>
                    <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 上级权限不需要输入，为空时表示该次添加的权限为顶级权限</span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">权限名称：</label>
                <div class="col-sm-8">
                    <input id="permiName" name="permiName" class="form-control" type="text" required="required">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">url地址：</label>
                <div class="col-sm-8">
                    <input id="url" name="url" class="form-control" type="text">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">排序值：</label>
                <div class="col-sm-8">
                    <input id="sort" name="sort" class="form-control" type="number" required="required" value="0">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">备注：</label>
                <div class="col-sm-8">
                    <textarea rows="" cols="" name="description" class="form-control"></textarea>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-8 col-sm-offset-3">
                    <button id="permissionFormSubmit" class="btn btn-primary" type="submit">提交</button>
                </div>
            </div>
        </form>
    </div>
    <script src="${projectPath }/js/jquery.min.js"></script>
    <script src="${projectPath }/js/bootstrap.min.js"></script>
    <script src="${projectPath }/js/content.min.js"></script>
    <script src="${projectPath }/js/plugins/validate/jquery.validate.min.js" ></script>
    <script src="${projectPath }/js/plugins/validate/messages_zh.min.js" ></script>
    <script src="${projectPath }/js/jquery.form.js" ></script>
    <script src="${projectPath }/js/demo/form-validate-demo.js" ></script>
    <script src="${projectPath }/js/common.js"></script>
    <script type="text/javascript">
     $("#permissionForm").validate({
    	submitHandler:function(form){
    		$("#permissionFormSubmit").button('loading');
    		$(form).ajaxSubmit({
				type:"POST",
				url:$(form).attr("action"),
				success:function(data){
					if(data.resultInfo.success){
						var treeObj = parent.$.fn.zTree.getZTreeObj("tree");
						var nodes = treeObj.getSelectedNodes();
						treeObj.reAsyncChildNodes(nodes[0], 'refresh', true);
						var pid=1;
						if(nodes.length>0){
							pid = nodes[0].id;
						}
						parent.$("#permissionListTable").bootstrapTable("refresh",{query:{parentId:pid}});
						parent.layer.alert(data.resultInfo.message,{icon: 1});
						var index = parent.layer.getFrameIndex(window.name); 
						parent.layer.close(index); 
					}else{
						$("#permissionFormSubmit").button('reset');
					}
				}
			});
			return false;
        }   
    }); 
    </script>
</body>

</html>