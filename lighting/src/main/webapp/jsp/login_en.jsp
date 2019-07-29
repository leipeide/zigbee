<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="java.util.*,com.test.domain.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/layui/css/layui.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/layui/layui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/jquery.min.js"></script>
<title>浙江雷培德zigbee灯光智能控制系统</title>
<style>
html {
	background: url('<%=request.getContextPath()%>/jsp/loginbg.jpg')
		no-repeat center center fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}
.main-form-div {
	margin-top: 80px;
}
.main-form-body {
	padding-top: 40px;
	padding-left: 10%;
	padding-right: 10%;
	padding-bottom: 40px;
}
.errorlabel{
	margin-left:110px;
}
</style>
</head>
<body class="layui-layout-body">
	<div class="layui-row main-form-div">
		<div class="layui-col-xs1 layui-col-sm3 layui-col-md4">
 			<div class="grid-demo layui-bg-red" style="visibility:hidden">移动：1/12 | 平板：3/12 | 桌面：4/12</div> 
		</div>
		<div class="layui-col-xs10 layui-col-sm6 layui-col-md4">
			<div class="grid-demo layui-bg-#F0F0F0">
				<div class="main-form-body" id="mainDiv">
					<form name="mainform" role="form" class="layui-form"
						action="${pageContext.request.contextPath}/user/login.do"
						method="post">
						
						<div class="layui-form-item">
							<label class="errorlabel" id="error" style="color:red"></label>
						</div>	
						<div class="layui-form-item">
  							<label class="layui-form-label">Username</label>
							<div class="layui-input-inline">
								<input type="text" id="username" class="layui-input"  placeholder="username"  name="username" autocomplete="off" onblur="test()" onkeyup="test()">
								<span style="color:red; display:none" id="usernameSpan">Please enter username</span>
							</div>
						</div>
						<div class="layui-form-item">
							<label class="layui-form-label">Password</label>
							<div class="layui-input-inline">
								<input type="password" id="inputPassword" class="layui-input" placeholder="password"  name="password" onblur="test()" onkeyup="test()">
								<span style="color:red; display:none" id="passwordSpan">Please enter password</span>
							</div>
						</div>
						<div id="repassword"></div>
						<div id="email"></div>
						<div id="phone"></div>
						<div class="layui-input-block">
							<button type="button" class="layui-btn layui-btn-primary"
								lay-submit lay-filter="regitfilter">Register</button>
							&nbsp;&nbsp;
							<button id="submit" type="submit"
								class="layui-btn layui-btn-primary" lay-submit lay-filter="loginfilter">Login</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="layui-col-xs1 layui-col-sm3 layui-col-md4">
 			<div class="grid-demo layui-bg-blue" style="visibility:hidden">移动：1/12 | 平板：3/12 | 桌面：4/12</div>
		</div>
	</div>

	<script type="text/javascript">
        var localhost = "<%=request.getContextPath()%>";
		var emailReg = /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+/;//判断邮箱地址合法正则
		var phoneReg = /^1([38]\d|5[0-35-9]|7[3678])\d{8}$/;
		var flags = {};
		flags.hidden = true;
		flags.password = mainform.password.value;
		flags.passwordRepeat = null;
		flags.error = null;
		
		/*
		2.获取control返回的登录错误提示
		*/
		var jsonStr = '<%=request.getAttribute("responseJson")%>';
		if (jsonStr != 'null') {
			var responseJson = JSON.parse(jsonStr);
			flags.error = responseJson.error;
			//使登录错误提示在登录页面显示
			document.getElementById('error').innerHTML = flags.error;
		}
		
		layui.use('form', function() {
			var form = layui.form;
			//监听form表单
			form.on('submit(loginfilter)', function(data) {
				login(flags);
				//return false;//return false阻止表单提交，终止函数，return false后面的函数均不执行
			});
			
			form.on('submit(regitfilter)', function(data) {
				registe(flags,localhost);
				return false;
			});
		});
		
		
		/*1.改变“登录”按钮的类型;
		           登录页面时的类型是submit,点击时进行登录操作提交参数至Use Control层；
	                      注册页面时的类型是button，点击时跳转至登录页面     
	    */
		function login(flags){
			var subBtn = document.getElementById("submit");
			if (flags.hidden == false) {
				flags.hidden = true;
				subBtn.type = "button";
			}
			if(flags.hidden == true){
				subBtn.type = "submit";
			}
		}
		           
	   /*
	    3.注册操作
	   */
		function registe(flags,localhost){
			 document.getElementById('error').innerHTML = " ";
			 if (flags.hidden == true) {
					flags.hidden = false;
					document.getElementById('repassword').innerHTML = "<div class='layui-form-item'><label class='layui-form-label' >rePassword</label><div class='layui-input-inline'><input id='inputRepassword' type='password' class='layui-input' placeholder='password'  name='passwordRepeat' onblur='test()' onkeyup='test()'><span style='color: red; display: none;' id='passwordRepeatSpan'>Two inconsistencies in password input</span></div></div>";
					document.getElementById('email').innerHTML = "<div class='layui-form-item'><label class='layui-form-label'>Email</label><div class='layui-input-inline'><input  id='inputEmail' type='text' class='layui-input' placeholder='email' name='email' onblur='test()' onkeyup='test()'><span style='color: red; display: none' id='emailSpan'>The mailbox format is incorrect</span></div></div>";
					document.getElementById('phone').innerHTML = "<div class='layui-form-item'><label class='layui-form-label'>Phone</label><div class='layui-input-inline'><input id='inputPhone' type='text' class='layui-input' placeholder='phone' name='phone' onblur='test()' onkeyup='test()'><span style='color: red; display: none' id='phoneSpan'>Incorrect format of mobile phone number</span></div></div>";
			} else {

					if (mainform.password.value != mainform.passwordRepeat.value) {
						// alert("两次输入密码不一致");
					} else if (mainform.password.value == ""
						|| mainform.password.value == null) {
						// alert("密码不能为空");
					} else if (mainform.username.value == ""
						|| mainform.username.value == null) {
						// alert("请输入用户名");
					} else if (!emailReg.test(mainform.email.value)) {
						// 手机号不为空
					} else if(mainform.phone.value == "" || mainform.phone.value == null){
						
					}else {
						$.ajax({
							type : "post",
							url : localhost + "/user/regist.do",
							data : {
								username : mainform.username.value,
								password : mainform.password.value,
								email : mainform.email.value,
								phone : mainform.phone.value
							},
							async : true,
							datatype : "json",
							success : function(datasource, textStatus, jqXHR) {
								var data = eval('(' + datasource + ')');
								if (data.error == null || data.error == "" || data.error == undefined) {//未出错
									layui.use('layer', function() {
										var layer = layui.layer;
										document.getElementById("username").value = "";
										layer.msg('Login was successful!');   
									});
									flags.hidden = true;
									mainform.password.value = "";
									mainform.passwordRepeat.value = "";
									mainform.email.value = "";
									mainform.phone.value = "";
								} else {
									layui.use('layer', function() {
										var layer = layui.layer;
										/*document.getElementById("username").value = "";
										document.getElementById('inputPassword').value = "";
										document.getElementById("inputRepassword").value = "";
										document.getElementById("inputEmail").value = "";
										document.getElementById("inputPhone").value = "";*/
										layer.alert(data.error,{
							 	    		title:"Tips",
							 	    		closeBtn: 0,
								 	        btn : "Close",
							 			    yes : function(index, layero) {
							 		         	 layer.close(index);
							 		        },
							 	    	});   
									});
								}
							},
							error : function() {
								layui.use('layer', function() {
									var layer = layui.layer;
									layer.alert("Registration failed, please try again!",{
						 	    		title:"Error",
						 	    		closeBtn: 0,
							 	        btn : "Close",
						 			    yes : function(index, layero) {
						 		         	 layer.close(index);
						 		        },
						 	    	});
									/*document.getElementById("username").value = "";
									document.getElementById('inputPassword').value = "";
									document.getElementById("inputRepassword").value = "";
									document.getElementById("inputEmail").value = "";
									document.getElementById("inputPhone").value = "";*/
								});
							}
						});
					}
				}
			 document.getElementById("username").value = "";
				document.getElementById('inputPassword').value = "";
				document.getElementById("inputRepassword").value = "";
				document.getElementById("inputEmail").value = "";
				document.getElementById("inputPhone").value = "";
			}

		//3.设置错误提醒样式
		function test() {
			if (mainform.password.value == mainform.passwordRepeat.value) {
				passwordRepeatSpan.setAttribute('style', 'display: none');
			} else {
				passwordRepeatSpan.setAttribute('style',
						'display: inline; color: red');
			}
			if (mainform.password.value == ""
					|| mainform.password.value == null) {
				passwordSpan.setAttribute('style',
						'display: inline; color: red');
			} else {
				passwordSpan.setAttribute('style', 'display: none');
			}
			if (mainform.username.value == ""
					|| mainform.username.value == null) {
				usernameSpan.setAttribute('style',
						'display: inline; color: red');
			} else {
				usernameSpan.setAttribute('style', 'display: none');
			}
			if (!emailReg.test(mainform.email.value)) {
				emailSpan.setAttribute('style', 'display: inline; color: red');
			} else {
				emailSpan.setAttribute('style', 'display: none');
			}
			
			if (!phoneReg.test(mainform.phone.value)) {
				phoneSpan.setAttribute('style','display: inline; color: red');
			} else {
				phoneSpan.setAttribute('style', 'display: none');
			}
			
			
		}
		
	</script>
</html>