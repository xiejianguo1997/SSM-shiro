<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="projectPath" value="${pageContext.request.contextPath }"></c:set>

<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>分局用户管理-编辑分局用户</title>

    <link href="${projectPath }/css/bootstrap.min.css" rel="stylesheet">
    <link href="${projectPath }/css/font-awesome.min.css" rel="stylesheet">
    <link href="${projectPath }/css/plugins/ztree/metroStyle/metroStyle.css" rel="stylesheet"/>
    <link href="${projectPath }/css/animate.min.css" rel="stylesheet">
    <link href="${projectPath }/css/style.min.css" rel="stylesheet">
    <link href="${projectPath }/js/plugins/viewer/css/viewer.min.css" rel="stylesheet">

	<style type="text/css">
		td  
		{  
		    text-align:center;  
		}
		th  
		{  
		    text-align:center;  
		}  
	</style>
</head>

<body>
    <div class="wrapper wrapper-content animated fadeInRight">

        <form class="form-horizontal m-t" id="studyTimeCheckForm" action="${projectPath }/studyTimeCheck/studyTimeCheckCheck.action" method="post">
        	<input name="studyTimeCheckId" type="hidden" value="${studyTimeCheckCustom.id }">
        	<div class="form-group">
        		<div class="col-sm-9">
        			<div class="form-group">
		                <label class="col-sm-2 control-label">姓名：</label>
		                <div class="col-sm-2">
		                	<input class="form-control" type="text" disabled="disabled" value="${studyTimeCheckCustom.employeeName }" />
		                </div>
		                <label class="col-sm-2 control-label">角色：</label>
		                <div class="col-sm-2">
		                	<input class="form-control" type="text" disabled="disabled" value="${studyTimeCheckCustom.roleName }" />
		                </div>
		                <label class="col-sm-2 control-label">身份证号：</label>
		                <div class="col-sm-2">
		                	<input class="form-control" type="text" disabled="disabled" value="${studyTimeCheckCustom.certIdNum }" />
		                </div>
		            </div>
		            <div class="form-group">
		                <label class="col-sm-2 control-label">所属公司：</label>
		                <div class="col-sm-2">
		                	<input class="form-control" type="text" disabled="disabled" value="${studyTimeCheckCustom.businessName }" />
		                </div>
		                <label class="col-sm-2 control-label">所属行业：</label>
		                <div class="col-sm-2">
		                	<input class="form-control" type="text" disabled="disabled" value="${studyTimeCheckCustom.industryName }" />
		                </div>
		                <label class="col-sm-2 control-label">所属分局：</label>
		                <div class="col-sm-2">
		                	<input class="form-control" type="text" disabled="disabled" value="${studyTimeCheckCustom.substationName }" />
		                </div>
		            </div>
		            <div class="form-group">
		                <label class="col-sm-2 control-label">待审核时长：</label>
		                <div class="col-sm-2">
		                	<input class="form-control" type="text" disabled="disabled" value="${studyTimeCheckCustom.spendTime }" />
		                </div>
		                <label class="col-sm-2 control-label">时常来源：</label>
		                <div class="col-sm-2">
		                	<input class="form-control" type="text" disabled="disabled" value="<c:choose><c:when test='${studyTimeCheckCustom.type == 1}'>测评</c:when><c:otherwise>视频</c:otherwise></c:choose>"/>
		                </div>
		            </div>
        		</div>
        		<div class="col-sm-3">
        			<div class="col-sm-10" style="text-align: center;">
        				<img alt="用户第一次拍照取证" style="height: 150px; cursor: zoom-in;" class="img-thumbnail" src="${fileServerUrl}${firstWeiXinCamera.url }">
        			</div>
        			<div class="col-sm-2">
        				<%-- <img alt="用户本次学习拍照取证" style="height: 200px; cursor: zoom-in;" class="img-thumbnail" src="${fileServerUrl}${lastWeiXinCamera.url }"> --%>
        			</div>
        		</div>
        	</div>
            
            <div class="form-group">
                <label class="col-sm-6 control-label"></label>
                <div class="col-sm-2">
                	<button id="studyTimeCheckFormSubmit" class="btn btn-primary" type="submit">审核</button>
                </div>
            </div>
            
            <div class="form-group"></div>
            
            <!-- 测评学习 -->
            <c:if test="${type == 1 }">
            	<div class="table-responsive">
			        <table class="table table-bordered table-striped">
			            <thead>
				            <tr>
				                <th style="width: 20%">测评时间</th>
				                <th style="width: 20%">测评分数</th>
				                <th style="width: 20%">学时</th>
				                <th style="width: 20%">答题数</th>
				                <th style="width: 20%">测评拍照</th>
				            </tr>
			            </thead>
			            <tbody>
			            	<c:forEach items="${studyTimeDetailList }" var="studyTimeDetail">
					            <tr>
					                <th class="text-nowrap"><fmt:formatDate type="both" value="${studyTimeDetail.createTime }" /></th>
					                <th class="text-nowrap">${studyTimeDetail.score }</th>
					                <th class="text-nowrap">${studyTimeDetail.examTime }</th>
					                <th class="text-nowrap">${studyTimeDetail.answerCount }</th>
					                <th class="text-nowrap"><%-- ${studyTimeDetail.dataStatus } --%>
					                	<img alt="本次测评图片" style="height: 40px; cursor: zoom-in;" class="img-thumbnail" src="${fileServerUrl}${studyTimeDetail.url }">
					                </th>
					            </tr>
			            	</c:forEach>
			            </tbody>
			        </table>
			    </div>
            </c:if>
            
            <!-- 视频学习 -->
            <c:if test="${type == 2 }">
            	<div class="table-responsive">
			        <table class="table table-bordered table-striped">
			            <thead>
				            <tr>
				                <th style="width: 18%">视频名称</th>
				                <th style="width: 18%">视频时长</th>
				                <th style="width: 18%">观看时长</th>
				                <th style="width: 18%">拟增加时长</th>
				                <th style="width: 18%">开始观看时间</th>
				                <th style="width: 10%">视频拍照</th>
				            </tr>
			            </thead>
			            <tbody>
			            	<c:forEach items="${studyTimeDetailList }" var="studyTimeDetail">
					            <tr>
					                <th class="text-nowrap">${studyTimeDetail.videoName }</th>
					                <th class="text-nowrap">${studyTimeDetail.videoTime }</th>
					                <th class="text-nowrap">${studyTimeDetail.spendTime }</th>
					                <th class="text-nowrap">${studyTimeDetail.spendTime }</th>
					                <th class="text-nowrap"><fmt:formatDate type="both" value="${studyTimeDetail.studyTime }" /></th>
					                <th class="text-nowrap"><%-- ${studyTimeDetail.dataStatus } --%>
					                	<img alt="本次测评图片" style="height: 40px; cursor: zoom-in;" class="img-thumbnail" src="${fileServerUrl}${studyTimeDetail.url }">
					                </th>
					            </tr>
			            	</c:forEach>
			            </tbody>
			        </table>
			    </div>
            </c:if>
            
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
    <script src="${projectPath }/js/plugins/viewer/js/viewer-jquery.min.js" ></script>
    <script type="text/javascript">
    
    $('body').viewer();
    
     $("#studyTimeCheckForm").validate({
    	submitHandler:function(form){
    		$("#studyTimeCheckFormSubmit").button('loading');
    		$(form).ajaxSubmit({
				type:"POST",
				url:$(form).attr("action"),
				success:function(data){
					if(data.resultInfo.success){
						parent.$("#studyTimeListTableOne").bootstrapTable("refresh");
						parent.$("#studyTimeListTableTwo").bootstrapTable("refresh");
						parent.layer.alert(data.resultInfo.message,{icon: 1});
						var index = parent.layer.getFrameIndex(window.name); 
						parent.layer.close(index); 
					}else{
						$("#studyTimeFormSubmit").button('reset');
					}
				}
			});
			return false;
        }   
    });
    </script>
</body>

</html>