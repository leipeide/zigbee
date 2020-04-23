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
	background-size: 24px 24px;
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
								 placeholder="Account name"  name="username" autocomplete="off" >
							</div>
						</div>
						<div class="layui-form-item">
							<div class="layui-input-inline"> 
								<input class="passwordInput" id="password" name="password"
								 type="password" placeholder="Password">
							</div>
						</div>
						<%--  注册页面的form表单 --%>
						<div id="regDiv" style="display:none">
							<div id="repassword" class="layui-form-item">
								<div class='layui-input-inline'>
									<input id='inputRepassword' type='password' class='inputRepassword' 
									placeholder='Confirm password'  name='passwordRepeat'>
								</div>
							</div>
							<div id="emailDiv" class="layui-form-item">
								<div class='layui-input-inline'>
									<input id='email' type='text' class='inputEmail' 
									placeholder='Mailbox' name='email'>
								</div>
							</div>
							<div id="phoneDiv" class="layui-form-item">
								<div class='layui-input-inline'>
									<input id='phone' type='text' class='inputPhone' placeholder='Phone number' name='phone'>
								</div>
							</div>
						</div>
						<%--  登陆页面的按钮 --%>
						<div id="loginButtomDiv" style="display:block;">
							<a href="javascript:;" id="submit" type="button" style="width:263px"
								class="layui-btn" onclick="login()">Sign in</a>
							<div id="loginButtomDiv" style="margin-top:20px;"> 
								<a href="javascript:;" onclick="goRegistePage()" 
									style="float:left;margin-left:20px;color:red">Register</a>
								<a href="javascript:;" onclick="forgetPassword()" 
									style="float:left;margin-left:75px;color:red">Forgot password?</a>
							</div>
						</div>
						<%--  注册页面的按钮 --%>
						<div id="regButtomDiv" style="display:none;">
							<a href="javascript:;" id="submit" type="button" style="width:263px"
								class="layui-btn" onclick="registe()">Register</a>
							<div style="margin-top:20px;"> 
								<a href="javascript:;" onclick="goLoginPage()" 
									style="color:red;margin-left:200px;font-size:18px;">Sign in</a>
							</div>
						</div>
					</form>
					
					<form name="forgetPasswprdForm" id="form2"  role="form" 
 						class="layui-form" action="" method="" style="display:none"> 
	 						<div class="layui-form-item">
	 							<div class="layui-input-inline" >
	 								<h1 style="margin-left:10px;width:300px;">Retrieve password</h1>
	 							</div>
	 						</div>
							<div class="layui-form-item" style="margin-top:40px;">
								<div class="layui-input-inline">
									<input type="text" id="findEmail" class="findEmailInput" 
									 placeholder="please enter the email address" autocomplete="off" >
								</div>
							</div>
							<div class="layui-form-item">
									<input type="text" id="Check" class="CheckInput" 
									 placeholder="verification code" autocomplete="off">
									 <a id="getCheckCode" class="layui-btn" 
									 autocomplete="off" onclick="getCheckCodeFunction()"
									 style="float:left;margin-left:10px;width:100px;">get captcha</a>
							</div>
							<div class="layui-form-item">
								<div style="margin-top:20px;"> 
									<a href="javascript:;" class="layui-btn" style="width:263px;" 
										onclick="findPasswordFunction()">Retrieve password</a>
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
				layer.alert(flags.error,{
					offset: '30%',
					title:"Message",
	 	    		closeBtn: 0,
		 	        btn : "Close",
	 			    yes : function(index, layero) {
	 		         	 layer.close(index);
	 		        },	
				}); 
			
			});
		}
		
		
		//3.点击登页面的登陆按钮，进行登陆操作
		function login(){
		    var usernameVal = $("#username").val();
		    var passwordVal = $("#password").val();
		    if(usernameVal == "" ||  usernameVal == null ||
		    		passwordVal == "" ||  passwordVal == null){
		    	layer.alert(
		    		"Incomplete user information",{
		    		offset: '30%',
		    		title:"Message",
	 	    		closeBtn: 0,
		 	        btn : "Close",
	 			    yes : function(index, layero) {
	 		         	 layer.close(index);
	 		        },	
		    	}); 
		    
		    }else{
		    	var form = document.getElementById("mainform");
		    	form.method = "POST";
				form.action = localhost +"/user/login.do";
			    form.submit();  
		    }
		}
		           
	   //4.去注册页面
		function goRegistePage(){
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
				layer.msg("Please input a account name");
				
			} else if (passwordVal == "" || passwordVal  == null) {
				layer.msg("Please input a password");
				
			} else if (passwordVal != rePasswordVal) {
				layer.msg("The two passwords are inconsistent");
				
			} else if (!emailReg.test(emailVal)) {
				layer.msg("Mailbox format error");
				
			} else if (!phoneReg.test(phoneVal )) {
				layer.msg("Mobile number format error");
				
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
								layer.msg("Successful registration");
							});
							mainform.password.value = "";
							mainform.passwordRepeat.value = "";
							mainform.email.value = "";
							mainform.phone.value = "";
						} else {
							layui.use('layer', function() {
								var layer = layui.layer;
								switch(data.error){
							      case 'Username can not be empty!':
							    	  layer.alert("Username can not be empty!",{
							 	    		title:"Message",
							 	    		closeBtn: 0,
								 	        btn : "Close",
							 			    yes : function(index, layero) {
							 		         	 layer.close(index);
							 		        },
							 	    	}); 
							      	  break;
							      case 'Password can not be empty!':
							    	  layer.alert("Password can not be empty!",{
							 	    		title:"Message",
							 	    		closeBtn: 0,
								 	        btn : "Close",
							 			    yes : function(index, layero) {
							 		         	 layer.close(index);
							 		        },
							 	    	}); 
							          break;
							      case 'this username has been registered!':
							    	  layer.alert("this username has been registered!",{
							 	    		title:"Message",
							 	    		closeBtn: 0,
								 	        btn : "Close",
							 			    yes : function(index, layero) {
							 		         	 layer.close(index);
							 		        },
							 	    	}); 
							          break;
							     case 'Registration failed, please try again!':
							    	  layer.alert("Registration failed, please try again!",{
							 	    		title:"Error",
							 	    		closeBtn: 0,
								 	        btn : "Close",
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
							layer.alert("Registration failed, please try again!",{
				 	    		title:"Error",
				 	    		closeBtn: 0,
					 	        btn : "Close",
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
				layer.alert("Please enter the correct email format",{
					offset: '30%',
					title:"Message",
	 	    		closeBtn: 0,
		 	        btn : "Close",
	 			    yes : function(index, layero) {
	 		         	 layer.close(index);
	 		        },	
				});
				
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
							layer.msg(
									"Verification code has been sent, please check",{
										offset: '30%'}
									);
							
						}else if(data.error == "您今天的次数已超过4次，请明天再操作"){
							layer.alert("You have reached the maximum number of operations today",{
				 	    		title:"Error",
				 	    		closeBtn: 0,
					 	        btn : "Close",
				 			    yes : function(index, layero) {
				 		         	 layer.close(index);
				 		        },
				 	    	}); 
							
						}else if(data.error == "未查找到用户，该邮箱未注册用户"){
							layer.alert("No user found, no user registered in this mailbox",{
				 	    		title:"Error",
				 	    		closeBtn: 0,
					 	        btn : "Close",
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
							layer.alert("Failed to get, please re operate",{
				 	    		title:"Error",
				 	    		closeBtn: 0,
					 	        btn : "Close",
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
				layer.alert("Please enter the correct email format",{
					offset: '30%',
					title:"Message",
	 	    		closeBtn: 0,
		 	        btn : "Close",
	 			    yes : function(index, layero) {
	 		         	 layer.close(index);
	 		        },	
				});
			}else if(checkCode == "" || checkCode == null){
				layer.alert("Please enter the verification code",{
					offset: '30%',
					title:"Message",
	 	    		closeBtn: 0,
		 	        btn : "Close",
	 			    yes : function(index, layero) {
	 		         	 layer.close(index);
	 		        },
				});
				
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
								layer.alert("Your account is：" + Account.username + 
										" and password is："+ Account.password,{
									title:"Message",
									closeBtn: 0,
						 	        btn : "Sign in",
					 			    yes : function(index, layero) { 
					 		         	 location.href = localhost + "/jsp/login_en.jsp"
					 		        },
					 	    	});
						
							}
						}else if(data.error == "验证码错误"){
							layer.alert("The verification code you entered is wrong",{
								title:"Message",
				 	    		closeBtn: 0,
					 	        btn : "Close",
				 			    yes : function(index, layero) {
				 		         	 layer.close(index);
				 		        },
							});
						}else if(data.error == "未查找到用户，该邮箱未注册用户"){
							layer.alert("No user found, no user registered in this mailbox",{
								title:"Message",
				 	    		closeBtn: 0,
					 	        btn : "Close",
				 			    yes : function(index, layero) {
				 		         	 layer.close(index);
				 		        },
							});
						}
						
					},
					error : function() {
						layui.use('layer', function() {
							var layer = layui.layer;
							layer.alert("Failed to get, please reoperate",{
				 	    		title:"Error",
				 	    		closeBtn: 0,
					 	        btn : "close",
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