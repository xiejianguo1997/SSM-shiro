<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="projectPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>行业角色管理-添加行业角色</title>

    <link href="${projectPath }/css/bootstrap.min.css" rel="stylesheet">
    <link href="${projectPath }/css/font-awesome.min.css" rel="stylesheet">
    <link href="${projectPath }/css/plugins/ztree/metroStyle/metroStyle.css" rel="stylesheet"/>
    <link href="${projectPath }/css/animate.min.css" rel="stylesheet">
    <link href="${projectPath }/css/style.min.css" rel="stylesheet">

</head>

<body>
    <div class="wrapper wrapper-content animated fadeInRight">

        <form class="form-horizontal m-t" id="industryRoleForm" action="${projectPath }/industryRole/industryRoleAdd.action" method="post">
            <div class="form-group">
                <label class="col-sm-3 control-label">行业角色名称：</label>
                <div class="col-sm-8">
                    <input id="roleName" name="roleName" class="form-control" type="text" required="required">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">所属行业：</label>
                <div class="col-sm-8">
                    <select name="industryId" class="form-control" required="required">
                    	<option value="">请选择</option>
                    	<c:forEach var="industry" items="${industryList }" varStatus="industryStatus">
	                    	<option value="${industry.id }">${industry.name }</option>
                    	</c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">总学时(秒)：</label>
                <div class="col-sm-8">
                    <input id="totalStudyTime" name="totalStudyTime" class="form-control" type="number" required="required">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">达标类型：</label>
                <div class="col-sm-8">
                    <select name="standardType" class="form-control" required="required">
	                	<option value="">请选择</option>
                    	<option value="1">月</option>
                    	<option value="2">季度</option>
                    	<option value="3">年</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">达标时长(秒)：</label>
                <div class="col-sm-8">
                    <input id="standardTime" name="standardTime" class="form-control" type="number" required="required">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">是否可以注册：</label>
                <div class="col-sm-8">
                    <select name="canRegist" class="form-control" required="required">
                    	<option value="1">是</option>
                    	<option value="0">否</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">是否可以管理后台：</label>
                <div class="col-sm-8">
                    <select name="canBack" class="form-control" required="required">
                    	<option value="1">是</option>
                    	<option value="0">否</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">数据状态：</label>
                <div class="col-sm-8">
                    <select name="dataStatus" class="form-control" required="required">
                    	<option value="1">启用</option>
                    	<option value="0">禁用</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-8 col-sm-offset-3">
                    <button id="industryRoleFormSubmit" class="btn btn-primary" type="submit">提交</button>
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
    <script src="${projectPath }/js/plugins/ztree/jquery.ztree.all.min.js"></script>
    <script src="${projectPath }/js/common.js"></script>
    <script type="text/javascript">
    
	
     $("#industryRoleForm").validate({
    	submitHandler:function(form){
    		$("#industryRoleFormSubmit").button('loading');
    		$(form).ajaxSubmit({
				type:"POST",
				url:$(form).attr("action"),
				success:function(data){
					if(data.resultInfo.success){
						parent.$industryRoleListTable.bootstrapTable("refresh");
						parent.layer.alert(data.resultInfo.message,{icon: 1});
						var index = parent.layer.getFrameIndex(window.name); 
						parent.layer.close(index); 
					}else{
						$("#industryRoleFormSubmit").button('reset');
					}
				}
			});
			return false;
        }   
    }); 
    </script>
</body>

</html>