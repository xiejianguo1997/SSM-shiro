<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="projectPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>修改密码</title>

    <link href="${projectPath }/css/bootstrap.min.css" rel="stylesheet">
    <link href="${projectPath }/css/font-awesome.min.css" rel="stylesheet">
    <link href="${projectPath }/css/animate.min.css" rel="stylesheet">
    <link href="${projectPath }/css/style.min.css" rel="stylesheet">

</head>

<body>
    <div class="wrapper wrapper-content animated fadeInRight">

        <form class="form-horizontal m-t" id="modifypwdForm" action="${projectPath }/modifypwd.action" method="post">
            <div class="form-group">
                <label class="col-sm-3 control-label">原密码：</label>
                <div class="col-sm-8">
                    <input name="oldPassword" class="form-control" type="password" required="required">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">新密码：</label>
                <div class="col-sm-8">
                    <input name="newPassword" class="form-control" type="password" required="required">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">确认密码：</label>
                <div class="col-sm-8">
                    <input name="newConfirmPassword" class="form-control" type="password" required="required">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-8 col-sm-offset-3">
                    <button id="modifypwdFormSubmit" class="btn btn-primary" type="submit">提交</button>
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
     $("#modifypwdForm").validate({
    	submitHandler:function(form){
    		$("#modifypwdFormSubmit").button('loading');
    		$(form).ajaxSubmit({
				type:"POST",
				url:$(form).attr("action"),
				success:function(data){
					if(data.resultInfo.success){
						parent.layer.alert(data.resultInfo.message,{icon: 1},function(){
							parent.location.href = "${projectPath }/login.action";
						});
						
					}else{
						$("#modifypwdFormSubmit").button('reset');
					}
				}
			});
			return false;
        }   
    }); 
    </script>
</body>

</html>