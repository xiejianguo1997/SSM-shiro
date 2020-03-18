<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="projectPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>视频管理-编辑视频</title>

    <link href="${projectPath }/css/bootstrap.min.css" rel="stylesheet">
    <link href="${projectPath }/css/font-awesome.min.css" rel="stylesheet">
    <link href="${projectPath }/css/plugins/ztree/metroStyle/metroStyle.css" rel="stylesheet"/>
    <link href="${projectPath }/css/animate.min.css" rel="stylesheet">
    <link href="${projectPath }/css/style.min.css" rel="stylesheet">

	<link href="${projectPath }/css/plugins/webuploader/webuploader.css" rel="stylesheet">
</head>

<body>
    <div class="wrapper wrapper-content animated fadeInRight">

        <form class="form-horizontal m-t" id="videoForm" action="${projectPath }/video/videoEdit.action" method="post">
        	<input type="hidden" name="id" value="${video.id }">
            <div class="form-group">
                <label class="col-sm-3 control-label">视频名称：</label>
                <div class="col-sm-8">
                	<input name="videoName" class="form-control" type="text" required="required" value="${video.videoName }" />
                </div>
            </div>
            <!-- 上传模块 -->
      		<div class="form-group">
                <label class="col-sm-3 control-label">附件：</label>
                <div class="col-sm-8">
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
            <div class="form-group">
                <label class="col-sm-3 control-label">状态：</label>
                <div class="col-sm-8">
                    <select name="dataStatus" class="form-control" required="required">
                    	<option value="1" <c:if test="${video.dataStatus == 1 }">selected="selected"</c:if>>启用</option>
                    	<option value="0" <c:if test="${video.dataStatus == 0 }">selected="selected"</c:if>>禁用</option>
                    </select>
                </div>
            </div>
            
            <div class="form-group">
                <div class="col-sm-8 col-sm-offset-3">
                    <button id="videoFormSubmit" class="btn btn-primary" type="submit">提交</button>
                </div>
            </div>
        </form>
    </div>
    <script type="text/javascript">
    var fileServerUrl = "${fileServerUrl}";
    </script>
    <script src="${projectPath }/js/jquery.min.js"></script>
    <script src="${projectPath }/js/bootstrap.min.js"></script>
    <script src="${projectPath }/js/content.min.js"></script>
    <script src="${projectPath }/js/plugins/validate/jquery.validate.min.js" ></script>
    <script src="${projectPath }/js/plugins/validate/messages_zh.min.js" ></script>
    <script src="${projectPath }/js/jquery.form.js" ></script>
    <script src="${projectPath }/js/demo/form-validate-demo.js" ></script>
    <script src="${projectPath }/js/plugins/ztree/jquery.ztree.all.min.js"></script>
    <script src="${projectPath }/js/common.js"></script>
      
     <script src="${projectPath }/js/plugins/webuploader/webuploader.min.js"></script>
    <script src="${projectPath }/js/demo/VideoUpload.js"></script>
    <script type="text/javascript">
     $("#videoForm").validate({
    	submitHandler:function(form){
    		$("#videoFormSubmit").button('loading');
    		$(form).ajaxSubmit({
				type:"POST",
				url:$(form).attr("action"),
				success:function(data){
					if(data.resultInfo.success){
						parent.$("#videoListTable").bootstrapTable("refresh");
						parent.layer.alert(data.resultInfo.message,{icon: 1});
						var index = parent.layer.getFrameIndex(window.name); 
						parent.layer.close(index); 
					}else{
						$("#videoFormSubmit").button('reset');
					}
				}
			});
			return false;
        }   
    }); 
    </script>
</body>

</html>