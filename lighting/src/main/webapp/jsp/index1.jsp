<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="java.util.*,com.test.domain.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/layui/css/layui.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/layui/layui.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/jquery.min.js"></script>
<title>浙江雷培德zigbee灯光智能控制系统</title>
<style type="text/css">
</style>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
			<div class="layui-logo">Waho Lighting System</div>
			<!-- 头部区域（可配合layui已有的水平导航） -->
			<ul class="layui-nav layui-layout-left">
				<li class="layui-nav-item"><a href="javascript:;" onclick="ControllersHide()">Controllers</a></li>
				<li class="layui-nav-item"><a href="javascript:;" onclick="GroupsHide()">Groups</a></li>
				<li class="layui-nav-item"><a href="javascript:;" onclick="PloysHide()">Ploys</a></li>
			</ul>
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item"><a href=""><img
						src="http://t.cn/RCzsdCq" class="layui-nav-img">用户名</a>
					<dl class="layui-nav-child">
						<dd>
							<a href="javascript:;" onclick="UserInfoHide()">UserInfo</a>
						</dd>
					</dl></li>
				<li class="layui-nav-item"><a href="javascript:;" onclick="ExitCount()">Exit</a></li>
			</ul>
		</div>
		
		<%--默认进入首页垂直导航栏展示的是集控器 --%>
		<div class="layui-side layui-bg-black">
			<div class="layui-side-scroll">
				<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
				<ul class="layui-nav layui-nav-tree">
					<li class="layui-nav-item layui-nav-itemed" id="leftNavAll"></li>
					<%--根据侧边导航栏确定主体区内容--%>
					<div id="leftNavOne"></div>
				</ul>
			</div>
		</div>
		
		<%--默认进入首页时主体区展示的是集控器信息 --%>
		<div class="layui-body">
			<!-- 内容主体区域 -->
			<div style="padding: 15px;">
				<div id="controlDiv"  style="display:block;">
					<div>你好，我是controlDiv</div>
				 <div>
						<table id="allDeviceTable" lay-filter="allDeviceTableFilter"></table>
					</div>
				</div> 
				
				<div id="GroupsDiv"  style="display:none;">
					你好，我是GroupsDiv
				</div> 
				
				<div id="PloysDiv"  style="display:none;">
					你好，我是PloysDiv
				</div>
				
				<div id="UserInfo"  style="display:none;">
					你好，我是UserInfo
				</div>
			</div>
		</div>

		<div class="layui-footer">
			<!-- 底部固定区域 -->
			© 雷培德zigbee灯控系统
		</div>
	</div>
	</body>
	<script>
		//alert("欢迎登入");
		//1.获取入口地址
	    var localhost = "<%=request.getContextPath()%>";
	    //2.获取登录成功后control返回的数据
	    var jsonObj = ${responseJson};
	    alert(jsonObj);
	    //3.主体区域
	    var controlDiv = document.getElementById("controlDiv");
	    var GroupsDiv = document.getElementById("GroupsDiv");
	    var PloysDiv = document.getElementById("PloysDiv");
	    var UserInfo = document.getElementById("UserInfo");
	   
	    var leftNavAll =  document.getElementById("leftNavAll");//左边导航栏区域
	    var leftNavOne =  document.getElementById("leftNavOne");//左边导航栏区域
// 	    document.getElementById("img").innerHTML = jsonObj.user.username;

/*********************************控制主体区域*********************************/	    
	    if(controlDiv.style.display == "block"){
	    	//alert("判断controldiv");
	    	leftNavAll.innerHTML = "所有集控器";
	    	showAllDevice();
	    }

	   function ControllersHide(){
		   //alert("判断controldiv");
		   controlDiv.style.display == "block";
		   GroupsDiv.style.display == "none";
		   PloysDiv.style.display == "none";
		   UserInfo.style.display == "none";
		   leftNavAll.innerHTML = "所有集控器";
		   showAllDevice();
	   }
	   
	   
	   function GroupsHide(){
		   //alert("判断Groupdiv");
		   GroupsDiv.style.display == "block";
		   controlDiv.style.display == "none";
		   PloysDiv.style.display == "none";
		   UserInfo.style.display == "none";
		   leftNavAll.innerHTML = "所有组";
		   showAllGroups();
	   }
	   
 	   function PloysHide(){
 		   //alert("判断Ploysdiv");
		   PloysDiv.style.display == "block";
 		   GroupsDiv.style.display == "none";
		   controlDiv.style.display == "none";
		   UserInfo.style.display == "none";
		   leftNavAll.innerHTML = "所有策略";
		   showAllPloys();
	   }
 	   
 	   function UserInfoHide(){
 		  //alert("判断UserInfodiv");
		   UserInfo.style.display == "block";
 		   PloysDiv.style.display == "none";
		   GroupsDiv.style.display == "none";
		   controlDiv.style.display == "none";
		   leftNavAll.innerHTML = "用户信息";
		   showUserMessage();
	   }
	    
/*********************************显示表单函数*********************************/
 		function showAllDevice(){
 			//alert("集控器个数"+jsonObj.devArr.length);
 			inner = "";
 			for(var i = 0; i < jsonObj.devArr.length; i++){
  				inner = inner + "<li class='layui-nav-item layui-nav-itemed' id='dev'>jsonObj.devArr.devName</li>";
 			}
 			leftNavOne.innerHTML = inner;
 			
 			//allDeviceTable();
 			//controlDiv.innerHTML = "alldevform";
		}
		
 		function showAllGroups(){
 			//alert("分组个数"+jsonObj.groupArr.length);
 			inner = " ";
 			for(var i = 0; i < jsonObj.groupArr.length; i++){
 				
 				inner = inner + "<li class='layui-nav-item layui-nav-itemed'>jsonObj.groupArr.groupName</li>";
 			}
 			leftNavOne.innerHTML = inner;
 			controlDiv.innerHTML = "allgroupform";
 		}

 		function showAllPloys(){
 			//alert("策略个数"+jsonObj.ployArr.length);
 			inner = " ";
 			for(var i = 0; i < jsonObj.ployArr.length; i++){
 				inner = inner + "<li class='layui-nav-item layui-nav-itemed'>jsonObj.ployArr.ployName</li>";
 			}
 			leftNavOne.innerHTML = inner;
 			controlDiv.innerHTML = "allployform";
 		}
 		
 		function showUserMessage(){
 			//alert("集控器个数"+jsonObj.user.username);
 			controlDiv.innerHTML = "userform";
 		}

	
/*********************************table*********************************/
  function	allDeviceTable(){	
  	/*	layui.use(['table'], function(){
	    	 	 var table = layui.table;
	    		 table.render({
	    	   		 elem: '#allDeviceTable
	    	   		 ,height: 312
	    	   		 ,url: localhost + '/user/allDeviceTable.do' +"userid="+jsonObj.user.id //数据接口
	    	   		 ,page: true //开启分页
	    	   		 ,cols: [[ //表头
	    	    		  {field: 'id', title: '组名称', width:80, sort: true, fixed: 'left'}
	    	     		 ,{field: 'username', title: '在线节点', width:80}
	    	      		 ,{field: 'sex', title: '离线节点', width:80, sort: true}
	    	      		 ,{field: 'city', title: '整组控制', width:80} 
	    	         ]]
	    	 	 });
	    	});   */
}
	</script>
</html>
