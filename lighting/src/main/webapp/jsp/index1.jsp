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
<%--设置table中checkbox的样式--%>
.layui-table-cell .layui-form-checkbox[lay-skin="primary"]{
     top: 50%;
     transform: translateY(-50%);
}

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
						<table id="allDeviceTable" lay-filter="allDeviceTableFilter"></table>
					</div>
					<div id="nodeDiv" style="display:none;">你好，我是nodeDiv
						<table id="nodeTable" lay-filter="nodeTableFilter"></table>
					</div>
				</div> 
				
				<div id="GroupsDiv"  style="display:none;">
					<div id="allGroupsDiv"  style="display:block;">你好，我是GroupsDiv
						<table id="allGroupsTable" lay-filter="allGroupsTableFilter"></table></div>
					<div id="oneGroupsDiv"  style="display:none;">你好，我是oneGroupsDiv
						<table id="oneGroupsTable" lay-filter="oneGroupsTableFilter" lay-data="{skin:'line', even:true, size:'lg'}"></table></div>
				</div> 
				
				<div id="PloysDiv"  style="display:none;">
					<div id="allPloyDiv"  style="display:block;">你好，我是PloysDiv
						<table id="allPloysTable" lay-filter="allPloysTableFilter" lay-data="{skin:'line', even:true, size:'lg'}"></table></div>
					<div id="onePloyDiv"  style="display:none;">你好，我是onePloysDiv
						<table id="onePloysTable" lay-filter="onePloysTableFilter" lay-data="{skin:'line', even:true, size:'lg'}"></table></div>
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
<%--   <script type="text/javascript" src="${pageContext.request.contextPath }/jsp/index1.js"></script> --%>
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
		layui.use(['table','layer','form'], function(){
			var table = layui.table;
			var layer = layui.layer;
			var form = layui.form;
			/**
			* 6监听所有Control表格
			*/
			if(controlDiv.style.display == "block" && GroupsDiv.style.display == "none" &&  PloysDiv.style.display == "none" &&  UserInfo.style.display == "none"){
				alert("controlDiv监控");
				
				/*1.监听所有集控器表格头部工具栏*/
				table.on('toolbar(allDeviceTableFilter)', function(obj){
			   	var checkStatus = table.checkStatus(obj.config.id); //获取选中行状态
		   	    var devData = checkStatus.data;  //获取选中行数据
		   	    //alert(JSON.stringify(devData));
		   	    //alert("data[0].devMac"+data[0].devMac);
			    switch(obj.event){
			      case 'addDev':
			    	 // alert("addDev");
			    	  addDev();
			      	  break;
			      case 'removeDev':
			    	  if(devData.length > 0 ){
			    		 // alert("监听removeDev");
			    		  var devMac = devData[0].devMac;
			    		  var devName = devData[0].devName;
			    		  var userid = devData[0].userid;
				    	  removeDev(devMac,userid,devName); 
			    	  }else{
			    		  layer.msg("未选择操作对象！");
			    	  }
			          break;
			      case 'renameDev':
			    	  if(devData.length > 0){
			    		  var devMac = devData[0].devMac;
			    		  renameDev(devMac);
			    	  }else{
			    		  layer.msg("未选择操作对象！");
			    	  }
			          break;
			        //case 'DetailMessage':
			    	//if(devData.length > 0){
			    	//	  detailMessage();
			    	//  }else{
			    	//	  layer.msg("未选择操作对象！");
			    	// }
				    // break;
			    };
			   
			 });
				
			/*2.监听所有集控器表格工具*/
			 table.on('tool(allDeviceTableFilter)', function(obj) { 
				    var devData = obj.data; //获取行数据
				    var data = eval('('+ JSON.stringify(devData) +')');
				    if(obj.event === 'openBroadcast') {
				    	var Switch = "打开";
				        broadcastSwitch(data,Switch);
				    } else if(obj.event === 'closeBroadcast') {
					    var Switch = "关闭";
					    broadcastSwitch(data,Switch);
				    } else if(obj.event === 'dimBroadcast') {
				    	setAllBrightness(data);
				    } else if(obj.event === 'setZigbeeFinder') {
				    	setZigbeeFinder(data,obj);
				    	/*layer.prompt({
					        formType: 2
					        ,title: '修改 ID 为 ['+ data.id +'] 的用户签名'
					        ,value: data.sign
					      }, function(value, index){
					        layer.close(index);
					        //这里一般是发送修改的Ajax请求
					        //同步更新表格和缓存对应的值
					        obj.update({
					          sign: value
					        });
					      });*/
				    }  
				  });
			
			/*3.监听zigbee节点表格工具栏*/
			table.on('toolbar(nodeTableFilter)', function(obj){
				 var checkStatus = table.checkStatus(obj.config.id); //获取选中行状态
		   	     var zigbeeCheckData = checkStatus.data;  //获取选中行数据
			   	 switch(obj.event){
			      	case 'removeOfflineZigbee':
			    	  removeOfflineZigbee(); 
			    	  /*
			    	  //等待铺数据
			    	  if(zigbeeCheckData.length > 0 ){
			    		  if(zigbeeCheckData[0].Network == "Offline"){
			    		 	 alert("监听removeOfflineZigbee");
			    		 	 var zigbeeMac = zigbeeCheckData[0].zigbeeMac;
			    		 	 var userid = zigbeeCheckData[0].userid;
			    		 	 removeOfflineZigbee(zigbeeMac,userid); 
			    		  }else{
			    			  layer.alert(zigbeeCheckData[0].zigbeeName + "处于离线状态，无法进行删除操作！");
			    		  }
			    	  }else{
			    		  layer.msg("未选择操作对象！");
			    	  }
			    	  */
			          break;
			      case 'renameZigbee':
			    	  var zigbeeMac = "";
			    	  renameZigbee(zigbeeMac,obj);
			    	  /*
			    	  //等待铺数据
			    	  if(zigbeeCheckData.length > 0){
			    		  var zigbeeMac = zigbeeCheckData[0].zigbeeMac;
			    		  renameZigbee(zigbeeMac);
			    	  }else{
			    		  layer.msg("未选择操作对象！");
			    	  }
			    	  */
			          break;
			    };
			});
			
			/*4.监听zigbee节点表格工具*/
			 table.on('tool(nodeTableFilter)', function(obj) { 
				    var zigbeeData = obj.data; //获取行数据
				    var data = eval('('+ JSON.stringify(zigbeeData) +')');
				    //注意：tool操作暂时未做
				    if(obj.event === 'openZigbeeBroadcast') {
				    	var Switch = "打开";
				        broadcastSwitch(data,Switch);
				    } else if(obj.event === 'closeZigbeeBroadcast') {
					    var Switch = "关闭";
					    broadcastSwitch(data,Switch);
				    } else if(obj.event === 'dimZigeeBroadcast') {
				    	setAllBrightness(data);
				    } else if(obj.event === 'showZigbeeDetail') {
				    	showZigbeeDetail(data,obj);
				    	/*layer.prompt({
					        formType: 2
					        ,title: '修改 ID 为 ['+ data.id +'] 的用户签名'
					        ,value: data.sign
					      }, function(value, index){
					        layer.close(index);
					        //这里一般是发送修改的Ajax请求
					        //同步更新表格和缓存对应的值
					        obj.update({
					          sign: value
					        });
					      });*/
				    }  
				  });
			
			 
	} else if(GroupsDiv.style.display == "block" && controlDiv.style.display == "none"  &&  PloysDiv.style.display == "none" &&  UserInfo.style.display == "none") {		
			alert("监听group");
			/*监听所有Group表格*/
			table.on('toolbar(allGroupsTableFilter)', function(obj){
			   	var checkStatus = table.checkStatus(obj.config.id); //获取选中行状态
		   	    var data = checkStatus.data;  //获取选中行数据
			    switch(obj.event){
			      case 'addGroup':
			    	  alert("监听addGroup");
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
			
	}else if(PloysDiv.style.display ==  "block" && GroupsDiv.style.display ==  "none" &&controlDiv.style.display == "none"  &&  UserInfo.style.display == "none" ){				
			alert("监听策略");
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
			
		}
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
 			leftNavAll.innerHTML = "<a href='javascript:;' onclick='allDeviceTable()'>AllContorllers</a>";
 			inner = " ";
 			for(var i = 0; i < Devices.length; i++){
  				inner = inner + "<li class='layui-nav-item layui-nav-itemed'><a href='javascript:;' onclick='nodeMessage(this.id)' name='dev'></a></li>";
 			}
 			leftNavOne.innerHTML = inner;
 			var aDevice = " ";
 			aDevice = document.getElementsByName("dev");
 			for(var i = 0; i < aDevice.length; i++){
 				aDevice[i].innerHTML = Devices[i].devName;
 				aDevice[i].id = "devNavId-" + Devices[i].devName;
 			}
 			
 	        allDeviceTable();
		}
		
 		function showAllGroups(){
 			alert("function showAllGroups");
 			leftNavAll.innerHTML = "<a href='javascript:;'onclick='allGroupsTable()'>AllGroups</a>";
 			inner = " ";
 			for(var i = 0; i < Groups.length; i++){
 				inner = inner + "<li class='layui-nav-item layui-nav-itemed'><a href='javascript:;' onclick='groupMessage(this.id)' name='group'></a></li>";
 			}
 			leftNavOne.innerHTML = inner;
 			var aGroup = " ";
 			aGroup = document.getElementsByName("group");
 			for(var i = 0; i < aGroup.length; i++){
 				aGroup[i].innerHTML = Groups[i].groupName;
 				aGroup[i].id = "groupNavId-" + Groups[i].groupName;
 			}
 			allGroupsTable();
 		}

 		function showAllPloys(){
 			alert("策略个数"+jsonObj.ployArr.length);
 			leftNavAll.innerHTML = "<a href='javascript:;'onclick='allPloysTable()'>AllPloys</a>";
 			inner = " ";
 			for(var i = 0; i < Ploy.length; i++){
 				inner = inner + "<li class='layui-nav-item layui-nav-itemed'><a href='javascript:;' onclick='ployMessage(this.id)' name='ploy'></a></li>";
 			}
 			leftNavOne.innerHTML = inner;
 			var aPloy = " ";
 			aPloy = document.getElementsByName("ploy");
 			for(var i = 0; i < aPloy.length; i++){
 				aPloy[i].innerHTML = Ploy[i].ployName;
 				aPloy[i].id = "ployNavId-" +  Ploy[i].ployName;
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
  		layui.use(['table','layer','form'], function(){
	    	 	 var table = layui.table;
	    	 	 var layer = layui.layer;
	    	 	 var form = layui.form;
	    	 	 var userid = User.id;
	    		 table.render({
	    	   		  elem:'#allDeviceTable'
	    		     ,size: 'lg' //1大尺寸的表格
	    	   		 ,url: localhost + '/model/devices.do' + "?userid=" + userid //2数据接口
	    	   		 ,toolbar:'#toolbarControllers' 
	    	   		 ,page: true //3开启分页
	    	   		 ,cols: [[ //4表头
	    	   			  {type:'checkbox', fixed: 'left'}
	    	    		 ,{field: 'devName', title: 'name', width:200}
	    	    		 ,{field: 'devMac', title: 'device Mac', width:200,}
	    	     		 ,{field: 'devNet', title: 'status', width:120,templet:function(d){
	    	     			 	if(d.devNet == '0'){
	    	     				 	return'<span>Offline</span>';
	    	     				}else if(d.devNet == '1'){
	    	     					return'<span>Online</span>';
	    	     				}
	    	     		   	  }
	    	     		   }
	    	      		 ,{field: 'onlineNodes', title: 'nodes online', width:120}
	    	      		 ,{field: 'offlineNodes', title: 'nodes offline', width:120} 
	    	      		 ,{field: 'zigbeeFinder', title: 'nodes finder', width:150, event: 'setZigbeeFinder', templet:function(d){
	    	     			 	if(d.zigbeeFinder == '0'){
	    	     				 	return'<span>ON</span>';
	    	     				}
	    	     		   	  }
	    	      		 } 
	    	      		 ,{fixed: 'right', title: 'broadcast',  toolbar: '#barBroadcast', width:180} 
	    	      		 
	    	         ]]
	    	 	 });
  		 	});
	   		render;
}
  /*2.所有组表格*/
  function	allGroupsTable(){
		//alert("functionallGroupsTable");
	    document.getElementById("oneGroupsDiv").style.display = "none"; //将单个表格数据隐藏
	    document.getElementById("allGroupsDiv").style.display = "block"; 
	  		layui.use(['table'], function(){
		    	 	 var table = layui.table;
		    		 table.render({
		    			// skin: 'line' //行边框风格
		    	   		 elem:'#allGroupsTable'
		    			 ,size:'lg'
		    	   		 ,height: 312
		    	   		 ,url:localhost+'/user/allDeviceTable.do'
		    	   		 ,toolbar:'#toolbarGroups'  
		    	   		 ,page: true //开启分页
		    	   		 ,cols: [[ //表头
		    	   			  {type:'checkbox',fixed: 'left'}
		    	    		 ,{field: 'Group Name', title: 'group name', width:120}
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
		document.getElementById("onePloyDiv").style.display = "none"; 
		document.getElementById("allPloyDiv").style.display = "block"; 
		//document.getElementById("allPloysTable") = " ";//将所有策略表格内容清空，用于重新获取数据；
		//document.getElementById("onePloysTable") = " ";
	  		layui.use(['table'], function(){
		    	 	 var table = layui.table;
		    		 table.render({
		    			// skin: 'line' //行边框风格
		    	   		 elem:'#allPloysTable'
		    	   		 ,skin: 'line'
		    	   		 ,size:'lg'
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
  function nodeMessage(leftNavDevId){
	   // alert("nodeMessageTable");
	    var arr = leftNavDevId.split("-"); 
	    var devMac = arr[1];
	    //GroupsDiv.style.display = "none";
	    //PloysDiv.style.display = "none";
	    //controlDiv.style.display = "block";
    	document.getElementById("allDeviceDiv").style.display = "none";
    	document.getElementById("nodeDiv").style.display = "block";
		layui.use(['table'], function(){
	    	 	 var table = layui.table;
	    		 table.render({
	    	   		 elem:'#nodeTable'
	    	   		 ,size:'lg'
	    	   		 ,url:localhost+'/user/allDeviceTable.do'  //注意：接口要改正1.数据接口
	    	   		 ,where: { //2.接口的其它参数
	    	   			 devMac: devMac
	    	   			 }
	    	   		 ,toolbar:'#toolbarNodesTable' 
	    	   		 ,page: true //3开启分页
	    	   		 ,cols: [[ //4表头
	    	   			  {type:'checkbox',fixed: 'left'}
	    	    		 ,{field: 'zigbeeName', title: 'node name', event: 'showZigbeeDetail', width:120,}
	    	     		 ,{field: 'Network', title: 'network', width:120,}
	    	      		 ,{field: 'Brightness', title: 'brightness', width:120}
	    	      		 ,{field: 'Status', title: 'status', width:120, sort: true}
	    	      		 ,{field: 'Temperature', title: 'temperature', width:120}
	    	      		 ,{field: 'Humidity', title: 'humidity', width:120}
	    	      		 ,{field: 'Control', title: 'control', width:120}
	    	      		 ,{fixed: 'right', title: 'broadcast',  toolbar: '#barZigbeeBroadcast', width:180} 
	    	         ]]
	    	 	 });
	    	});  
		render;
		
  }
  
  /*5.显示组内表格信息*/
  function groupMessage(leftNavGroupId) {
	    var arr = leftNavGroupId.split("-"); 
	   // var devMac = arr[1];
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
  function ployMessage(leftNavPloyId){
		alert("oneployMessageTable");
	    var arr = leftNavPloyId.split("-"); 
	    //var devMac = arr[1];
	  	//alert("ployMessageTale");
	    document.getElementById("allPloyDiv").style.display = "none";
    	document.getElementById("onePloyDiv").style.display = "block";
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
  
  
  //添加集控器
  function addDev(){
	 // alert("add集控器function1");
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
  					var devMac = document.getElementById("addDevInput").value;
  					var userid = User.id;
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
  			              var data = eval('(' + datasource + ')');
  			              if (data.error == null || data.error == "" || data.error == undefined) {//未出错
  			            	  layer.msg('Added successfully!', function(){
  			            		  location.reload();
  			            		}); 
  			            	  document.getElementById("addDevInput").value = "";
  			                //userDataRefresh(user, data);用户数据刷新有待考虑
  			              } else {
  			            	  layer.msg(data.error, function(){
  			            		  //do something
  			            		}); 
  			            	  document.getElementById("addDevInput").value = "";
  			              }
  			            },
  			            error: function() {
  			            	 layer.msg("Connection failure!", function(){
  			            		  //do something 
  			            		}); 
  			                 document.getElementById("addDevInput").value = "";
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
	 function removeDev(devMac,userid,devName){
	     // alert("removeDev");
	  	  layer.confirm('is not?',
	  			  {icon: 3, 
	  		      title:'Warnning',
	  		      content:'Note: Are you sure you want to delete the ' + devName + '? After deleting the controller, all zigbee node data linked under the controller will be deleted.',
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
	  			            	  layer.alert('successfully deleted!', function(index){
	  			            		layer.close(index);
	  			            		location.reload();
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
	   function renameDev(devMac){
		 //alert("集控器重命名");
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
	 						//可以通过ajax去"/user/renameDev.do";进行删除集控器操作
	 						var newName = document.getElementById("renameDevInput").value;
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
	 					            		  document.getElementById("renameDevInput").value = " ";
	 					            	  });
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
	 
	 //9.集控器调光开关操作
	 function broadcastSwitch(data,Switch) {
		 alert("broadcastSwitch");
		 var devMac = data.devMac;
		 layui.use('layer', function(){
 	 	 	 var layer = layui.layer;
			 $.ajax({
			        type:"post",
			        url:localhost + "/user/switchByDev.do",
			        data:{
			          devMac:devMac,
			          cmd:Switch
			        },
			        async : true,
			        datatype: "json",
			        success:function(datasource, textStatus, jqXHR) {
			          var data = eval('(' + datasource + ')');
			          //alert(data.error);
			          if (data.error == null || data.error == "" || data.error == undefined) {//未出错
			        	  layer.msg('Command sent successfully!', function(){
		        			  //doSomething
			            	  });
			          } else {
			        	  layer.msg(data.error, function(){
		        			  //doSomething
			            	  });
			          }
			        },
			        error: function() {
			        	layer.msg('Connection failure!', function(){
		        			  //doSomething
			            	  });
			        }
			      });
		 });
	 }
	 
	 //10.设置集控器下所有zigbee节点的亮度
	 function setAllBrightness(data) {
		 var devMac = data.devMac;
		//alert("设置集控器下所有zigbee节点的亮度");
	 	  layui.use('layer', function(){
	 	 	 	 var layer = layui.layer;
	 	 	 	 inner = "<input type='text' id='setDevBrightnessInput' required  lay-verify='required' placeholder=''  autocomplete='off' class='layui-input'>";
	 		  	 layer.open({
	 				 area : [ '600px', '150px' ],
	 				 btnAlign : 'l',
	 				 resize : false,
	 				 closeBtn : 1,
	 				 type : 1,
	 				 title:"Please enter a integer in the range of 1~100",
	 				 content : inner,
	 			     btn : '提交',
	 			     yes : function(index, layero) {
	 						//可以通过ajax去"/user/renameDev.do";进行删除集控器操作
	 						var newBrightness = document.getElementById("setDevBrightnessInput").value;
	 						if (!Number.isNaN(newBrightness) && newBrightness >= 1 && newBrightness <= 100 && newBrightness.indexOf(".") == -1) {
	 				            $.ajax({
	 				              type:"post",
	 				              url:localhost + "/user/setBrightnessByDev.do",
	 				              data:{
	 				                devMac:devMac,
	 				                brightness:newBrightness
	 				              },
	 				              async : true,
	 				              datatype: "json",
	 				              success:function(datasource, textStatus, jqXHR) {
	 				                var data = eval('(' + datasource + ')');
	 				                if (data.error == null || data.error == "" || data.error == undefined) {//未出错
	 				                  	layer.msg("Command sent successfully!");
	 				                	document.getElementById('setDevBrightnessInput').value = "";
	 				                  //注意：集控器表格需要重载
	 				                } else {
	 				                	layer.msg(data.error);
	 				                	document.getElementById('setDevBrightnessInput').value = "";
	 				                }
	 				              },
	 				              error: function() {
	 				            	 layer.msg("Connection failure!");
	 				            	document.getElementById('setDevBrightnessInput').value = "";
	 				              }
	 				            });
	 				          } else {
	 				        	  layer.alert("Error:The input is not an integer, or the entered number is not in the range of 1 to 100");
	 				        	  document.getElementById('setDevBrightnessInput').value = "";
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
	 
	 //11.开启允许节点查询
	 function setZigbeeFinder(data,obj) {
		 var devMac = data.devMac;
		 layui.use(['layer','form'], function(){
 	 	 	 var layer = layui.layer;
 	 	 	 var form = layui.form;
 	 	 	 inner = "<div></div></br><label style='margin:10px;padding:3px'>Please choose one time :</label></br><select id='zigbeeFinderSelect' lay-filter='zigbeeFinderSelect' style='height:30px;width:150px;margin:8px;padding:5px'><option value='60'>60s</option><option value='120'>120s</option><option value='240'>240s</option></select>";
 	 	 	// inner = "<label>Please choose one time :</label></br><input type='radio' name='zigbeeFinderSelect' value='60'>60s</br><input type='radio'name='zigbeeFinderSelect' value='120'>120s</br><input type='radio' name='zigbeeFinderSelect' value='240'>240s";
 		  	 layer.open({
 				 area : [ '300px', '200px'],
 				 btnAlign : 'l',
 				 resize : false,
 				 closeBtn : 1,
 				 type : 1,
 				 title:"Operate",   //英语需确认
 				 content : inner,
 			     btn : '提交',
 			     yes : function(index, layero) {
 			    	var timeCmd = document.getElementById("zigbeeFinderSelect").value;
 			    	//alert(timeCmd);
 			    	 $.ajax({
 			            type:"post",
 			            url:localhost + "/user/turnZigbeeNetFinder.do",
 			            data:{
 			              devMac:devMac,
 			              timeCmd:timeCmd
 			            },
 			            async : true,
 			            datatype: "json",
 			            success:function(datasource, textStatus, jqXHR) {
 			              var data = eval('(' + datasource + ')');
 			              if (data.error == null || data.error == "" || data.error == undefined) {//未出错
 			                  layer.msg("Command sent successfully!");
 			              //注意：更新zigbeefinder选中的时间；有待确认
 			                  obj.update({
 			                	 zigbeeFinder: timeCmd
 			                  });

 			              
 			              } else {
 			            	 layer.msg(data.error);
 			              }
 			            },
 			            error: function() {
 			            	 layer.msg("Connection failure!");
 			            }
 			          });
 					 },
 				 cancel : function() {
 					// 右上角关闭回调
 					// location.reload();
 					// return false 开启该代码可禁止点击该按钮关闭
 				 }
 			 });
 		  });
	 }
	 
	 //12删除zigbee节点，节点处于离线状态时才可进行删除操作
	function removeOfflineZigbee() {
		 alert("removeOfflineZigbee");
		 var zigbeeName = "123";
		 var zigbeeMac = "45";
		 var userid = User.id;
		 layer.confirm('is not?',{
			      icon: 3, 
	  		      title:'Warnning',
	  		      content:'Note: Are you sure you want to delete the ' + zigbeeName + '? ',
	  		      },  
	  		      function(index){
	  		  		//do something
	  		  		 $.ajax({
					        type:"post",
					        url:localhost + "/user/removeZigbee.do",
					        data:{
					          zigbeeMac:zigbeeMac,
					          userid:userid
					        },
					        async : true,
					        datatype: "json",
					        success:function(datasource, textStatus, jqXHR) {
					          var data = eval('(' + datasource + ')');
					          if (data.error == null || data.error == "" || data.error == undefined) {//未出错
					        	  layer.alert('Command sent successfully!', function(index){
					        		  	//注意：删除节点成功后弹窗确定按钮是否有效
		  			            		layer.close(index);
		  			            		location.reload();
		  			            		}); 
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
	 
	 //13.zigbee节点重命名
	 function renameZigbee(zigbeeMac,obj){
		// alert("renameZigbeeFunction");
		// var zigbeeMac = "";
		// var newName = "";
		 inner = "<input type='text' id='renameZigbeeInput' required  lay-verify='required' placeholder='请输入新名称'  autocomplete='off' class='layui-input'>";
		 layer.open({
				 area : [ '600px', '150px' ],
				//offset:['100px','450px'],
				 btnAlign : 'l',
				 resize : false,
				 closeBtn : 1,
				 type : 1,
				 title:"Please enter a new node name:",
				 content : inner,
			     btn : '提交',
			     yes : function(index, layero) {
						var newName = document.getElementById("renameZigbeeInput").value;
						if(newName != null && newName != "" && newName.length <=16){
							$.ajax({
					            type:"post",
					            url:localhost + "/user/renameZigbee.do",
					            data:{
					              zigbeeMac:zigbeeMac,
					              newName:newName
					            },
					            async : true,
					            datatype: "json",
					            success:function(datasource, textStatus, jqXHR) {
					            	//alert("success");
					              var data = eval('(' + datasource + ')');
					              if (data.error == null || data.error == "" || data.error == undefined) {//未出错
					            	  layer.msg('Successfully modified!', function(){
					            		  document.getElementById("renameZigbeeInput").value = " ";
					            	  });
					              	//注意： 节点名称需要更新;
					                //注意：更新zigbeefinder选中的时间；有待确认
		 			                  obj.update({
		 			                	 zigbeeName: newName
		 			                  }); 
					              } else {
					            	  layer.msg(data.error, function(){
					            		  //do something
					            		  document.getElementById("renameZigbeeInput").value = " ";
					            		}); 
					              	}
					            },
					            error: function() {
					            	 layer.msg("Connection failure!", function(){
					            		  //do something
					            		 document.getElementById("renameZigbeeInput").value = " ";
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
					// location.reload(); 若表格数据更新可以，则不需要重载
					// return false 开启该代码可禁止点击该按钮关闭
				 }
			 });
		
	 }
    </script>
   
   
   
   <script>
   /*9.查看集控器详细信息*/
	   /* function detailMessage(){
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
	    }*/ 
  
    /**********************************控制组表格相关操作***********************************/    
	    /*10.添加控制组*/
	    function addGroup(){
    		alert("addGroup");
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
	  						var newGroupName = document.getElementById("addGroupInput").value;
	  						var userid = User.id;
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
	  					              } else {
	  					            	  layer.msg(data.error, function(){
	  					            		  //do something
	  					            		  document.getElementById("addGroupInput").value = " ";
	  					            		}); 
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
   
   /***********************************策略表格相关操作**********************************/    
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

	     
<%-- **********************Control与Node表格的toolbar或templet *********************** --%>   
  
	 <script type="text/html" id="toolbarControllers">   
		<div class="layui-btn-container">	
			<button class="layui-btn layui-btn-sm"  lay-event="addDev">Add Controller</button>
    		<button class="layui-btn layui-btn-sm"  lay-event="removeDev">Delete Controller</button>
   			<button class="layui-btn layui-btn-sm"  lay-event="renameDev">Rename Controller</button>
   			<%--<button class="layui-btn layui-btn-sm"  lay-event="DetailMessage">DetailMessage</button>--%>
  		</div>
    </script>
	<script  type="text/html" id="barBroadcast">
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="openBroadcast">ON</a>
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="closeBroadcast">OFF</a>
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="dimBroadcast">DIM</a>
    </script>
    <script type="text/html" id="toolbarNodesTable">   
		<div class="layui-btn-container">	
    		<button class="layui-btn layui-btn-sm"  lay-event="removeOfflineZigbee">Delete Node</button>
   			<button class="layui-btn layui-btn-sm"  lay-event="renameZigbee">Rename Node</button>
  		</div>
    </script>
    <script  type="text/html" id="barZigbeeBroadcast">
	<div class="layui-btn-group">
  		<a class="class="layui-btn layui-btn-sm" lay-event="openZigbeeBroadcast">ON</a>
  		<a class="class="layui-btn layui-btn-sm" lay-event="closeZigbeeBroadcast">OFF</a>
  		<a class="class="layui-btn layui-btn-sm" lay-event="dimZigeeBroadcast">DIM</a>
	</div>
    </script>

    
<%-- **********************Group表格的toolbar或templet *********************** --%> 
    
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
   
</body>
</html>
