<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="projectPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>


<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     
     <link href="${projectPath }/css/bootstrap.min.css" rel="stylesheet">
    <link href="${projectPath }/css/font-awesome.min.css" rel="stylesheet">
    <link href="${projectPath }/css/plugins/ztree/metroStyle/metroStyle.css" rel="stylesheet"/>
    <link href="${projectPath }/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
    <link href="${projectPath }/css/animate.min.css" rel="stylesheet">
    <link href="${projectPath }/css/style.min.css" rel="stylesheet">
    <link href="${projectPath }/css/plugins/webuploader/webuploader.css" rel="stylesheet">
    
</head>
<body>
  <div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-3">
		        <!-- Panel Other -->
		        <div class="ibox float-e-margins">
		            <div class="ibox-title">
		                <h5>视频列表</h5>
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
		                            	<ul id="tree" class="ztree"></ul>
		                            </div>
		                        </div>
		                        <!-- End Example Card View -->
		                    </div>
		                </div>
		            </div>
		        </div>
		        <!-- End Panel Other -->
	        </div>
	        <div class="col-sm-9">
		        <!-- Panel Other -->
		        <div class="ibox float-e-margins">
		            <div class="ibox-title">
		                <h5>视频列表</h5>
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
		                            	<div class="btn-group hidden-xs" id="exampleToolbar" role="group">
		                                    <button id="add" type="button" class="btn btn-outline btn-default" title="添加">
		                                        <i class="glyphicon glyphicon-plus" aria-hidden="true"></i>
		                                    </button>
		                                    <button id="edit" type="button" class="btn btn-outline btn-default" title="编辑">
		                                        <i class="glyphicon glyphicon-edit" aria-hidden="true"></i>
		                                    </button>
		                                    <button id="del" type="button" class="btn btn-outline btn-default" title="删除">
		                                        <i class="glyphicon glyphicon-trash" aria-hidden="true"></i>
		                                    </button>
		                                </div>
		                            	<table id="videoListTable" 
		                                data-toggle="table"
		                                data-method="post"
		                                data-url="${projectPath }/video/videoListData.action" 
		                                data-content-type="application/x-www-form-urlencoded"
		                                data-query-params-type=""
								    	data-pagination="true"
								    	data-side-pagination="server"
								        data-toolbar="#exampleToolbar"
								        data-show-export="true"
								        data-id-field="id"
								        data-show-refresh="false"
								        data-click-to-select="true"
								       	data-single-select="true"
								       	data-icon-size="outline"
								       	data-query-params="queryParams"
								        data-show-footer="false"
		                                data-mobile-responsive="true">
		                                    <thead>
		                                        <tr>
		                                        	<th data-checkbox="true" data-align="center"></th>
		                                        	<th data-field="contentFrameworkName" data-align="center">内容架构名称</th>
		                                        	<th data-field="infoName" data-align="center">类型</th>
		                                            <th data-field="videoName" data-align="center">视频名称</th>
		                                            <th data-field="videoPath" data-align="center"  data-formatter="videoPathFormatter">视频路径</th>
		                                            <th data-field="videoTime" data-align="center">视频时长(秒)</th>
		                                            <th data-field="videoImg" data-align="center"  data-formatter="videoImgFormatter">视频图片</th>
		                                             <th data-field="dataStatus" data-align="center" data-formatter="dataStatusFormatter">状态</th>
		                                            <th data-field="createTime" data-align="center">创建时间</th>
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
        </div>
    </div>
<!-- 上传模块 -->
<%-- <div class="wrapper wrapper-content animated fadeInRight">
	<form class="form-horizontal m-t" id="branchSchoolForm" action="${projectPath }/branchSchool/branchSchoolAdd.action" method="post">
       <div class="form-group">
                <label class="col-sm-2 control-label">附件：</label>
                <div class="col-sm-10">
                	<div id="uploader_branchSchoolAttachment" class="wu-example">
					    <!--用来存放文件信息-->
					    <div id="thelist_branchSchoolAttachment" class="uploader-list"></div>
					    <div class="btns">
					        <div id="picker_branchSchoolAttachment">选择文件</div>
					        <a id="ctlBtn_branchSchoolAttachment" class="btn btn-white" role="button">开始上传</a>
					    </div>
					</div>
                </div>
            </div>
	</form>
</div> --%>
<script type="text/javascript">
var fileServerUrl = ${fileServerUrl};
</script>
    <script src="${projectPath }/js/jquery.min.js"></script>
    <script src="${projectPath }/js/bootstrap.min.js"></script>
    <script src="${projectPath }/js/content.min.js"></script>
    <script src="${projectPath }/js/plugins/layui/layer/layer.js" ></script>
    <script src="${projectPath }/js/plugins/bootstrap-table/bootstrap-table.min.js" ></script>
    <script src="${projectPath }/js/plugins/bootstrap-table/bootstrap-table-mobile.min.js"></script>
    <script src="${projectPath }/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
    <script src="${projectPath }/js/plugins/ztree/jquery.ztree.all.min.js"></script>
    <script src="${projectPath }/js/common.js"></script>
    
    <script src="${projectPath }/js/plugins/webuploader/webuploader.min.js"></script>
    <script src="${projectPath }/js/demo/VideoUpload.js"></script>
 <script type="text/javascript">
 var setting = {
			view: {
				selectedMulti: false
			},
				async: {
				enable: true,
				autoParam:["id"],
				dataType:"JSON",
				url:"${projectPath}/contentFramework/contentFrameworkTreeJson.action"
			},
			callback: {
				onClick: function(event,treeId,treeNode){
					var query = {'id':treeNode.id};
					$("#videoListTable").bootstrapTable('refresh',{query:query});
				}
			}
	};
 
	var tree = $.fn.zTree.init($("#tree"), setting);
	

	$(document).on('click','#add',function(){
		var treeObj = $.fn.zTree.getZTreeObj("tree");
		var nodes = treeObj.getSelectedNodes();
		var pid = nodes.length>0?nodes[0].id:'';
		layer.open({
			type: 2, 
			title:'添加视频内容',
			area: ['800px', '550px'],
			content: '${projectPath}/video/videoAdd.action?pid='+pid
		});
	});
	
	$(document).on('click','#edit',function(){
		var rows = $("#videoListTable").bootstrapTable('getSelections');
		if(rows.length==0){
			layer.alert('请选择一行编辑',{icon:0});
			return false;
		}
		layer.open({
			type: 2, 
			title:'编辑视频内容',
			area: ['800px', '650px'],
			content: '${projectPath}/video/videoEdit.action?id='+rows[0].id
		});
	});
	
	$(document).on('click','#del',function(){
		var rows = $("#videoListTable").bootstrapTable('getSelections');
		if(rows.length==0){
			layer.alert('请选择一行',{icon:0});
			return false;
		}
		layer.confirm('确定删除这条记录吗？', function(index){
			layer.close(index);
			var id = '';
			
			$.ajax({
				type:"POST",
				url:'${projectPath}/video/videoDelete.action',
				data:{id:rows[0].id},
				success:function(data){
					if(data.resultInfo.success){
						var treeObj = $.fn.zTree.getZTreeObj("tree");
						var nodes = treeObj.getSelectedNodes();
						treeObj.reAsyncChildNodes(nodes[0], 'refresh', true);
						
						$("#videoListTable").bootstrapTable("refresh",{query:{id:nodes[0].id}});
						layer.alert(data.resultInfo.message,{icon: 1});
					}
				}
			}); 
		}); 
	});
	
	function queryParams(params){
    	var b= $.extend({},params);
    	return b;
    }
	
	function dataStatusFormatter(value,row,index){
		if(value==1)return '启用';
		else if(value==0)return '禁用';
	}
	
	function videoPathFormatter(value,row,index){
		if(value!=null)return '<a href="${fileServerUrl}'+value+'" >视频</a>'
		else  return '';
	}
	
	function videoImgFormatter(value,row,index){
		if(value!=null)return '<img  style="width:100px;height=100px" src="${fileServerUrl}'+value+'" />'
		else return '';
	}
 </script>
</body>
</html>
