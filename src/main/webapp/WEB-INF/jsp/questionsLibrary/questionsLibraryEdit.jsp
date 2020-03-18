<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="projectPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>试题库管理-编辑试题库</title>

    <link href="${projectPath }/css/bootstrap.min.css" rel="stylesheet">
    <link href="${projectPath }/css/font-awesome.min.css" rel="stylesheet">
    <link href="${projectPath }/css/plugins/ztree/metroStyle/metroStyle.css" rel="stylesheet"/>
    <link href="${projectPath }/css/animate.min.css" rel="stylesheet">
    <link href="${projectPath }/css/style.min.css" rel="stylesheet">
    <link href="${projectPath }/css/plugins/webuploader/webuploader.css" rel="stylesheet">

</head>
<script type="text/javascript">
	var fileServerUrl = "${fileServerUrl }";
</script>
<body>
    <div class="wrapper wrapper-content animated fadeInRight">

        <form class="form-horizontal m-t" id="questionsLibraryForm" action="${projectPath }/questionsLibrary/questionsLibraryEdit.action" method="post">
        	<input type="hidden" name="id" value="${questionsLibrary.id }">
            <div class="form-group">
                <label class="col-sm-3 control-label">试题：</label>
                <div class="col-sm-8">
                    <input id="" name="question" class="form-control" type="text" required="required" value="${questionsLibrary.question }">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">所属行业：</label>
                <div class="col-sm-8">
                    <select name="industryId" class="form-control" required="required">
                    	<c:forEach var="industry" items="${industryList }" varStatus="industryStatus">
	                    	<option value="${industry.id }" <c:if test="${industry.id == questionsLibrary.industryId}">checked="checked"</c:if>>${industry.name }</option>
                    	</c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">考题类型：</label>
                <div class="col-sm-8" >
                    <div class="radio">
                         <label style="margin-right: 20px;">
                             <input type="radio" value="1"  name="type" required="required" <c:if test="${questionsLibrary.type == 1}">checked="checked"</c:if> style="margin-top: 1px;"> 单选
                         </label>
                         <label>
                             <input type="radio" value="2"  name="type" required="required" <c:if test="${questionsLibrary.type == 2}">checked="checked"</c:if> style="margin-top: 1px;"> 复选
                         </label>
                     </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">选项A：</label>
                <div class="col-sm-8">
                    <input id="optionA" name="optionA" class="form-control" type="text" required="required" value="${questionsLibrary.optionA }">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">选项B：</label>
                <div class="col-sm-8">
                    <input id="optionB" name="optionB" class="form-control" type="text" required="required" value="${questionsLibrary.optionB }">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">选项C：</label>
                <div class="col-sm-8">
                    <input id="optionC" name="optionC" class="form-control" type="text" value="${questionsLibrary.optionC }">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">选项D：</label>
                <div class="col-sm-8">
                    <input id="optionD" name="optionD" class="form-control" type="text" value="${questionsLibrary.optionD }">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">试题图片：</label>
                <%-- <div class="col-sm-8">
                    <input id="questionImg" name="questionImg" class="form-control" type="text" value="${questionsLibrary.questionImg }">
                </div> --%>
                <div class="col-sm-8">
                    <div id="uploader_imgUrl" class="wu-example">
					    <!--用来存放文件信息-->
					    <div id="thelist_imgUrl" class="uploader-list"></div>
					    <div class="btns">
					        <div id="picker_imgUrl">选择文件</div>
					        <a id="ctlBtn_imgUrl" class="btn btn-white" role="button">开始上传</a>
					    </div>
					</div>
					<c:choose>
                    	<c:when test="${questionsLibrary.questionImg != null and questionsLibrary.questionImg!=''}">
	                    <img id="img_imgUrl" src="${fileServerUrl }${questionsLibrary.questionImg }" alt="..." class="img-thumbnail" style="height:100px;margin-top: 10px;">
	                    </c:when>
	                    <c:otherwise>
	                    <img id="img_imgUrl" src="" alt="..." class="img-thumbnail" style="height:100px;margin-top: 10px;display: none;">
	                    </c:otherwise>
                    </c:choose>
                    <input id="imgUrl" type="hidden" name="questionImg" value="${questionsLibrary.questionImg }">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">正确答案：</label>
                <div class="col-sm-8" style="margin-top: 6px;">
                    <label style="margin-right: 20px;">
                        <input type="checkbox" name="correctOption" value="1" style="margin-top: -2px; vertical-align:middle;" <c:if test="${fn:contains(questionsLibrary.correctOption,1)}">checked="checked"</c:if>>
                         A
                    </label>
                    <label style="margin-right: 20px;">
                        <input type="checkbox" name="correctOption" value="2" style="margin-top: -2px; vertical-align:middle;" <c:if test="${fn:contains(questionsLibrary.correctOption,2)}">checked="checked"</c:if>>
                         B
                    </label>
                    <label style="margin-right: 20px;">
                        <input type="checkbox" name="correctOption" value="3" style="margin-top: -2px; vertical-align:middle;" <c:if test="${fn:contains(questionsLibrary.correctOption,3)}">checked="checked"</c:if>>
                         C
                    </label>
                    <label>
                        <input type="checkbox" name="correctOption" value="4" style="margin-top: -2px; vertical-align:middle;" <c:if test="${fn:contains(questionsLibrary.correctOption,4)}">checked="checked"</c:if>>
                         D
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">试题解析：</label>
                <div class="col-sm-8">
                    <textarea name="questionAnalysis" class="form-control" aria-required="true">${questionsLibrary.questionAnalysis }</textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">数据状态：</label>
                <div class="col-sm-8">
                    <select name="dataStatus" class="form-control" required="required">
                    	<option value="1" <c:if test="${questionsLibrary.dataStatus == 1 }">selected="selected"</c:if>>启用</option>
                    	<option value="0" <c:if test="${questionsLibrary.dataStatus == 0 }">selected="selected"</c:if>>禁用</option>
                    </select>
                </div>
            </div>
            
            <div class="form-group">
                <div class="col-sm-8 col-sm-offset-3">
                    <button id="questionsLibraryFormSubmit" class="btn btn-primary" type="submit">提交</button>
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
    <script src="${projectPath }/js/plugins/webuploader/webuploader.min.js"></script>
    <script src="${projectPath }/js/demo/questionImgUpload.js"></script>
    
    <script type="text/javascript">
     $("#questionsLibraryForm").validate({
    	submitHandler:function(form){
    		$("#questionsLibraryFormSubmit").button('loading');
    		$(form).ajaxSubmit({
				type:"POST",
				url:$(form).attr("action"),
				success:function(data){
					if(data.resultInfo.success){
						parent.$questionsLibraryListTable.bootstrapTable("refresh");
						parent.layer.alert(data.resultInfo.message,{icon: 1});
						var index = parent.layer.getFrameIndex(window.name); 
						parent.layer.close(index); 
					}else{
						$("#questionsLibraryFormSubmit").button('reset');
					}
				}
			});
			return false;
        }   
    }); 
    </script>
</body>

</html>