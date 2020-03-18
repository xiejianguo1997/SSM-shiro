<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="projectPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>角色管理-设置权限</title>

    <link href="${projectPath }/css/bootstrap.min.css" rel="stylesheet">
    <link href="${projectPath }/css/font-awesome.min.css" rel="stylesheet">
    <link href="${projectPath }/css/plugins/ztree/metroStyle/metroStyle.css" rel="stylesheet"/>
    <link href="${projectPath }/css/animate.min.css" rel="stylesheet">
    <link href="${projectPath }/css/style.min.css" rel="stylesheet">

</head>

<body>
    <div class="wrapper wrapper-content animated fadeInRight">

        <ul id="tree" class="ztree"></ul>
        <button id="setPermission" type="submit" data-loading-text="正在保存" class="btn btn-primary">保存</button>
    </div>
    <script src="${projectPath }/js/jquery.min.js"></script>
    <script src="${projectPath }/js/bootstrap.min.js"></script>
    <script src="${projectPath }/js/content.min.js"></script>
    <script src="${projectPath }/js/plugins/ztree/jquery.ztree.all.min.js"></script>
    <script src="${projectPath }/js/common.js"></script>
    <script type="text/javascript">
    var setting = {
			check: {
				enable: true
			},
			data: {
				simpleData: {
					enable:true,
					idKey: "id",
					pIdKey: "parentId",
					rootPId: ""
				}
			}
	};

	var zNodes = ${rolePerimissionJson};

	var tree = $.fn.zTree.init($("#tree"), setting,zNodes);
	
	$(document).on('click','#setPermission',function(){
		var $that = $(this);
		$that.button('loading');
		var nodes = tree.getCheckedNodes(true);
		var menuIds = "";
		$.each(nodes,function(index,obj){
			menuIds += obj.id + ",";
		});
		var url = '${projectPath}/role/setPerimission.action';
		$.post(url,{roleId:'${roleId}',menuIds:menuIds},function(data){
			if(data.resultInfo.success){
				parent.layer.alert(data.resultInfo.message,{icon: 1});
				var index = parent.layer.getFrameIndex(window.name); 
				parent.layer.close(index); 
			}
			$that.button('reset');
		});
	});
    </script>
</body>

</html>