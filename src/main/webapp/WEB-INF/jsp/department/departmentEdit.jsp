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
    <link href="${projectPath }/css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="${projectPath }/css/animate.min.css" rel="stylesheet">
    <link href="${projectPath }/css/style.min.css" rel="stylesheet">

</head>

<body>
    <div class="wrapper wrapper-content animated fadeInRight">

        <form class="form-horizontal m-t" id="departmentForm" action="${projectPath }/department/departmentEdit.action" method="post">
        	<input type="hidden" name="id" value="${department.id }">
            <div class="form-group">
                <label class="col-sm-3 control-label">上级部门：</label>
                <div class="col-sm-8">
                	<input type="hidden" name="parentId" value="${department.parentId }">
                    <p class="form-control-static">${departmentParent.deptName }</p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">部门名称：</label>
                <div class="col-sm-8">
                    <input id="deptName" name="deptName" class="form-control" type="text" required="required" value="${department.deptName }">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">部门简称：</label>
                <div class="col-sm-8">
                    <input id="shortName" name="shortName" class="form-control" type="text" value="${department.shortName }">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">部门编码：</label>
                <div class="col-sm-8">
                    <input id="deptCode" name="deptCode" class="form-control" type="text" required="required" value="${department.deptCode }">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">排序值：</label>
                <div class="col-sm-8">
                    <input id="sort" name="sort" class="form-control" type="number" required="required" value="${department.sort }">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">部门负责人：</label>
                <div class="col-sm-8">
                	<div class="input-group">
	                    <input type="text" class="form-control" name="principalName" id="principalName" value="${department.principalName }" data-id="${department.principalId }">
	                    <div class="input-group-btn">
	                        <button type="button" class="btn btn-white dropdown-toggle" data-toggle="dropdown">
	                            <span class="caret"></span>
	                        </button>
	                        <ul class="dropdown-menu dropdown-menu-right" role="menu">
	                        </ul>
	                    </div>
	                    <!-- /btn-group -->
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">备注：</label>
                <div class="col-sm-8">
                    <textarea rows="" cols="" name="remark" class="form-control">${department.remark }</textarea>
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
    <script src="${projectPath }/js/plugins/iCheck/icheck.min.js"></script>
    <script src="${projectPath }/js/plugins/validate/jquery.validate.min.js" ></script>
    <script src="${projectPath }/js/plugins/validate/messages_zh.min.js" ></script>
    <script src="${projectPath }/js/plugins/suggest/bootstrap-suggest.min.js" ></script>
    <script src="${projectPath }/js/jquery.form.js" ></script>
    <script src="${projectPath }/js/demo/form-validate-demo.js" ></script>
    <script src="${projectPath }/js/common.js"></script>
    <script type="text/javascript">
    $(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",});
 	//搜索建议插件
    $("#principalName").bsSuggest({
    	getDataMethod:"url",//获取数据的方式，url：一直从url请求；data：从 options.data 获取；firstByUrl：第一次从Url获取全部数据，之后从options.data获取
    	showBtn:false,//是否显示下拉按钮
    	effectiveFields:['id','realName','deptName'],//有效显示于列表中的字段，非有效字段都会过滤，默认全部，对自定义getData方法无效
    	effectiveFieldsAlias:{id:'编号',realName:'姓名',deptName:'所在部门'},//有效字段的别名对象，用于 header 的显示
    	url:"${projectPath }/user/userSuggestListData.action?user.realName=",//请求数据的 URL 地址
    	idField:"id",//每组数据的哪个字段作为 data-id，优先级高于 indexId 设置（推荐）
    	keyField:"realName"//每组数据的哪个字段作为输入框内容，优先级高于 indexKey 设置（推荐）
    });
    $("#departmentForm").validate({
    	submitHandler:function(form){
    		$("#departmentFormSubmit").button('loading');
    		//输入框显示的是名称,而id则在元素的data-id上,因此在提交表单时,需要手动添加此参数
    		var principalId = $(form).find("#principalName").attr("data-id");
    		$(form).ajaxSubmit({
				type:"POST",
				url:$(form).attr("action"),
				data:{principalId:principalId},
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