<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="projectPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>HTML5</title>
  <script>if(window.top !== window.self){ window.top.location = window.location;}</script>
  <meta name="description" content="particles.js is a lightweight JavaScript library for creating particles.">
  <meta name="author" content="Vincent Garreau" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <link rel="stylesheet" media="screen" href="${projectPath }/css/style.css">
  <link rel="stylesheet" type="text/css" href="${projectPath }/css/reset.css"/>
  <style type="text/css">
	.login .errorTips{height: 30px; line-height: 30px; font-size: 16px; color: #f66; margin-top: 20px;}
  </style>
</head>
<body>
<div id="particles-js">
		<div class="login">
			<form action="${projectPath }/login.action" method="post">
			<div class="login-top">
			登录
			</div>
			<div class="login-center clearfix">
				<div class="login-center-img"><img src="img/name.png"/></div>
				<div class="login-center-input">
					<input type="text" name="username" value="${username }" placeholder="请输入您的用户名" onfocus="this.placeholder=''" onblur="this.placeholder='请输入您的用户名'"/>
					<div class="login-center-input-text">用户名</div>
				</div>
			</div>
			<div class="login-center clearfix">
				<div class="login-center-img"><img src="img/password.png"/></div>
				<div class="login-center-input">
					<input type="password" name="password" placeholder="请输入您的密码" onfocus="this.placeholder=''" onblur="this.placeholder='请输入您的密码'"/>
					<div class="login-center-input-text">密 码</div>
				</div>
			</div>
			<TR>
							<TD>验证码：</TD>
							<TD><input id="randomcode" name="randomcode" size="8" /> <img
								id="randomcode_img" src="${projectPath }/validatecode.action" alt="验证码"
								width="56" height="20" align='absMiddle' /> <a id ="aid"
								href="">刷新</a></TD>
						</TR>
						<tr>
							<TD></TD>
							<td><input type="checkbox" name="rememberMe" />自动登陆</td>
						</tr>
			<div class="login-center">
			<div class="errorTips" >${msg }</div>
			</div>
			<div class="login-button">
			<input type="submit" value="登录">
			</div>
		</div>
		</form>
		<div class="sk-rotating-plane"></div>
</div>

<!-- scripts -->
<script src="${projectPath }/js/particles.min.js"></script>
<script src="${projectPath }/js/app.js"></script>
<script src="${projectPath }/js/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	  $("#aid").click(function(){
	  htmlobj=$.ajax({url:"${projectPath }/validatecode.action",async:false});
	  $("#randomcode_img").html(htmlobj);
	  });
	});
	function hasClass(elem, cls) {
	  cls = cls || '';
	  if (cls.replace(/\s/g, '').length == 0) return false; //å½clsæ²¡æåæ°æ¶ï¼è¿åfalse
	  return new RegExp(' ' + cls + ' ').test(' ' + elem.className + ' ');
	}
	 
	function addClass(ele, cls) {
	  if (!hasClass(ele, cls)) {
	    ele.className = ele.className == '' ? cls : ele.className + ' ' + cls;
	  }
	}
	 
	function removeClass(ele, cls) {
	  if (hasClass(ele, cls)) {
	    var newClass = ' ' + ele.className.replace(/[\t\r\n]/g, '') + ' ';
	    while (newClass.indexOf(' ' + cls + ' ') >= 0) {
	      newClass = newClass.replace(' ' + cls + ' ', ' ');
	    }
	    ele.className = newClass.replace(/^\s+|\s+$/g, '');
	  }
	}
		document.querySelector(".login-button").onclick = function(){
				addClass(document.querySelector(".login"), "active")
				setTimeout(function(){
					addClass(document.querySelector(".sk-rotating-plane"), "active")
					document.querySelector(".login").style.display = "none"
				},800)
				setTimeout(function(){
					removeClass(document.querySelector(".login"), "active")
					removeClass(document.querySelector(".sk-rotating-plane"), "active")
					document.querySelector(".login").style.display = "block"
					//alert("ç»å½æå")
					
				},5000)
		}
		
		
</script>
<div style="text-align:center;">

</div>
</body>
</html>