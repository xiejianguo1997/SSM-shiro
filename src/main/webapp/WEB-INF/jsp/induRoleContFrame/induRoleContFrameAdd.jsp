<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="projectPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>行业角色和内容架构管理-添加行业角色和内容架构</title>

    <link href="${projectPath }/css/bootstrap.min.css" rel="stylesheet">
    <link href="${projectPath }/css/font-awesome.min.css" rel="stylesheet">
    <link href="${projectPath }/css/plugins/ztree/metroStyle/metroStyle.css" rel="stylesheet"/>
    <link href="${projectPath }/css/animate.min.css" rel="stylesheet">
    <link href="${projectPath }/css/style.min.css" rel="stylesheet">

</head>

<body>
    <div class="wrapper wrapper-content animated fadeInRight">

        <form class="form-horizontal m-t" id="induRoleContFrameForm" action="${projectPath }/induRoleContFrame/induRoleContFrameAdd.action" method="post">
        	<div class="form-group">
                <label class="col-sm-3 control-label">所属行业：</label>
                <div class="col-sm-8">
                  <select name="industryId" id="industryId" class="form-control" required="required">
                    	<option value="">请选择</option>
                    	<c:forEach items="${industryList }" var="industry">
                    		<option value="${industry.id }">${industry.name }</option>
                    	</c:forEach>
                    </select>
                </div>
            </div>
        	<div class="form-group">
                <label class="col-sm-3 control-label">行业角色：</label>
                <div class="col-sm-8">
                  <select name="industryRoleId" id="industryRoleId" class="form-control" required="required">
                    	<option value="">请选择</option>
                    	<c:forEach items="${industryRoles }" var="industryRole">
                    		<option value="${industryRole.id }">${industryRole.roleName }</option>
                    	</c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">内容权限：</label>
                <div class="col-sm-8">
                    <select name="typeId" id="typeId" class="form-control" required="required">
                    	<option value="">请选择</option>
                    	<c:forEach items="${contentFrameworks }" var="contentFramework">
                    		<option value="${contentFramework.id }">${contentFramework.name }</option>
                    	</c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">内容类型：</label>
                <div class="col-sm-8">
                    <select name="dataStatus" class="form-control" required="required">
                    	<option value="1">启用</option>
                    	<option value="0">禁用</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-8 col-sm-offset-3">
                    <button id="induRoleContFrameFormSubmit" class="btn btn-primary" type="submit">提交</button>
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
    
	
     $("#induRoleContFrameForm").validate({
    	submitHandler:function(form){
    		$("#induRoleContFrameFormSubmit").button('loading');
    		$(form).ajaxSubmit({
				type:"POST",
				url:$(form).attr("action"),
				success:function(data){
					if(data.resultInfo.success){
						parent.$induRoleContFrameListTable.bootstrapTable("refresh");
						parent.layer.alert(data.resultInfo.message,{icon: 1});
						var index = parent.layer.getFrameIndex(window.name); 
						parent.layer.close(index); 
					}else{
						$("#induRoleContFrameFormSubmit").button('reset');
					}
				}
			});
			return false;
        }   
    }); 
     
     $("#industryId").change(function(){
	     $.ajax({  
	         type : "GET",  //提交方式  
	         url : "${projectPath}/induRoleContFrame/induRoleContFrameAddRefash.action",//路径  
	         data : {  
	        	 industryId : $(this).val()  
	         },//数据，这里使用的是Json格式进行传输  
	         success : function(result) {//返回数据根据结果进行相应的处理  
	             if ( result.success ) {  
	            	var industryRoleHtml = "<option value=''>请选择</option>";
	            	var contentFrameworkHtml = "<option value=''>请选择</option>";
	            	 
	            	$.each(result.industryRoles, function(index, industryRole){
	            		industryRoleHtml += "<option value='"+industryRole.id+"'>"+industryRole.roleName+"</option>";
	            	});
	            	
	            	$.each(result.contentFrameworks, function(index, contentFramework){
	            		contentFrameworkHtml += "<option value='"+contentFramework.id+"'>"+contentFramework.name+"</option>";
	            	});
	            	 
	            	$("#industryRoleId").html(industryRoleHtml);
	            	$("#typeId").html(contentFrameworkHtml);
	             } else {  
	            	 layer.alert("数据加载异常",{icon: 0});
	             }  
	         }  
	     }); 
     });
     
    </script>
</body>

</html>