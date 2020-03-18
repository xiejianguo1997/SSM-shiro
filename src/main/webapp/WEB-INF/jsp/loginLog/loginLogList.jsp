<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="projectPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>登录日志</title>

    <link href="${projectPath }/css/bootstrap.min.css" rel="stylesheet">
    <link href="${projectPath }/css/font-awesome.min.css" rel="stylesheet">
    <link href="${projectPath }/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
    <link href="${projectPath }/css/animate.min.css" rel="stylesheet">
    <link href="${projectPath }/css/style.min.css" rel="stylesheet">

</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">

        <!-- Panel Other -->
        <div class="ibox float-e-margins">
           
            <div class="ibox-content">
                <div class="row row-lg">
                    <div class="col-sm-12">
                        <!-- Example Card View -->
                        <div class="example-wrap">
                            <h4 class="example-title"></h4>
                            <div class="example">
                            	<form id="search-form" class="form-inline" role="form">
                            		<div class="form-group">
						    		    <label>用户名：</label>
						    		    <input type="text" name="loginLog.username" class="form-control">
						  		    </div>
						  		    <div class="form-group">
						    		    <label>登录来源：</label>
						    		    <select name="loginLog.source" class="form-control">
						    		    	<option value="">请选择</option>
						    		    	<option value="1">用户端</option>
						    		    	<option value="2">后端</option>
						    		    </select>
						  		    </div>
						  		    
						  		    <button id="search" type="button" class="btn btn-success">搜索</button>
								</form>
                            	<div class="btn-group hidden-xs" id="exampleToolbar" role="group">
                                    <button id="setLoanStatus" type="button" class="btn btn-outline btn-default" title="放款审批">
                                        	放款审批
                                    </button>
                                </div>
                                <table id="loginLogListTable" 
                                data-toggle="table"
                                data-method="post"
                                data-url="${projectPath }/loginLog/loginLogListData.action" 
                                data-content-type="application/x-www-form-urlencoded"
                                data-query-params-type=""
						    	data-pagination="true"
						    	data-side-pagination="server"
						        data-toolbar="#exampleToolbar"
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
                                            <th data-field="username" data-align="center">用户名</th>
                                            <th data-field="ipAddress" data-align="center">IP</th>
                                            <th data-field="loginState" data-align="center" data-formatter="loginStateFormatter">登录状态</th>
                                            <th data-field="source" data-align="center" data-formatter="sourceFormatter">登录来源</th>
                                            <th data-field="createTime" data-align="center">时间</th>
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
    <script src="${projectPath }/js/jquery.min.js"></script>
    <script src="${projectPath }/js/bootstrap.min.js"></script>
    <script src="${projectPath }/js/content.min.js"></script>
    <script src="${projectPath }/js/plugins/layui/layer/layer.js" ></script>
    <script src="${projectPath }/js/plugins/bootstrap-table/bootstrap-table.min.js" ></script>
    <script src="${projectPath }/js/plugins/bootstrap-table/bootstrap-table-mobile.min.js"></script>
    <script src="${projectPath }/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
    <script src="${projectPath }/js/plugins/layui/laydate/laydate.js"></script>
    <script src="${projectPath }/js/common.js"></script>
    <script type="text/javascript">
    var $loginLogListTable = $("#loginLogListTable");
    
    
   
    function loginStateFormatter(value,row,index){
    	if(value==0)return '登录失败';
    	if(value==1)return '登录成功';
    }
   
    function sourceFormatter(value,row,index){
    	if(value==1)return '用户端';
    	if(value==2)return '后端';
    }
    
    function queryParams(params){
    	var b= $.extend({},params,$("#search-form").serializeJson());
    	return b;
    }
    
    $(document).on('click','#search',function(){
    	$loginLogListTable.bootstrapTable("refresh");
    })
    </script>
</body>

</html>