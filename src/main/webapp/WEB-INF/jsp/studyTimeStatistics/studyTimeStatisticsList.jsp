<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="projectPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>学时统计管理</title>

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
                <h5>学时统计列表</h5>
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
                            	<form id="search-form" class="form-inline" role="form">
								    <div class="form-group" style="width: 18%;padding-top: 5px;padding-bottom: 5px;">
						    		    <label>企业名称：</label>
						    		    <input type="text" name="searchBusinessName" class="form-control">
						  		    </div>
								    <div class="form-group"  style="width: 18%;">
						    		    <label>负责人姓名：</label>
						    		    <input type="text" name="searchDutyName" class="form-control">
						  		    </div>
								    <div class="form-group"  style="width: 18%;">
						    		    <label>员工数：</label>
						    		    <input type="text" name="searchEmployeeCount" class="form-control">
						  		    </div>
						  		    <div class="form-group" style="width: 18%;">
						    		    <label>所属行业:</label>
						    		    <select name="searchIndustryId" class="form-control">
						    		    	<option value="">请选择</option>
						    		    	<c:forEach items="${industryList }" var="industry">
							    		    	<option value="${industry.id }">${industry.name }</option>
						    		    	</c:forEach>
						    		    </select>
						  		    </div>
								    <div class="form-group"  style="width: 18%;">
						    		    <label>达标率起始：</label>
						    		    <input type="text" name="searchStandardPercentStart" class="form-control">
						  		    </div>
								    <div class="form-group"  style="width: 18%;">
						    		    <label>达标率终止：</label>
						    		    <input type="text" name="searchStandardPercentEnd" class="form-control">
						  		    </div>
						  		    <button id="search" type="button" class="btn btn-success">搜索</button>
								</form>
                            	<div class="btn-group hidden-xs" id="exampleToolbar" role="group">
                                    <button id="detail" type="button" class="btn btn-outline btn-default" title="详情">
                                        <i class="glyphicon glyphicon-edit" aria-hidden="true"></i> 详情
                                    </button>
                                </div>
                                <table id="studyTimeStatisticsListTable" 
                                data-toggle="table"
                                data-method="post"
                                data-url="${projectPath }/studyTimeStatistics/studyTimeStatisticsListData.action" 
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
                                            <th data-field="businessName" data-align="center">企业名称</th>
                                            <th data-field="industryName" data-align="center">所属行业</th>
                                            <th data-field="dutyName" data-align="center">负责人姓名</th>
                                            <th data-field="dutyPhone" data-align="center">负责人电话</th>
                                            <th data-field="saveName" data-align="center">安全员姓名</th>
                                            <th data-field="savePhone" data-align="center">安全员电话</th>
                                            <th data-field="employeeCount" data-align="center">员工数量</th>
                                            <th data-field="studyTimeStandardCount" data-align="center">学时达标人数</th>
                                            <th data-field="standardPercent" data-align="center" data-formatter="standardPercentFormatter">达标率</th>
                                            <th data-field="averageStudyTime" data-align="center">人均学时</th>
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
    <script src="${projectPath }/js/common.js"></script>
    <script type="text/javascript">
    var $studyTimeStatisticsListTable = $("#studyTimeStatisticsListTable");
    $(document).on('click','#add',function(){
		layer.open({
			type: 2, 
			title:'<i class="glyphicon glyphicon-studyTimeStatistics"></i> 添加行业',
			area: ['800px', '500px'],
			content: '${projectPath}/studyTimeStatistics/studyTimeStatisticsAdd.action'
		});
	});
    $(document).on('click','#detail',function(){
    	var rows = $studyTimeStatisticsListTable.bootstrapTable('getSelections');
		if(rows.length!=1){
			layer.alert('请选择一行',{icon:0});
			return false;
		}
		layer.open({
			type: 2, 
			title:'<i class="glyphicon glyphicon-studyTimeStatistics"></i> 学时统计详情',
			area: ['800px', '500px'],
			content: '${projectPath}/studyTimeStatistics/studyTimeStatisticsEdit.action?id='+rows[0].id
		});
	});
    
    function queryParams(params){
    	var b= $.extend({},params,$("#search-form").serializeJson());
    	return b;
    }
    
    $(document).on('click','#search',function(){
    	$studyTimeStatisticsListTable.bootstrapTable("refresh");
    })
    
    function standardPercentFormatter(value,row,index){
		return (value * 100) + "%";
	}
    </script>
</body>

</html>