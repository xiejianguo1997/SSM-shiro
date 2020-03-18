<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="projectPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>行业管理-编辑行业</title>

    <link href="${projectPath }/css/bootstrap.min.css" rel="stylesheet">
    <link href="${projectPath }/css/font-awesome.min.css" rel="stylesheet">
    <link href="${projectPath }/css/plugins/ztree/metroStyle/metroStyle.css" rel="stylesheet"/>
    <link href="${projectPath }/css/animate.min.css" rel="stylesheet">
    <link href="${projectPath }/css/style.min.css" rel="stylesheet">

</head>

<body>
    <div class="wrapper wrapper-content animated fadeInRight">

        <form class="form-horizontal m-t" id="industryForm" action="${projectPath }/industry/industryEdit.action" method="post">
        	<input type="hidden" name="id" value="${industry.id }">
            <div class="form-group">
                <label class="col-sm-3 control-label">行业名称：</label>
                <div class="col-sm-8">
                	<input name="name" class="form-control" type="text" required="required" value="${industry.name }" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">达标类型：</label>
                <div class="col-sm-8">
                    <select name="standardType" class="form-control" required="required">
                    	<option value="1" <c:if test="${industry.standardType == 1 }">selected="selected"</c:if>>月</option>
                    	<option value="2" <c:if test="${industry.standardType == 2 }">selected="selected"</c:if>>季度</option>
                    	<option value="3" <c:if test="${industry.standardType == 3 }">selected="selected"</c:if>>年</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">达标时长(秒)：</label>
                <div class="col-sm-8">
                    <input id="standardTime" name="standardTime" value="${industry.standardTime }" class="form-control" type="number" required="required">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">状态：</label>
                <div class="col-sm-8">
                    <select name="status" class="form-control" required="required">
                    	<option value="1" <c:if test="${industry.status == 1 }">selected="selected"</c:if>>启用</option>
                    	<option value="0" <c:if test="${industry.status == 0 }">selected="selected"</c:if>>禁用</option>
                    </select>
                </div>
            </div>
            
            <div class="form-group">
                <div class="col-sm-8 col-sm-offset-3">
                    <button id="industryFormSubmit" class="btn btn-primary" type="submit">提交</button>
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
     $("#industryForm").validate({
    	submitHandler:function(form){
    		$("#industryFormSubmit").button('loading');
    		$(form).ajaxSubmit({
				type:"POST",
				url:$(form).attr("action"),
				success:function(data){
					if(data.resultInfo.success){
						parent.$industryListTable.bootstrapTable("refresh");
						parent.layer.alert(data.resultInfo.message,{icon: 1});
						var index = parent.layer.getFrameIndex(window.name); 
						parent.layer.close(index); 
					}else{
						$("#industryFormSubmit").button('reset');
					}
				}
			});
			return false;
        }   
    }); 
    </script>
</body>

</html>