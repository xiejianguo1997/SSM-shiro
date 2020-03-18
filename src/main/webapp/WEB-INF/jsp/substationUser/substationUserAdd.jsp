<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="projectPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>分局用户管理-添加分局用户</title>

    <link href="${projectPath }/css/bootstrap.min.css" rel="stylesheet">
    <link href="${projectPath }/css/font-awesome.min.css" rel="stylesheet">
    <link href="${projectPath }/css/plugins/ztree/metroStyle/metroStyle.css" rel="stylesheet"/>
    <link href="${projectPath }/css/animate.min.css" rel="stylesheet">
    <link href="${projectPath }/css/style.min.css" rel="stylesheet">

</head>

<body>
    <div class="wrapper wrapper-content animated fadeInRight">

        <form class="form-horizontal m-t" id="substationUserForm" action="${projectPath }/substationUser/substationUserAdd.action" method="post">
            <div class="form-group">
                <label class="col-sm-3 control-label">操作员姓名：</label>
                <div class="col-sm-8">
                    <input id="username" name="username" class="form-control" type="text" required="required">
                </div>
            </div>
               <div class="form-group">
                <label class="col-sm-3 control-label">密码：</label>
                <div class="col-sm-8">
                    <input id="password" name="password" class="form-control" type="text"   required="required">
                </div>
            </div>
             <div class="form-group">
                <label class="col-sm-3 control-label">确认密码：</label>
                <div class="col-sm-8">
                    <input id="confirm_password" name="confirm_password" class="form-control" type="password" required="required" equalTo="#password">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">角色权限：</label>
                <div class="col-sm-8">
                    <select name="roleId" class="form-control" required="required">
                    	<option value="">请选择</option>
                    	<c:forEach items="${roles }" var="role">
                    		<option value="${role.id }">${role.roleName }</option>
                    	</c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">分局类别：</label>
                <div class="col-sm-8">
                    <select name="substationUserId" class="form-control" required="required">
                    	<option value="">请选择</option>
                    	<c:forEach items="${substationUsers }" var="substationUsers">
                    		<option value="${substationUsers.id }">${substationUsers.substationUserName }</option>
                    	</c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">状态：</label>
                <div class="col-sm-8">
                    <select name="dataStatus" class="form-control" required="required">
                    	<option value="1">启用</option>
                    	<option value="0">禁用</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-8 col-sm-offset-3">
                    <button id="substationUserFormSubmit" class="btn btn-primary" type="submit">提交</button>
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
    
	
     $("#substationUserForm").validate({
    	submitHandler:function(form){
    		$("#substationUserFormSubmit").button('loading');
    		$(form).ajaxSubmit({
				type:"POST",
				url:$(form).attr("action"),
				success:function(data){
					if(data.resultInfo.success){
						parent.$substationUserListTable.bootstrapTable("refresh");
						parent.layer.alert(data.resultInfo.message,{icon: 1});
						var index = parent.layer.getFrameIndex(window.name); 
						parent.layer.close(index); 
					}else{
						$("#substationUserFormSubmit").button('reset');
					}
				}
			});
			return false;
        }   
    }); 
    </script>
</body>

</html>