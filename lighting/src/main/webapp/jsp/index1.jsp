<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="java.util.*,com.test.domain.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
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
	src="${pageContext.request.contextPath }/jsp/jquery.min.js"></script>
<title>浙江雷培德zigbee灯光智能控制系统</title>
<style type="text/css">
</style>
</head>
<body class="layui-layout-body" id="mainbody">
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
				<li class="layui-nav-item"><a href="javascript:;"><img
						src="http://t.cn/RCzsdCq" class="layui-nav-img">用户名
						 </a>
					<dl class="layui-nav-child">
 						<dd> 
							<a href="javascript:;" onclick="UserInfoHide()">UserInfo</a>
						</dd>
					</dl>
				</li>
				<li class="layui-nav-item"><a href="javascript:;" onclick="ExitCount()">Exit</a></li>
			</ul>
		</div>
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
					<div id="allDeviceDiv"  style="display:block;">你好，我是allcontrolDiv
						<table id="allDeviceTable" lay-filter="allDeviceTableFilter" lay-data="{skin:'line', even:true, size:'sm'}"></table>
					</div>
					<div id="nodeDiv" style="display:none;">你好，我是nodeDiv
						<table id="nodeTable" lay-filter="nodeTableFilter"></table>
					</div>
				</div> 
				
				<div id="GroupsDiv"  style="display:none;">
					<div id="allGroupsDiv"  style="display:block;">你好，我是GroupsDiv
						<table id="allGroupsTable" lay-filter="allGroupsTableFilter" lay-data="{skin:'line', even:true, size:'sm'}"></table></div>
					<div id="oneGroupsDiv"  style="display:none;">你好，我是oneGroupsDiv
						<table id="oneGroupsTable" lay-filter="oneGroupsTableFilter" lay-data="{skin:'line', even:true, size:'sm'}"></table></div>
				</div> 
				
				<div id="PloysDiv"  style="display:none;">
					<div id="allPloyDiv"  style="display:block;">你好，我是PloysDiv
						<table id="allPloysTable" lay-filter="allPloysTableFilter" lay-data="{skin:'line', even:true, size:'sm'}"></table></div>
					<div id="onePloyDiv"  style="display:none;">你好，我是onePloysDiv
						<table id="onePloysTable" lay-filter="onePloysTableFilter" lay-data="{skin:'line', even:true, size:'sm'}"></table></div>
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
	
	<script type="text/html" id="toolbarControllers">   
		<div class="layui-btn-container">	
			<button class="layui-btn layui-btn-sm"  lay-event="addDev">Add</button>
    		<button class="layui-btn layui-btn-sm"  lay-event="removeDev">Delete</button>
   			<button class="layui-btn layui-btn-sm"  lay-event="renameDev">Rename</button>
   			<button class="layui-btn layui-btn-sm"  lay-event="DetailMessage">DetailMessage</button>
  		</div>
    </script>
 	
 	<script type="text/html" id="toolbarGroups">   
		<div class="layui-btn-container">	
			<button class="layui-btn layui-btn-sm"  lay-event="addGroup">Add Group</button>
    		<button class="layui-btn layui-btn-sm"  lay-event="removeGroup">Delete Group</button>
   			<button class="layui-btn layui-btn-sm"  lay-event="renameGroup">Rename Group</button>
   			<button class="layui-btn layui-btn-sm"  lay-event="proupMessage">GroupMessage</button>
  		</div>
   </script>

 	<script type="text/html" id="toolbarPloys">   
		<div class="layui-btn-container">	
			<button class="layui-btn layui-btn-sm"  lay-event="addPloy">Add Ploy</button>
    		<button class="layui-btn layui-btn-sm"  lay-event="removePloy">Delete Ploy</button>
   			<button class="layui-btn layui-btn-sm"  lay-event="renamePloy">Rename Ploy</button>
   			<button class="layui-btn layui-btn-sm"  lay-event="ployMessage">PloyMessage</button>
  		</div>
   </script>
   
	<script  type="text/html" id="barDevice">
  		<a class="layui-btn layui-btn-xs" lay-event="open">ON</a>
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="close">OFF</a>
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="dim">DIM</a>
  </script>

  <script type="text/javascript">
  		alert("2018");
		//1.获取入口地址
	    var localhost = "<%=request.getContextPath()%>";
	    //2.获取登录成功后control返回的数据
	    //alert("2019");
	    var jsonObj = ${responseJson};
	    var Devices = jsonObj.devArr;
	    var Groups = jsonObj.groupArr;
	    var Ploy = jsonObj.ployArr;
	    var User = jsonObj.user;
	   
	   // document.getElementById("username").innerHTML = jsonObj.user.username;
	    //3.主体区域
	    var controlDiv = document.getElementById("controlDiv");
	    var GroupsDiv = document.getElementById("GroupsDiv");
	    var PloysDiv = document.getElementById("PloysDiv");
	    var UserInfo = document.getElementById("UserInfo");
	    //4.侧边导航栏区域
	    var leftNavAll =  document.getElementById("leftNavAll");//左边导航栏区域
	    var leftNavOne =  document.getElementById("leftNavOne");//左边导航栏区域


		//5.加入layui表格监听
			layui.use(['table','layer'], function(){
				var table = layui.table;
				var layer = layui.layer;
				/*监听所有Group表格*/
				table.on('toolbar(allDeviceTableFilter)', function(obj){
				   	var checkStatus = table.checkStatus(obj.config.id); //获取选中行状态
			   	    var data = checkStatus.data;  //获取选中行数据
				    switch(obj.event){
				      case 'addDev':
				    	  addDev();
				        //layer.alert('addDev');
				      break;
				      case 'removeDev':
				    	  removeDev(); 
				    	 /* if(data != ""){
					    	  removeDev(); 
				    	  }else{
				    		  layer.msg("未选择操作对象！");
				    	  }*/
				      break;
				      case 'renameDev':
				    	  renameDev();
				    	 /* if(data != ""){
				    		  renameDev();
				    	  }else{
				    		  layer.msg("未选择操作对象！");
				    	  }*/
				      break;
				      case 'DetailMessage':
				    	  detailMessage();
				    	/*  if(data != ""){
				    		  detailMessage();
				    	  }else{
				    		  layer.msg("未选择操作对象！");
				    	  }*/
					      break;
				    };
				  });
				
				  
				/*监听所有Group表格*/
				table.on('toolbar(allGroupsTableFilter)', function(obj){
				   	var checkStatus = table.checkStatus(obj.config.id); //获取选中行状态
			   	    var data = checkStatus.data;  //获取选中行数据
				    switch(obj.event){
				      case 'addGroup':
				    	  addGroup();
				      break;
				      case 'removeGroup':
				    	  removeGroup(); 
				    	 /* if(data != ""){
					    	  removeGroup(); 
				    	  }else{
				    		  layer.msg("未选择操作对象！");
				    	  }*/
				      break;
				      case 'renameGroup':
				    	  renameGroup();
				    	 /* if(data != ""){
				    		  renameGroup();
				    	  }else{
				    		  layer.msg("未选择操作对象！");
				    	  }*/
				      break;
				      case 'groupMessage':
				    	  groupMessage();
				    	/*  if(data != ""){
				    		   groupMessage();
				    	  }else{
				    		  layer.msg("未选择操作对象！");
				    	  }*/
					      break;
				    };
				  });
				
				
				/*监听所有ploy表格*/
				table.on('toolbar(allPloysTableFilter)', function(obj){
				   	var checkStatus = table.checkStatus(obj.config.id); //获取选中行状态
			   	    var data = checkStatus.data;  //获取选中行数据
				    switch(obj.event){
				      case 'addPloy':
				    	  addPloy();
				      break;
				      case 'removePloy':
				    	  removePloy(); 
				    	 /* if(data != ""){
					    	  removePloy(); 
				    	  }else{
				    		  layer.msg("未选择操作对象！");
				    	  }*/
				      break;
				      case 'renamePloy':
				    	  renamePloy();
				    	 /* if(data != ""){
				    		 renamePloy();
				    	  }else{
				    		  layer.msg("未选择操作对象！");
				    	  }*/
				      break;
				      case 'ployMessage':
				    	  ployMessage();
				    	/*  if(data != ""){
				    		   ployMessage();
				    	  }else{
				    		  layer.msg("未选择操作对象！");
				    	  }*/
					      break;
				    };
				  });
				
			}); 
	    
	    
	    
/*********************************控制主体区域*********************************/	    
	    if(controlDiv.style.display == "block" && GroupsDiv.style.display == "none" &&  PloysDiv.style.display == "none" &&  UserInfo.style.display == "none"){
	    	//alert("判断allDevicediv");
 			showAllDevice();
	    }

	   function ControllersHide(){
		  // alert("判断allDevicediv");
		   controlDiv.style.display = "block";
		   GroupsDiv.style.display = "none";
		   PloysDiv.style.display = "none";
		   UserInfo.style.display = "none";
		   showAllDevice();
	   } 
	   function GroupsHide(){
		   //alert("判断Groupdiv");
		   GroupsDiv.style.display = "block";
		   controlDiv.style.display = "none";
		   PloysDiv.style.display = "none";
		   UserInfo.style.display = "none";
		   showAllGroups();
	   }
 	   function PloysHide(){
 		   //alert("判断Ploysdiv");
		   PloysDiv.style.display = "block";
 		   GroupsDiv.style.display = "none";
		   controlDiv.style.display = "none";
		   UserInfo.style.display = "none";
		   showAllPloys();
	   }  
 	   function UserInfoHide(){
 		   alert("判断UserInfodiv");
		   UserInfo.style.display = "block";
 		   PloysDiv.style.display = "none";
		   GroupsDiv.style.display = "none";
		   controlDiv.style.display = "none";
		   showUserMessage();
	   }
 	   
 	   /*退出登录*/
 	  function ExitCount(){
 			location.href = localhost+"/index.jsp";
 	  }
 	   
 	   
/*********************************显示表单函数*********************************/
 		function showAllDevice(){
 			//alert("集控器个数"+jsonObj.devArr.length);
 			leftNavAll.innerHTML = "<a href='javascript:;' onclick='allDeviceTable()'>AllContorllers</a>";
 			inner = " ";
 			for(var i = 0; i < Devices.length; i++){
  				inner = inner + "<li class='layui-nav-item layui-nav-itemed'><a href='javascript:;' onclick='nodeMessage()' name='dev'></a></li>";
 			}
 			leftNavOne.innerHTML = inner;
 			var aDevice = " ";
 			aDevice = document.getElementsByName("dev");
 			for(var i = 0; i < aDevice.length; i++){
 				aDevice[i].innerHTML = Devices[i].devName;
 			}
 			
 	        allDeviceTable();
		}
		
 		function showAllGroups(){
 			 //alert("分组个数"+jsonObj.groupArr.length);
 			leftNavAll.innerHTML = "<a href='javascript:;'onclick='allGroupsTable()'>AllGroups</a>";
 			inner = " ";
 			for(var i = 0; i < Groups.length; i++){
 				inner = inner + "<li class='layui-nav-item layui-nav-itemed'><a href='javascript:;' onclick='groupMessage()' name='group'></a></li>";
 			}
 			leftNavOne.innerHTML = inner;
 			var aGroup = " ";
 			aGroup = document.getElementsByName("group");
 			for(var i = 0; i < aGroup.length; i++){
 				aGroup[i].innerHTML = Groups[i].groupName;
 			}
 			allGroupsTable();
 		}

 		function showAllPloys(){
 			//alert("策略个数"+jsonObj.ployArr.length);
 			leftNavAll.innerHTML = "<a href='javascript:;'onclick='allPloysTable()'>AllPloys</a>";
 			inner = " ";
 			for(var i = 0; i < Ploy.length; i++){
 				inner = inner + "<li class='layui-nav-item layui-nav-itemed'><a href='javascript:;' onclick='ployMessage()' name='ploy'></a></li>";
 			}
 			leftNavOne.innerHTML = inner;
 			var aPloy = " ";
 			aPloy = document.getElementsByName("ploy");
 			for(var i = 0; i < aPloy.length; i++){
 				aPloy[i].innerHTML = Ploy[i].ployName;
 			}
 			allPloysTable();
 		}
 		
 		function showUserMessage(){
 			//alert("集控器个数"+jsonObj.user.username);
 			controlDiv.innerHTML = "userform";
 		}

	
/*********************************table*********************************/
  /*1.所有集控器表格*/
  function	allDeviceTable(){
	    //alert("function allDeviceTable");
	    document.getElementById("nodeDiv").style.display = "none"; //将单个表格数据隐藏
	    document.getElementById("allDeviceDiv").style.display = "block";
  		layui.use(['table','layer'], function(){
	    	 	 var table = layui.table;
	    	 	 var layer = layui.layer;
	    	 	 var userid = User.id;
	    	 	 var curr = 1;
	    	 	 var num = 15;
	    		 table.render({
	    	   		 elem:'#allDeviceTable'
	    	   		 ,align:'center'
	    	   		// ,height: 312
	    	   		 ,url: localhost + '/model/devices.do' + "?userid=" + userid +"&page="+curr+"&limit="+num//数据接口
	    	   		 ,request: {
	    	   		     pageName:'page'//页码的参数名称，默认：page
	    	   		    ,limitName: 'limit'//每页数据量的参数名，默认：limit
	    	   		  }
	    	   		 ,toolbar:'#toolbarControllers' 
	    	   		 ,page: true //开启分页
	    	   		 ,cols: [[ //表头
	    	   			  {type:'radio'}
	    	    		 ,{field: 'devName', title: 'name', width:120}
	    	     		 ,{field: 'devNet', title: 'status', width:120}
	    	      		 ,{field: 'onlineNodes', title: 'nodes online', width:120}
	    	      		 ,{field: 'offlineNodes', title: 'nodes offline', width:120} 
	    	      		 ,{field: 'zigbeeFinder', title: 'nodes finder', toolbar: '#barZigbeeFinder', width:120} 
	    	      		 ,{field: 'Broadcast', title: 'broadcast', toolbar: '#barBroadcast', width:180} 
	    	      		 ,{field: 'allDeviceTable', title: 'allDeviceTable', width:150} 
	    	         ]]
	    	 	 });
  		 	});
	   		render;
}
  /*2.所有组表格*/
  function	allGroupsTable(){
		//alert("functionallGroupsTable");
	    document.getElementById("oneGroupsDiv").style.display = "none"; //将单个表格数据隐藏
	  		layui.use(['table'], function(){
		    	 	 var table = layui.table;
		    		 table.render({
		    			// skin: 'line' //行边框风格
		    	   		 elem:'#allGroupsTable'
		    	   		 ,height: 312
		    	   		 ,url:localhost+'/user/allDeviceTable.do'
		    	   		 ,toolbar:'#toolbarGroups'  
		    	   		 ,page: true //开启分页
		    	   		 ,cols: [[ //表头
		    	   			  {type:'radio'}
		    	    		 ,{field: 'Group Name', title: 'group name', width:120, fixed: 'left'}
		    	     		 ,{field: 'Nodes Online', title: 'nodes online', width:120}
		    	      		 ,{field: 'Nodes Offline', title: 'nodes offline', width:120}
		    	      		 ,{field: 'Group Control', title: 'group control', width:120} 
		    	      		 ,{field: 'GroupsDiv', title: 'GroupsDiv', width:120} 
		    	         ]]
		    	 	 });
		    	});  
	  		render;
	}
  
  /*3.所有策略表格*/
  function	allPloysTable(){
		//alert("functionallPloysTableTable");
		document.getElementById("onePloyDiv").style.display = "none"; //将单个ploy表格数据隐藏
		//document.getElementById("allPloysTable") = " ";//将所有策略表格内容清空，用于重新获取数据；
		//document.getElementById("onePloysTable") = " ";
	  		layui.use(['table'], function(){
		    	 	 var table = layui.table;
		    		 table.render({
		    			// skin: 'line' //行边框风格
		    	   		 elem:'#allPloysTable'
		    	   		 ,height: 312
		    	   		 ,url:localhost+'/user/allDeviceTable.do'
		    	   		 ,toolbar:'#toolbarPloys' 
		    	   		 ,page: true //开启分页
		    	   		 ,cols: [[ //表头
		    	   			  {type:'radio'}
		    	    		 ,{field: 'Ploy Name', title: 'ploy name', width:120, sort: true, fixed: 'left'}
		    	     		 ,{field: 'NextTimePoint', title: 'nextTimePoint', width:120}
		    	      		 ,{field: 'NextCmd Status', title: 'nextCmd status', width:120, sort: true}
		    	      		 ,{field: 'Ploy Control', title: 'ploy control', width:120, sort: true}
		    	      		 ,{field: 'PloysDiv', title: 'PloysDiv', width:120, sort: true}
		    	         ]]
		    	 	 });
		    	});  
	  		render;
	}
	
  /*4.显示单个集控器下节点表格信息*/
  function nodeMessage(){
	    //alert("nodeMessageTable");
	    //GroupsDiv.style.display = "none";
	    //PloysDiv.style.display = "none";
	    //controlDiv.style.display = "block";
    	document.getElementById("allDeviceDiv").style.display = "none";
    	document.getElementById("nodeDiv").style.display = "block";
    	//document.getElementById("nodeTable") = " ";
		//alert("000");
		layui.use(['table'], function(){
	    	 	 var table = layui.table;
	    		 table.render({
	    	   		// elem:'#deviceMessageTable'
	    	   		// skin: 'line' //行边框风格
	    	   		 elem:'#nodeTable'
	    	   		 ,height: 312
	    	   		 ,url:localhost+'/user/allDeviceTable.do'
	    	   		 ,page: true //开启分页
	    	   		 ,cols: [[ //表头
	    	   			  {type:'radio'}
	    	    		 ,{field: 'Node Name', title: 'node name', width:120, sort: true, fixed: 'left'}
	    	     		 ,{field: 'Network', title: 'network', width:120}
	    	      		 ,{field: 'Brightness', title: 'brightness', width:120, sort: true}
	    	      		 ,{field: 'Status', title: 'status', width:120, sort: true}
	    	      		 ,{field: 'Temperature', title: 'temperature', width:120, sort: true}
	    	      		 ,{field: 'Humidity', title: 'humidity', width:120, sort: true}
	    	      		 ,{field: 'Control', title: 'control', width:120, sort: true}
	    	      		 ,{field: 'device', title: '节点表格', width:120, sort: true}
	    	         ]]
	    	 	 });
	    	});  
		render;
  }
  
  /*5.显示组内表格信息*/
  function groupMessage(){
		//alert("onegroupMessageTable");
	    document.getElementById("allGroupsDiv").style.display = "none";
    	document.getElementById("oneGroupsDiv").style.display = "block";
    	//document.getElementById("oneGroupsTable") = " ";
		layui.use(['table'], function(){
	    	 	 var table = layui.table;
	    		 table.render({
	    			 //skin: 'line' //行边框风格
	    	   		 elem:'#oneGroupsTable'
	    	   		 ,height: 312
	    	   		 ,url:localhost+'/user/allDeviceTable.do'
	    	   		 ,page: true //开启分页
	    	   		 ,cols: [[ //表头
	    	   			 {field: 'Node Name', title: 'node name', width:120, sort: true, fixed: 'left'}
	    	     		 ,{field: 'Network', title: 'network', width:120}
	    	      		 ,{field: 'Brightness', title: 'brightness', width:120, sort: true}
	    	      		 ,{field: 'Status', title: 'status', width:120, sort: true}
	    	      		 ,{field: 'Temperature', title: 'temperature', width:120, sort: true}
	    	      		 ,{field: 'Humidity', title: 'humidity', width:120, sort: true}
	    	      		 ,{field: 'Control', title: 'control', width:120, sort: true}
	    	      		 ,{field: 'group', title: '单个组内表格', width:120, sort: true}
	    	         ]]
	    	 	 });
	    	});  
		render;
  }
    
  /*6.显示单个策略表格信息*/
  function ployMessage(){
	  	//alert("ployMessageTale");
	    document.getElementById("allPloyDiv").style.display = "none";
    	document.getElementById("onePloyDiv").style.display = "block";
		alert("oneployMessageTable");
		layui.use(['table'], function(){
	    	 	 var table = layui.table;
	    		 table.render({
	    	   		 elem:'#onePloysTable'
	    	   		 ,height: 312
	    	   		 ,url:localhost+'/user/allDeviceTable.do'
	    	   		 ,page: true //开启分页
	    	   		 ,cols: [[ //表头
	    	   			  {field: 'Time Point', title: 'time point', width:120, sort: true, fixed: 'left'}
	    	     		 ,{field: 'Cmd Type', title: 'cmd type', width:120}
	    	      		 ,{field: 'Cmd param', title: 'cmd param', width:120, sort: true}
	    	      		 ,{field: 'ploy', title: '单个策略表格', width:120, sort: true}
	    	         ]]
	    	 	 });
	    	});  
		render;
  }
  
  
  /*6.添加集控器*/
  function addDev(){
	  layui.use('layer', function(){
 	 	 var layer = layui.layer;
 	 	 inner = "<input type='text' id='addDevInput' required  lay-verify='required' placeholder='请输入标题' autocomplete='off' class='layui-input'>";
	  	 layer.open({
			 area : [ '600px', '150px' ],
			//offset:['100px','450px'],
			 btnAlign : 'l',
			 resize : false,
			 closeBtn : 1,
			 type : 1,
			 title:"Please enter the mac address of the controller: ",
			 content : inner,
		     btn : '提交',
		     yes : function(index, layero) {
					//location.href = localhost + "/user/addDev.do";
					//可以通过ajax去"/user/addDev.do";进行添加集控器操作
					var devMac = document.getElementById("addDevInput").value;
					userid = User.id;
					$.ajax({
			            type:"post",
			            url:localhost + "/user/addDev.do",
			            data:{
			              devMac:devMac,
			              userid:userid
			            },
			            async : true,
			            datatype: "json",
			            success:function(datasource, textStatus, jqXHR) {
			            	//alert("success");
			              var data = eval('(' + datasource + ')');
			              if (data.error == null || data.error == "" || data.error == undefined) {//未出错
			            	  layer.msg('Submission completed","Added successfully!', function(){
			            		  //do something
			            		  document.getElementById("addDevInput").value = " ";
			            		}); 
			                //userDataRefresh(user, data);用户数据刷新有待考虑
			              } else {
			            	  layer.msg(data.error, function(){
			            		  //do something
			            		  document.getElementById("addDevInput").value = " ";
			            		}); 
			                //alertVue.show("error",data.error);
			              }
			            },
			            error: function() {
			            	 layer.msg("Connection failure!", function(){
			            		  //do something
			            		 document.getElementById("addDevInput").value = " ";
			            		}); 
			              //alertVue.show("error","Connection failure!");
			            }
			          });
					
				 },
			 cancel : function() {
				// 右上角关闭回调
				 location.reload();
				// return false 开启该代码可禁止点击该按钮关闭
			 }
		 });
	  });
  }
 
  
  /*7.删除集控器*/
  function removeDev(){
	  var devName = User.name;//
	  var devMac = "123"
	  var userid = User.id;
	  layer.confirm('is not?',
			  {icon: 3, 
		      title:'Are you sure you want to delete \"" + dev.name + "\"？',
		      content:'Note: After deleting the controller, all zigbee node data linked under the controller will be deleted.',
		      },  function(index){
		  //do something
		  $.ajax({
			            type:"post",
			            url:localhost + "/user/removeDev.do",
			            data:{
			              devMac:devMac,
			              userid:userid
			            },
			            async : true,
			            datatype: "json",
			            success:function(datasource, textStatus, jqXHR) {
			              var data = eval('(' + datasource + ')');
			              if (data.error == null || data.error == "" || data.error == undefined) {//未出错
			            	  layer.alert('successfully deleted!', function(){
			            		  //do something
			            		}); 
			                //userDataRefresh(user, data);用户数据刷新有待考虑
			              } else {
			            	  layer.alert(data.error, function(){
			            		  
			            		}); 
			              }
			            },
			            error: function() {
			            	 layer.alert("Connection failure!", function(){
			            		
			            		}); 
			            }
			    });
		 
		});       
  }
  
  
  /*8.集控器重命名*/
  function renameDev(){
	  layui.use('layer', function(){
	 	 	 var layer = layui.layer;
	 	 	 inner = "<input type='text' id='renameDevInput' required  lay-verify='required' placeholder='请输入新名称'  autocomplete='off' class='layui-input'>";
		  	 layer.open({
				 area : [ '600px', '150px' ],
				//offset:['100px','450px'],
				 btnAlign : 'l',
				 resize : false,
				 closeBtn : 1,
				 type : 1,
				 title:"Please enter a new controller name:",
				 content : inner,
			     btn : '提交',
			     yes : function(index, layero) {
						//可以通过ajax去"/user/renameDev.do";进行添加集控器操作
						var newName = document.getElementById("renameDevInput").value;
						var devMac =  "123";
						if(newName != null && newName != "" && newName.length <=16){
							
							$.ajax({
					            type:"post",
					            url:localhost + "/user/renameDev.do",
					            data:{
					              devMac:devMac,
					              devNewName:newName
					            },
					            async : true,
					            datatype: "json",
					            success:function(datasource, textStatus, jqXHR) {
					            	//alert("success");
					              var data = eval('(' + datasource + ')');
					              if (data.error == null || data.error == "" || data.error == undefined) {//未出错
					            	  layer.msg('Successfully modified!', function(){
					            		  //do something
					            		  document.getElementById("renameDevInput").value = " ";
					            		}); 
					                //userDataRefresh(user, data);用户数据刷新有待考虑
					              } else {
					            	  layer.msg(data.error, function(){
					            		  //do something
					            		  document.getElementById("renameDevInput").value = " ";
					            		}); 
					              }
					            },
					            error: function() {
					            	 layer.msg("Connection failure!", function(){
					            		  //do something
					            		 document.getElementById("renameDevInput").value = " ";
					            		}); 
					            }
					          });
						}else if (newName == "") {//点击取消返回的是null
							  layer.msg("New name cannot be empty.");
				        } else if (newName.length > 16) {
				        	  layer.msg("The length of the name cannot exceed 16 words.");
				        }
						
					 },
				 cancel : function() {
					// 右上角关闭回调
					 location.reload();
					// return false 开启该代码可禁止点击该按钮关闭
				 }
			 });
		  });
	  
  }
  
  
  /*9.查看集控器详细信息*/
  function detailMessage(){
	  layui.use('layer', function(){
	 	 	 var layer = layui.layer;
	 	 	 inner = "<span id=''></span></br>";
		  	 layer.open({
				 area : [ '600px', '150px' ],
				//offset:['100px','450px'],
				 btnAlign : 'l',
				 resize : false,
				 closeBtn : 1,
				 type : 1,
				 title:"Detail Message",
				 content : inner,
			     btn : 'close',
			     yes : function(index, layero) {
			    	   layer.close(index);
					 },
				 cancel : function() {
					// 右上角关闭回调
					 location.reload();
					// return false 开启该代码可禁止点击该按钮关闭
				 }
			 });
		  });
  }
  
  /*10.添加控制组*/
  function addGroup(){
	  layui.use('layer', function(){
	 	 	 var layer = layui.layer;
	 	 	 inner = "<input type='text' id='addGroupInput' required  lay-verify='required' placeholder='请输入标题' autocomplete='off' class='layui-input'>";
		  	 layer.open({
				 area : [ '600px', '150px' ],
				//offset:['100px','450px'],
				 btnAlign : 'l',
				 resize : false,
				 closeBtn : 1,
				 type : 1,
				 title:"Please enter the mac address of the controller: ",
				 content : inner,
			     btn : '提交',
			     yes : function(index, layero) {
						//location.href = localhost + "/user/addDev.do";
						//可以通过ajax去"/user/addDev.do";进行添加集控器操作
						var newGroupName = document.getElementById("addGroupInput").value;
						userid = User.id;
						if (newGroupName != null && newGroupName != "" && newGroupName.length <= 16) {
							$.ajax({
					            type:"post",
					            url:localhost + "/user/addGroup.do",
					            data:{
					              groupName:newGroupName,
					              userid:userid
					            },
					            async : true,
					            datatype: "json",
					            success:function(datasource, textStatus, jqXHR) {
					            	//alert("success");
					              var data = eval('(' + datasource + ')');
					              if (data.error == null || data.error == "" || data.error == undefined) {//未出错
					            	  layer.msg('Added successfully!', function(){
					            		  //do something
					            		  document.getElementById("addGroupInput").value = " ";
					            		}); 
					                //userDataRefresh(user, data);用户数据刷新有待考虑
					              } else {
					            	  layer.msg(data.error, function(){
					            		  //do something
					            		  document.getElementById("addGroupInput").value = " ";
					            		}); 
					                //alertVue.show("error",data.error);
					              }
					            },
					            error: function() {
					            	 layer.msg("Connection failure!", function(){
					            		  //do something
					            		 document.getElementById("addGroupInput").value = " ";
					            		}); 
					              //alertVue.show("error","Connection failure!");
					            }
					          });
							
						}else if (newGroupName == "") {//点击取消返回的是null
								 layer.msg("New name cannot be empty.");
						} else if (newGroupName.length > 16) {
							      document.getElementById("addGroupInput").value = " ";
						          layer.msg("The length of the name cannot exceed 16 words.");
					    }
					 },
				 cancel : function() {
					// 右上角关闭回调
					 location.reload();
					// return false 开启该代码可禁止点击该按钮关闭
				 }
			 });
		  });
  }
 

/*11.删除控制组*/
function removeGroup(){
	  var userid =  User.id;
	  var groupaddr = "123456"
	  layer.confirm('is not?'
			  ,{icon: 3 
		      ,title:'Warnning'
		      ,content:'Are you sure you want to delete \"" + group.name + "\"？'
		      }  
		      ,function(index){
				  //do something
				  $.ajax({
					         type:"post",
					         url:localhost + "/user/removeGroup.do",
					         data:{
					          	groupid:groupaddr,
					            userid:userid
				             },
				            async : true,
				            datatype: "json",
				            success:function(datasource, textStatus, jqXHR) {
   				                  var data = eval('(' + datasource + ')');
					              if (data.error == null || data.error == "" || data.error == undefined) {//未出错
					            	  layer.alert('successfully deleted!', function(){
					            		  //do something
					            		}); 
					                //userDataRefresh(user, data);用户数据刷新有待考虑
					              } else {
					            	  layer.alert(data.error, function(){
					            		  
					            		}); 
					              }
					          },
					          error: function() {
					            	layer.alert("Connection failure!", function(){
					            		
					            	}); 
					          }
					    });
		 
		});       
}


/*12控制组重命名*/
function renameGroup(){
	 var groupaddr = "123456"
	layui.use('layer', function(){
	 	 var layer = layui.layer;
	 	 inner = "<input type='text' id='renameGroupInput' required  lay-verify='required' placeholder='请输入新名称'  autocomplete='off' class='layui-input'>";
	  	 layer.open({
			 area : [ '600px', '150px' ],
			//offset:['100px','450px'],
			 btnAlign : 'l',
			 resize : false,
			 closeBtn : 1,
			 type : 1,
			 title:"Please enter a new group name:",
			 content : inner,
		     btn : '提交',
		     yes : function(index, layero) {
					//可以通过ajax去"/user/renameDev.do";进行添加集控器操作
					var newName = document.getElementById("renameGroupInput").value;
					var devMac =  "123";
					if(newName != null && newName != "" && newName.length <=16){
						
						$.ajax({
				            type:"post",
				            url:localhost + "/user/renameGroup.do",
				            data:{
				            	groupid:groupaddr,
				                groupNewName:newName
				            },
				            async : true,
				            datatype: "json",
				            success:function(datasource, textStatus, jqXHR) {
				            	//alert("success");
				              var data = eval('(' + datasource + ')');
				              if (data.error == null || data.error == "" || data.error == undefined) {//未出错
				            	  layer.msg('Successfully modified!', function(){
				            		  //do something
				            		  document.getElementById("renameGroupInput").value = " ";
				            		}); 
				                //userDataRefresh(user, data);用户数据刷新有待考虑
				              } else {
				            	  layer.msg(data.error, function(){
				            		  //do something
				            		  document.getElementById("renameGroupInput").value = " ";
				            		}); 
				              }
				            },
				            error: function() {
				            	 layer.msg("Connection failure!", function(){
				            		  //do something
				            		 document.getElementById("renameGroupInput").value = " ";
				            		}); 
				            }
				          });
					}else if (newName == "") {//点击取消返回的是null
						  layer.msg("New name cannot be empty.");
			        } else if (newName.length > 16) {
			        	  document.getElementById("renameGroupInput").value = " ";
			        	  layer.msg("The length of the name cannot exceed 16 words.");
			        }
					
				 },
			 cancel : function() {
				// 右上角关闭回调
				 location.reload();
				// return false 开启该代码可禁止点击该按钮关闭
			 }
		 });
	  });
}

function groupMessage(){
		
}


/*13.添加策略*/
function addPloy(){
	 layui.use('layer', function(){
 	 	 var layer = layui.layer;
 	 	 inner = "Ploy Name<input type='text' id='addPloyInput' required  lay-verify='required' placeholder='请输入标题' autocomplete='off' class='layui-input'><br/>Bind group<> ";
	  	 layer.open({
			 area : [ '600px', '150px' ],
			//offset:['100px','450px'],
			 btnAlign : 'l',
			 resize : false,
			 closeBtn : 1,
			 type : 1,
			 title:"Please enter the mac address of the controller: ",
			 content : inner,
		     btn : '提交',
		     yes : function(index, layero) {
					//location.href = localhost + "/user/addDev.do";
					//可以通过ajax去"/user/addDev.do";进行添加集控器操作
					var ployName = document.getElementById("addPloyInput").value;
					userid = User.id;
					 if (ployName != null && ployName != "" && ployName.length <= 16) {
						$.ajax({
				            type:"post",
				            url:localhost + "/user/addPloy.do",
				            data:{
				            	userid: User.id,
				                bindType: 1,
				                bindData: groupid,
				                ployName: ployName,
				                timeZone: new Date().getTimezoneOffset(),
				            },
				            async : true,
				            datatype: "json",
				            success:function(datasource, textStatus, jqXHR) {
				            	//alert("success");
				              var data = eval('(' + datasource + ')');
				              if (data.error == null || data.error == "" || data.error == undefined) {//未出错
				            	  layer.msg('Added successfully!', function(){
				            		  //do something
				            		  document.getElementById("addPloyInput").value = " ";
				            		}); 
				                //ployDataRefresh(user, data);//刷新策略数据
				              } else {
				            	  layer.msg(data.error, function(){
				            		  //do something
				            		  document.getElementById("addPloyInput").value = " ";
				            		}); 
				                //alertVue.show("error",data.error);
				              }
				            },
				            error: function() {
				            	 layer.msg("Connection failure!", function(){
				            		  //do something
				            		 document.getElementById("addPloyInput").value = " ";
				            		}); 
				              //alertVue.show("error","Connection failure!");
				            }
				          });
						
					 } else if (ployName == "") {//点击取消返回的是null
						  layer.msg("New name cannot be empty.");
				     } else if (ployName.length > 16) {
				          layer.msg("The length of the name cannot exceed 16 words");
				      }
				 },
			 cancel : function() {
				// 右上角关闭回调
				 location.reload();
				// return false 开启该代码可禁止点击该按钮关闭
			 }
		 });
	  });
}

/**
 * 14.删除策略
 */
 function removePloy(){
	 var userid =  User.id;
	  var ployid = "123456"
	  layer.confirm('is not?'
			  ,{icon: 3 
		      ,title:'Warnning'
		      ,content:'Are you sure you want to delete \"" + PLOY.name + "\"？'
		      }  
		      ,function(index){
				  //do something
				  $.ajax({
					         type:"post",
					         url:localhost + "/user/removePloy.do",
					         data:{
					        	 id:ployid,
				             },
				            async : true,
				            datatype: "json",
				            success:function(datasource, textStatus, jqXHR) {
  				                  var data = eval('(' + datasource + ')');
					              if (data.error == null || data.error == "" || data.error == undefined) {//未出错
					            	  layer.alert('successfully deleted!', function(){
					            		  //do something
					            		}); 
					                // ployDataRefresh(user, data);//刷新策略数据
					              } else {
					            	  layer.alert(data.error, function(){
					            		  
					            		}); 
					              }
					          },
					          error: function() {
					            	layer.alert("Connection failure!", function(){
					            		
					            	}); 
					          }
					    });
		 
		});       
}

/**
 * 15.策略重命名
 */
 function renamePloy(){
	
}

/**
 * 16策略详细信息
 */
 function ployMessage(){
	
}
	</script>
	</body>
</html>
