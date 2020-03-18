<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="projectPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>组织架构管理-添加组织架构</title>

    <link href="${projectPath }/css/bootstrap.min.css" rel="stylesheet">
    <link href="${projectPath }/css/font-awesome.min.css" rel="stylesheet">
    <link href="${projectPath }/css/animate.min.css" rel="stylesheet">
    <link href="${projectPath }/css/style.min.css" rel="stylesheet">

</head>

<body>
    <div class="wrapper wrapper-content animated fadeInRight">

        <form class="form-horizontal m-t" id="departmentForm" action="${projectPath }/department/departmentAdd.action" method="post">
            <div class="form-group">
                <label class="col-sm-3 control-label">上级部门：</label>
                <div class="col-sm-8">
                	<input type="hidden" name="parentId" value="${parentId }">
                    <p class="form-control-static">${pName }</p>
                    <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 上级部门不需要输入，为空时表示该次添加的部门为顶级部门</span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">部门名称：</label>
                <div class="col-sm-8">
                    <input id="deptName" name="deptName" class="form-control" type="text" required="required">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">部门简称：</label>
                <div class="col-sm-8">
                    <input id="shortName" name="shortName" class="form-control" type="text">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">部门编码：</label>
                <div class="col-sm-8">
                    <input id="deptCode" name="deptCode" class="form-control" type="text" required="required">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">排序值：</label>
                <div class="col-sm-8">
                    <input id="sort" name="sort" class="form-control" type="number" required="required">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">备注：</label>
                <div class="col-sm-8">
                    <textarea rows="" cols="" name="remark" class="form-control"></textarea>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-8 col-sm-offset-3">
                    <button id="departmentFormSubmit" class="btn btn-primary" type="submit">提交</button>
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
     $("#departmentForm").validate({
    	submitHandler:function(form){
    		$("#departmentFormSubmit").button('loading');
    		$(form).ajaxSubmit({
				type:"POST",
				url:$(form).attr("action"),
				success:function(data){
					if(data.resultInfo.success){
						var treeObj = parent.$.fn.zTree.getZTreeObj("tree");
						var nodes = treeObj.getSelectedNodes();
						treeObj.reAsyncChildNodes(nodes[0], 'refresh', true);
						var query = {};
						if(nodes.length>0){
							query.id = nodes[0].id;
						}
						parent.$("#departmentListTable").bootstrapTable("refresh",{query:query});
						parent.layer.alert(data.resultInfo.message,{icon: 1});
						var index = parent.layer.getFrameIndex(window.name); 
						parent.layer.close(index); 
					}else{
						$("#departmentFormSubmit").button('reset');
					}
				}
			});
			return false;
        }   
    }); 
    </script>
</body>

</html>