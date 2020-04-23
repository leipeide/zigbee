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
	background: url('<%=request.getContextPath()%>/jsp/image/loginbg.jpg')
		no-repeat center center fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}
.main-form-div {
	margin-top: 50px;
}
.main-form-body {
	padding-top: 100px;
	padding-left: 20%;
	padding-right: 10%;
	padding-bottom: 40px;
}
.errorlabel{
	margin-left:110px;
}
.usernameInput{
 	background: url('<%=request.getContextPath()%>/jsp/image/蓝色用户.png')no-repeat left center;
	background-size: 22px 22px;
 	background-position: 5px 4px; 
 	background-color: #ffffff;
 	padding:8px 10px 8px 40px; 
	width:210px;
	height:20px;
}
.passwordInput{ 
	background: url('<%=request.getContextPath()%>/jsp/image/蓝色密码.png')no-repeat;
	background-size: 25px 25px;
 	background-position: 5px 4px; 
 	background-color: #ffffff;
 	padding:8px 10px 8px 40px; 
	width:210px;
	height:20px;
	
}
.inputRepassword{
	background: url('<%=request.getContextPath()%>/jsp/image/蓝色密码.png')no-repeat;
	background-size: 25px 25px;
 	background-position: 5px 4px; 
 	background-color: #ffffff;
 	padding:8px 10px 8px 40px; 
	width:210px;
	height:20px;
}
.inputEmail{
	background: url('<%=request.getContextPath()%>/jsp/image/蓝色邮箱.png')no-repeat;
	background-size: 25px 25px;
 	background-position: 5px 4px; 
 	background-color: #ffffff;
 	padding:8px 10px 8px 40px; 
	width:210px;
	height:20px;
}
.inputPhone{
	background: url('<%=request.getContextPath()%>/jsp/image/蓝色手机.png')no-repeat;
	background-size: 25px 25px;
 	background-position: 5px 4px; 
 	background-color: #ffffff;
 	padding:8px 10px 8px 40px; 
	width:210px;
	height:20px;
}
/* form2的样式 */
.findEmailInput{
	background: url('<%=request.getContextPath()%>/jsp/image/蓝色邮箱.png')no-repeat;
	background-size: 25px 25px;
 	background-position: 5px 4px; 
 	background-color: #ffffff;
 	padding:8px 10px 8px 40px; 
	width:210px;
	height:20px;
}
.CheckInput{
	background: url('<%=request.getContextPath()%>/jsp/image/验证码.png')no-repeat;
	background-size: 25px 25px;
 	background-position: 5px 4px;
	background-color: #ffffff;
 	padding:8px 10px 8px 40px; 
	width:100px;
	height:20px;
	float:left;
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
 					<form name="mainform" id="mainform"  role="form" 
 						class="layui-form" action="" method="" style="display:block"> 
						<div class="layui-form-item">
							<div class="layui-input-inline">
								<input type="text" id="username" class="usernameInput" 
								 placeholder="用户名"  name="username" autocomplete="off" >
							</div>
						</div>
						<div class="layui-form-item">
							<div class="layui-input-inline"> 
								<input class="passwordInput" id="password" name="password"
								 type="password" placeholder="密码">
							</div>
						</div>
						<%--  注册页面的form表单 --%>
						<div id="regDiv" style="display:none">
							<div id="repassword" class="layui-form-item">
								<div class='layui-input-inline'>
									<input id='inputRepassword' type='password' class='inputRepassword' 
									placeholder='确认密码'  name='passwordRepeat'>
								</div>
							</div>
							<div id="emailDiv" class="layui-form-item">
								<div class='layui-input-inline'>
									<input id='email' type='text' class='inputEmail' 
									placeholder='邮箱' name='email'>
								</div>
							</div>
							<div id="phoneDiv" class="layui-form-item">
								<div class='layui-input-inline'>
									<input id='phone' type='text' class='inputPhone' placeholder='手机号' name='phone'>
								</div>
							</div>
						</div>
						<%--  登陆页面的按钮 --%>
						<div id="loginButtomDiv" style="display:block;">
							<a href="javascript:;" id="submit" type="button" style="width:263px"
								class="layui-btn" onclick="login()">登录</a>
							<div id="loginButtomDiv" style="margin-top:20px;"> 
								<a href="javascript:;" onclick="goRegistePage()" 
									style="float:left;margin-left:30px;color:red">注册</a>
								<a href="javascript:;" onclick="forgetPassword()" 
									style="float:left;margin-left:130px;color:red">忘记密码？</a>
							</div>
						</div>
						<%--  注册页面的按钮 --%>
						<div id="regButtomDiv" style="display:none;">
							<a href="javascript:;" id="submit" type="button" style="width:263px"
								class="layui-btn" onclick="registe()">注册</a>
							<div style="margin-top:20px;"> 
								<a href="javascript:;" onclick="goLoginPage()" 
									style="color:red;margin-left:200px;font-size:18px;">去登录</a>
							</div>
						</div>
					</form>
					
					<form name="forgetPasswprdForm" id="form2"  role="form" 
 						class="layui-form" action="" method="" style="display:none"> 
	 						<div class="layui-form-item">
	 							<div class="layui-input-inline">
	 								<h1 style="margin-left:75px;">找回密码</h1>
	 							</div>
	 						</div>
							<div class="layui-form-item" style="margin-top:40px;">
								<div class="layui-input-inline">
									<input type="text" id="findEmail" class="findEmailInput" 
									 placeholder="请输入注册时的邮箱" autocomplete="off" >
								</div>
							</div>
							<div class="layui-form-item">
									<input type="text" id="Check" class="CheckInput" 
									 placeholder="验证码" autocomplete="off">
									 <a id="getCheckCode" class="layui-btn" 
									 placeholder="验证码" autocomplete="off" onclick="getCheckCodeFunction()"
									 style="float:left;margin-left:10px;width:100px;">获取验证码</a>
							</div>
							<div class="layui-form-item">
								<div style="margin-top:20px;"> 
									<a href="javascript:;" class="layui-btn" style="width:263px;" 
										onclick="findPasswordFunction()">找回密码</a>
								</div>
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
		//flags.hidden = true;
		flags.error = null;
		
		layui.use(['form','layer'], function() {
			var form = layui.form;
			var layer = layui.layer;
			
		});
		
		/*
		2.获取control返回的登录错误提示
		*/
		var jsonStr = '<%=request.getAttribute("responseJson")%>';
		if (jsonStr != 'null') {
			var responseJson = JSON.parse(jsonStr);
			flags.error = responseJson.error;
			//使登录错误提示在登录页面显示
			layui.use('layer', function() {
				var layer = layui.layer;
				layer.alert(flags.error,{offset: '30%'}); 
			
			});
		}
		
		
		//3.点击登页面的登陆按钮，进行登陆操作
		function login(){
		    var usernameVal = $("#username").val();
		    var passwordVal = $("#password").val();
		    if(usernameVal == "" ||  usernameVal == null ||
		    		passwordVal == "" ||  passwordVal == null){
		    	//document.getElementById("submit").type="button";
		    	layer.alert("用户信息不完整",{offset: '30%'}); 
		    }else{
		    	var form = document.getElementById("mainform");
		    	form.method = "POST";
				form.action = localhost +"/user/login.do";
			    form.submit();  
		    }
		}
		           
	   //4.去注册页面
		function goRegistePage(){
		//   flags.hidden = false;
		   $("#regDiv").css('display','block');  
		   $("#loginButtomDiv").css('display','none');  
		   $("#regButtomDiv").css('display','block');  
		}
		
		//5.注册操作
		function registe(){
			var usernameVal = $("#username").val();
			var passwordVal = $("#password").val();
			var rePasswordVal = $("#inputRepassword").val();
			var emailVal = $("#email").val();
			var phoneVal = $("#phone").val();
			if (usernameVal == null || usernameVal == "") {
				layer.msg("请输入用户名");
				
			} else if (passwordVal == "" || passwordVal  == null) {
				layer.msg("请输入密码");
				
			} else if (passwordVal != rePasswordVal) {
				layer.msg("两次密码输入不一致");
				
			} else if (!emailReg.test(emailVal)) {
				layer.msg("邮箱格式错误");
				
			} else if (!phoneReg.test(phoneVal )) {
				layer.msg("手机号格式错误");
				
			} else {
				$.ajax({
					type : "post",
					url : localhost + "/user/regist.do",
					data : {
						username : usernameVal,
						password : passwordVal,
						email : emailVal,
						phone : phoneVal 
					},
					async : true,
					datatype : "json",
					success : function(datasource, textStatus, jqXHR) {
						var data = eval('(' + datasource + ')');
						if (data.error == null || data.error == "" || data.error == undefined) {//未出错
							layui.use('layer', function() {
								var layer = layui.layer;
								document.getElementById("username").value = "";
								layer.msg("注册成功！");
							});
							//flags.hidden = true;
							mainform.password.value = "";
							mainform.passwordRepeat.value = "";
							mainform.email.value = "";
							mainform.phone.value = "";
						} else {
							layui.use('layer', function() {
								var layer = layui.layer;
								switch(data.error){
							      case 'Username can not be empty!':
							    	  layer.alert("用户名不能为空",{
							 	    		title:"提示",
							 	    		closeBtn: 0,
								 	        btn : "关闭",
							 			    yes : function(index, layero) {
							 		         	 layer.close(index);
							 		        },
							 	    	}); 
							      	  break;
							      case 'Password can not be empty!':
							    	  layer.alert("密码不能为空",{
							 	    		title:"提示",
							 	    		closeBtn: 0,
								 	        btn : "关闭",
							 			    yes : function(index, layero) {
							 		         	 layer.close(index);
							 		        },
							 	    	}); 
							          break;
							      case 'this username has been registered!':
							    	  layer.alert("该用户名已存在",{
							 	    		title:"提示",
							 	    		closeBtn: 0,
								 	        btn : "关闭",
							 			    yes : function(index, layero) {
							 		         	 layer.close(index);
							 		        },
							 	    	}); 
							          break;
							     case 'Registration failed, please try again!':
							    	  layer.alert("注册失败，请重新操作",{
							 	    		title:"错误",
							 	    		closeBtn: 0,
								 	        btn : "关闭",
							 			    yes : function(index, layero) {
							 		         	 layer.close(index);
							 		        },
							 	    	}); 
							          break;
						     	};
								
							});
						}
					},
					error : function() {
						layui.use('layer', function() {
							var layer = layui.layer;
							layer.alert("注册失败，请重新操作",{
				 	    		title:"错误",
				 	    		closeBtn: 0,
					 	        btn : "关闭",
				 			    yes : function(index, layero) {
				 		         	 layer.close(index);
				 		        },
				 	    	}); 
						});
					}
				});
			}
		}
		
		//5.去登陆页面
		function goLoginPage(){
			$("#regDiv").css('display','none'); 
			$("#regButtomDiv").css('display','none'); 
			$("#loginButtomDiv").css('display','block'); 
			
		}
		
		//6.忘记秘密，进行密码找回
		function forgetPassword(){
			$("#form2").css('display','block');
			$("#mainform").css('display','none');
		}
		
		//7.获取验证码按钮
		function getCheckCodeFunction(){
			var checkEmail = $("#findEmail").val();
			if(checkEmail == "" || checkEmail == null || !emailReg.test(checkEmail)){
				layer.alert("请输入正确的邮箱格式",{offset: '30%'});
			}else{
				$.ajax({
					type : "post",
					url : localhost + "/user/sendVerificationCode.do",
					data : {
						email : checkEmail,
					},
					async : true,
					datatype : "json",
					success : function(datasource, textStatus, jqXHR) {
						var data = eval('(' + datasource + ')');
						if(data.error == null || data.error == "" || data.error == undefined){
							layer.msg("验证码已发送，请注意查收",{offset: '30%'});
							
						}else if(data.error == "您今天的次数已超过4次，请明天再操作"){
							layer.alert("您今天的操作次数已达上限",{
				 	    		title:"错误",
				 	    		closeBtn: 0,
					 	        btn : "关闭",
				 			    yes : function(index, layero) {
				 		         	 layer.close(index);
				 		        },
				 	    	}); 
							
						}else if(data.error == "未查找到用户，该邮箱未注册用户"){
							layer.alert("未查找到用户，该邮箱未注册用户",{
				 	    		title:"错误",
				 	    		closeBtn: 0,
					 	        btn : "关闭",
				 			    yes : function(index, layero) {
				 		         	 layer.close(index);
				 		        },
				 	    	}); 
							
						}else{
							
							
						}
							
					},
					error : function() {
						layui.use('layer', function() {
							var layer = layui.layer;
							layer.alert("获取失败，请重新操作",{
				 	    		title:"错误",
				 	    		closeBtn: 0,
					 	        btn : "关闭",
				 			    yes : function(index, layero) {
				 		         	 layer.close(index);
				 		        },
				 	    	}); 
						});
					}
				});
			}
		}
	
		//8.找回密码按钮
		function findPasswordFunction(){
			layui.use('layer', function() {
				var layer = layui.layer;
			});
			var checkEmail = $("#findEmail").val();
			var checkCode = $("#Check").val();
			if(checkEmail == "" || checkEmail == null || !emailReg.test(checkEmail)){
				layer.alert("请输入正确的邮箱格式",{offset: '30%'});
			}else if(checkCode == "" || checkCode == null){
				layer.alert("请输入验证码",{offset: '30%'});
			}else{ //验证验证码
				$.ajax({
					type : "post",
					url : localhost + "/user/findPassword.do",
					data : {
						email:checkEmail,
						verCode:checkCode 
					},
					async : true,
					datatype : "json",
					success : function(datasource, textStatus, jqXHR) {
						var data = eval('(' + datasource + ')');
						if(data.error == null || data.error == "" || data.error == undefined){
							if(data.user != null){
								var Account = data.user;
								layer.alert("您的登陆账户是：" + Account.username + 
										"; 登录密码是："+ Account.password,{
					 	    		closeBtn: 0,
						 	        btn : "去登录",
					 			    yes : function(index, layero) { 
					 		         	 location.href = localhost + "/jsp/login_zh.jsp"
					 		        },
					 	    	});
						
							}
						}else if(data.error == "验证码错误"){
							layer.alert("您输入的验证码错误");
						}else if(data.error == "未查找到用户，该邮箱未注册用户"){
							layer.alert("未查找到用户，该邮箱未注册用户");
						}
						
					},
					error : function() {
						layui.use('layer', function() {
							var layer = layui.layer;
							layer.alert("获取失败，请重新操作",{
				 	    		title:"错误",
				 	    		closeBtn: 0,
					 	        btn : "关闭",
				 			    yes : function(index, layero) {
				 		         	 layer.close(index);
				 		        },
				 	    	}); 
						});
					}
					
				});
			
			}
		}
	</script>
</html>