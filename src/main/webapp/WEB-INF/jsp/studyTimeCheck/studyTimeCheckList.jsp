<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="projectPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>政府审核管理</title>

    <link href="${projectPath }/css/bootstrap.min.css" rel="stylesheet">
    <link href="${projectPath }/css/font-awesome.min.css" rel="stylesheet">
    <link href="${projectPath }/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
    <link href="${projectPath }/css/animate.min.css" rel="stylesheet">
    <link href="${projectPath }/css/style.min.css" rel="stylesheet">
	
	<style type="text/css">

		label{display: inline-block;
		    text-align: right;
		    max-width: 100%;
		    width: 35%;
		    margin-bottom: 5px;
		    font-weight: 700;
		}
	    
	    .form-inline .form-control{
	    	display: inline-block;
		    width: 60%;
		    vertical-align: middle;
	    }

	</style>

</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">

        <!-- Panel Other -->
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>政府审核列表</h5>
                <div class="ibox-tools">
                    <a class="collapse-link">
                        <i class="fa fa-chevron-up"></i>
                    </a>
                </div>
            </div>
            
            <div class="ibox-content">
               	<form id="search-form" class="form-inline" role="form">
				    <div class="form-group" style="width: 18%;padding-top: 5px;padding-bottom: 5px;">
		    		    <label>姓名：</label>
		    		    <input type="text" name="name" class="form-control">
		  		    </div>
				    <div class="form-group" style="width: 18%;">
		    		    <label>身份证号：</label>
		    		    <input type="text" name="certIdNum" class="form-control">
		  		    </div>
				    <div class="form-group" style="width: 18%;">
		    		    <label>公司：</label>
		    		    <input type="text" name="businessName" class="form-control">
		  		    </div>
		  		    <div class="form-group" style="width: 18%;">
		    		    <label>行业：</label>
		    		    <select name="industryId" class="form-control">
		    		    	<option value="">请选择</option>
		    		    	<c:forEach items="${industryList }" var="industry">
			    		    	<option value="${industry.id }">${industry.name }</option>
		    		    	</c:forEach>
		    		    </select>
		  		    </div>
		  		    <div class="form-group" style="width: 18%;">
		    		    <label>所属分局：</label>
		    		    <select name="substationId" class="form-control">
		    		    	<option value="">请选择</option>
		    		    	<c:forEach items="${substationList }" var="substation">
			    		    	<option value="${substation.id }">${substation.substationName }</option>
		    		    	</c:forEach>
		    		    </select>
		  		    </div>
		  		    <div class="form-group" style="width: 18%;">
		    		    <label>学时类型：</label>
		    		    <select name="studyTimeCheck.type" class="form-control">
		    		    	<option value="">请选择</option>
		    		    	<option value="1">测评</option>
		    		    	<option value="2">视频</option>
		    		    </select>
		  		    </div>
		  		    <div class="form-group" style="width: 18%;">
		    		    <label>学习开始日期：</label>
		    		    <input type="text" name="searchBeginTime" id="searchBeginTime" class="form-control layer-date" onclick="laydate({ format: 'YYYY-MM-DD'})">
		  		    </div>
		  		    <div class="form-group" style="width: 18%;">
		    		    <label>学习结束日期：</label>
		    		    <input type="text" name="searchEndTime" id="searchEndTime" class="form-control layer-date" onclick="laydate({ format: 'YYYY-MM-DD'})">
		  		    </div>
		  		    <button id="search" type="button" class="btn btn-success" style="margin-top: 5px;margin-left: 10px;">搜索</button>
				</form>
			</div>
            
            <div class="ibox-content">
            
            	<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
				  	<li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab" id="tabOneA">待审核</a></li>
				  	<li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab" id="tabTwoA">已审核</a></li>
				</ul>
            
            	<!-- Tab panes -->
			  	<div class="tab-content">
			    	<div role="tabpanel" class="tab-pane active" id="home">
			    	<!-- begin -->
			    		<div class="ibox-content">
			                <div class="row row-lg">
			                    <div class="col-sm-12">
			                        <!-- Example Card View -->
			                        <div class="example-wrap">
			                            <h4 class="example-title"></h4>
			                            <div class="example">
			                            	<div class="btn-group hidden-xs" id="exampleToolbar1" role="group">
			                                    <button id="edit" type="button" class="btn btn-outline btn-default" title="审核">
			                                        <i class="glyphicon glyphicon-edit" aria-hidden="true"></i>  审核
			                                    </button>
			                                </div>
			                                <table id="studyTimeListTableOne" 
			                                data-toggle="table"
			                                data-method="post"
			                                data-url="${projectPath }/studyTimeCheck/studyTimeCheckWaitForCheckListData.action" 
			                                data-content-type="application/x-www-form-urlencoded"
			                                data-query-params-type=""
									    	data-pagination="true"
									    	data-side-pagination="server"
									        data-toolbar="#exampleToolbar1"
									        data-show-export="true"
									        data-id-field="id"
									        data-show-refresh="true"
									        data-click-to-select="true"
									       	data-single-select="true"
									       	data-icon-size="outline"
									       	data-query-params="queryParams"
									        data-show-footer="false"
			                                data-mobile-responsive="true">
			                                    <thead>
			                                        <tr>
			                                        	<th data-checkbox="true" data-align="center"></th>
			                                            <th data-field="createTime" data-align="center">学时生成日期</th>
			                                            <th data-field="spendTime" data-align="center">学时时常</th>
			                                            <th data-field="employeeName" data-align="center">姓名</th>
			                                            <th data-field="certIdNum" data-align="center">身份证号</th>
			                                            <th data-field="businessName" data-align="center">所属公司</th>
			                                            <th data-field="industryName" data-align="center">行业</th>
			                                            <th data-field="substationName" data-align="center">所属分局</th>
			                                            <th data-field="type" data-align="center" data-formatter="typeFormatter">学时类型</th>
			                                        </tr>
			                                    </thead>
			                                </table>
			                            </div>
			                        </div>
			                        <!-- End Example Card View -->
			                    </div>
			                </div>
                		</div>
                		<!-- end -->
			    	</div>
			    	
			    	<div role="tabpanel" class="tab-pane" id="profile">
			    	
			    		<div class="ibox-content">
			                <div class="row row-lg">
			                    <div class="col-sm-12">
			                        <!-- Example Card View -->
			                        <div class="example-wrap">
			                            <h4 class="example-title"></h4>
			                            <div class="example">
			                            	<div class="btn-group hidden-xs" id="exampleToolbar2" role="group">
			                                    <!-- <button id="edit" type="button" class="btn btn-outline btn-default" title="审核">
			                                        <i class="glyphicon glyphicon-edit" aria-hidden="true"></i>  审核
			                                    </button> -->
			                                </div>
			                                <table id="studyTimeListTableTwo" 
			                                data-toggle="table"
			                                data-method="post"
			                                data-url="${projectPath }/studyTimeCheck/studyTimeCheckAllListData.action" 
			                                data-content-type="application/x-www-form-urlencoded"
			                                data-query-params-type=""
									    	data-pagination="true"
									    	data-side-pagination="server"
									        data-toolbar="#exampleToolbar2"
									        data-show-export="true"
									        data-id-field="id"
									        data-show-refresh="true"
									        data-click-to-select="true"
									       	data-single-select="true"
									       	data-icon-size="outline"
									       	data-query-params="queryParams"
									        data-show-footer="false"
			                                data-mobile-responsive="true">
			                                    <thead>
			                                        <tr>
			                                        	<th data-checkbox="true" data-align="center"></th>
			                                            <th data-field="createTime" data-align="center">学时生成日期</th>
			                                            <th data-field="spendTime" data-align="center">学时时常</th>
			                                            <th data-field="employeeName" data-align="center">姓名</th>
			                                            <th data-field="certIdNum" data-align="center">身份证号</th>
			                                            <th data-field="businessName" data-align="center">所属公司</th>
			                                            <th data-field="industryName" data-align="center">行业</th>
			                                            <th data-field="substationName" data-align="center">所属分局</th>
			                                            <th data-field="type" data-align="center" data-formatter="typeFormatter">学时类型</th>
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
			    </div>
            </div>
        </div>
        <!-- End Panel Other -->
    </div>
    
    <script src="${projectPath }/js/jquery.min.js"></script>
    <script src="${projectPath }/js/bootstrap.min.js"></script>
    <script src="${projectPath }/js/content.min.js"></script>
    <script src="${projectPath }/js/plugins/layui/layer/layer.js" ></script>
    <script src="${projectPath }/js/plugins/bootstrap-table/bootstrap-table.min.js" ></script>
    <script src="${projectPath }/js/plugins/bootstrap-table/bootstrap-table-mobile.min.js"></script>
    <script src="${projectPath }/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
    <script src="${projectPath }/js/common.js"></script>
    <script src="${projectPath }/js/plugins/layui/laydate/laydate.js"></script>
    <script type="text/javascript">
    var $studyTimeListTable = $("#studyTimeListTableOne");
    $(document).on('click','#edit',function(){
    	var rows = $studyTimeListTable.bootstrapTable('getSelections');
		if(rows.length!=1){
			layer.alert('请选择一行',{icon:0});
			return false;
		}
		layer.open({
			type: 2, 
			title:'<i class="glyphicon glyphicon-studyTime"></i> 学时审核',
			area: ['100%', '100%'],
			content: '${projectPath}/studyTimeCheck/studyTimeCheckCheck.action?id='+rows[0].id
		});
	});
    
    function typeFormatter(value,row,index){
		if(value==1)return '测评';
		else if(value==2)return '视频';
	}
    
    function queryParams(params){
    	var b= $.extend({},params,$("#search-form").serializeJson());
    	return b;
    }
    
    $(document).on('click','#search',function(){
    	$("#studyTimeListTableOne").bootstrapTable("refresh");
		$("#studyTimeListTableTwo").bootstrapTable("refresh");
    })
    
    $('#tabOneA').click(function (e) {
    	$("#studyTimeListTableOne").bootstrapTable("refresh");
	})

	$('#tabTwoA').click(function (e) {
		$("#studyTimeListTableTwo").bootstrapTable("refresh");
	})
    </script>
</body>

</html>