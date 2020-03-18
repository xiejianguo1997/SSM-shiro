<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="projectPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录超时</title>
<style type="text/css">
*{margin: 0; padding: 0;}
.round{width: 600px; margin: 150px auto 50px; position: relative;}
.circle{width: 422px; height: 422px; margin: 0 auto; background: url(${projectPath}/img/circle.png) no-repeat; animation:turn 5s; -webkit-animation:turn 5s;}
@keyframes turn{
	from{
		-webkit-transition: -webkit-transform ease-out;
		-moz-transition: -moz-transform ease-out;
		-o-transition: -o-transform ease-out;
		-ms-transition: -ms-transform ease-out;
	}
	to{
		-webkit-transform: rotateZ(360deg);
		-moz-transform: rotateZ(360deg);
		-o-transform: rotateZ(360deg);
		-ms-transform: rotateZ(360deg);
		transform: rotateZ(360deg);
	}
}
@-webkit-keyframes turn{
	from{
		-webkit-transition: -webkit-transform ease-out;
		-moz-transition: -moz-transform ease-out;
		-o-transition: -o-transform ease-out;
		-ms-transition: -ms-transform ease-out;
	}
	to{
		-webkit-transform: rotateZ(360deg);
		-moz-transform: rotateZ(360deg);
		-o-transform: rotateZ(360deg);
		-ms-transform: rotateZ(360deg);
		transform: rotateZ(360deg);
	}
}
.time{width: 200px; height: 200px; position: absolute; left: 200px; top: 120px; color: #fff; text-align: center; font-size: 20px;}
.time span{font-size: 150px;}
.text{font-size: 20px; color: #999; text-align: center;}
.button{width: 230px; height: 50px; text-align: center; line-height: 50px; margin: 0 auto;}
.button a{display: block; font-size: 20px; background: #297fff; color: #fff; text-decoration: none; border-radius: 10px;}
</style>
</head>

<body>
<div class="round">
	<div class="circle"></div>
	<div class="time"><span id="leftSecond">5</span>秒</div>
	<div class="text">登录失效，倒计时结束后将自动退出。</div>
</div>
<div class="button">
	<a href="javascript:void(0)" onclick="logout()">立即登录</a>
</div>
<script type="text/javascript">

var leftTime=5;//倒计时	
var timeId= setInterval(function name() {
	leftTime--;
	document.getElementById("leftSecond").innerHTML = leftTime;
	if(leftTime<=0){
		clearTimeout(timeId);//暂停
		logout();//退出
	}
}, 1000);

//退出
function logout(){
	//由于可能出现多个父窗口，所以这里需要判断下
	var loginUrl="${projectPath}/login.action";
	//页面跳转
	if (parent.parent.parent) {
		parent.parent.parent.location=loginUrl;
	}else if(parent.parent){
		parent.parent.location=loginUrl;
	}else if (parent) {
		parent.location=loginUrl;
	}else {
		window.location=loginUrl;
	}
}
</script>
</body>
</html>