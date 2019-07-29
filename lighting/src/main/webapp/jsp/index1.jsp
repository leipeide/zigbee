<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="java.util.*,com.test.domain.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	<%-- 弹窗内容 	--%>
	<div><form class="layui-form" action="" id="addPlayWindow"
			lay-filter="form0" style="display: none; margin-top: 30px;">
			<div class="layui-form-item">
				<label class="layui-form-label"><spring:message code='ployName'/></label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" style="width: 150px" 
					placeholder="<spring:message code='PleaseEnter'/>" id="addPloyInput">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label"><spring:message code='selectGroup'/></label>
				<div class="layui-input-block" id="selectGroupDiv"></div>
			</div>
		</form>
	</div>

	<div><form class="layui-form" action="" lay-filter="form1"
			id="changeGroupWindow" style="display: none; margin-top: 30px;">
			<div class="layui-form-item">
				<label class="layui-form-label"><spring:message code='BindGroup'/></label>
				<div class="layui-input-block" id="changeGroupDiv"></div>
			</div>
		</form>
	</div>

	<div><form class="layui-form" action="" lay-filter="form2"
			id="addPlanWindow" style="display: none;">
			<table class="layui-table" lay-even lay-skin="line">
				<colgroup>
					<col width="180">
					<col width="180">
					<col width="180">
					<col>
				</colgroup>
				<thead>
					<tr>
						<th><spring:message code='CmdPoint'/></th>
						<th><spring:message code='CmdType'/></th>
						<th><spring:message code='CmdParam'/></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" id="HH" style="width: 30px; height: 30px" 
							placeholder="HH"> ： <input type="text" id="MM"
							style="width: 30px; height: 30px" 
							placeholder="MM"></td>
						<td><div style="width: 120px;">
								<select id="selectSwitchStatus" lay-verify="" lay-filter="selectSwitchFilter">
									<option value=""><spring:message code='chooseType'/></option>
									<option value="switch"><spring:message code='Switch'/></option>
									<option value="dim"><spring:message code='Dim'/></option>
								</select>
							</div></td>
						<td><div style="width: 120px; display: block;"
								id="SwitchParam">
								<select id="selectSwitchParam" lay-verify="" lay-filter="selectOpenFilter">
									<option value=""><spring:message code='chooseStatus'/></option>
									<option value="0"><spring:message code='OFF'/></option>
									<option value="1"><spring:message code='ON'/></option>
								</select>
							</div>
							<div style="display: none;" id="DimParam">
								<input type="text" id="DimParamInput" placeholder="0" value="0"
									style="width: 80px; height: 30px" autocomplete="off">
							</div></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<div><form class="layui-form" action="" lay-filter="form3"
			id="addNodeWindow" style="display: none;">
			<div class="layui-form-item">
				<div class="layui-input-block" id="addNodeDiv"></div>
			</div>
		</form>
	</div>
    <div><form class="layui-form" action="" lay-filter="form4"
			id="setZigbeeFinderWindow" style="display: none;">
			<div class="layui-form-item">
				<div style="width:150px;margin-left:30px;">
<!-- 					</br> -->
					<select id="zigbeeFinderSelect" lay-verify="" lay-filter="zigbeeFinderSelectFilter" >
						<option value=""><spring:message code="select"/></option>
						<option value="60">60s</option>
						<option value="120">120s</option>
						<option value="240">240s</option>
					</select>
				</div>
			</div>
		</form>
	</div> 

	<%--系统页面 --%>
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
			<div class="layui-logo"><spring:message code="WahoLightingSystem"/></div>
			<!-- 头部区域（可配合layui已有的水平导航） -->
			<ul class="layui-nav layui-layout-left">
				<li class="layui-nav-item"><a href="javascript:;"
					onclick="ControllersHide()"><spring:message code="Controllers"/></a></li>
				<li class="layui-nav-item"><a href="javascript:;"
					onclick="GroupsHide()"><spring:message code="Groups"/></a></li>
				<li class="layui-nav-item"><a href="javascript:;"
					onclick="PloysHide()"><spring:message code="Ploys"/></a></li>
			   <li class="layui-nav-item"><a href="javascript:;"><spring:message code="language"/></a>
					<dl  class="layui-nav-child">
						<dd><a href="javascript:;" onclick="English()"><spring:message code="language.en" /></a></dd>
						<dd><a href="javascript:;" onclick="Chinese()"><spring:message code="language.cn" /></a></dd>  
					</dl>
				</li>
			</ul>
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item"><a href="javascript:;"><img
						src="http://t.cn/RCzsdCq" class="layui-nav-img"><span
						id="UserName"></span></a>
					<dl id=demo class="layui-nav-child">
						<dd>
							<a href="javascript:;" onclick="UserInfoHide()"><spring:message code="UserInfo" /></a>
						</dd>
					</dl></li>
 				<li class="layui-nav-item"><a href="javascript:;" 
					onclick="ExitCount()"><spring:message code="Exit" /></a></li>
					
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
		<%--隐藏input js动态设置value,作为数据传递的桥梁 ，暂时未用，已用其它的保存参数，用时放到layui-body内--%>
        <%--<input type="text" value="" id="getData" style="display:none" autocomplete="off" class="layui-input"> --%>
		
		<div class="layui-body">
			<form class="layui-form">
			<iframe style="height: 3px" name="fname" frameborder="0" 
					scrolling="no" width="100%" src="" class="body-frame"></iframe>
				<div style="min-height: 500px;">
					<div id="controlDiv" style="display: block;">
						<div id="allDeviceDiv" style="display: block;">
							<table id="allDeviceTable" lay-filter="allDeviceTableFilter" class="layui-table"></table></div>
						<div id="nodeDiv" style="display: none;">
							<table id="nodeTable" lay-filter="nodeTableFilter" class="layui-table"></table></div>
					</div>
					
					<div id="GroupsDiv" style="display: none;">
						<div id="allGroupsDiv" style="display: block;">
							<table id="allGroupsTable" lay-filter="allGroupsTableFilter" class="layui-table"></table></div>
						<div id="oneGroupsDiv" style="display: none;">
							<table id="oneGroupsTable" lay-filter="oneGroupsTableFilter" class="layui-table"></table></div>
					</div>
					
					<div id="PloysDiv" style="display: none;">
						<div id="allPloyDiv" style="display: block;">
							<table id="allPloysTable" lay-filter="allPloysTableFilter" class="layui-table"></table></div>
						<div id="onePloyDiv" style="display: none;">
							<table id="onePloysTable" lay-filter="onePloysTableFilter" class="layui-table"></table></div>
					</div>
					
					<div id="UserInfo" style="display: none;">
						<div id="userMessageDiv" style="display: block;">
							<div><blockquote class="layui-elem-quote layui-quote-nm">
									<font size='5'><spring:message code="UserInformation" /></font></blockquote>
								<hr class="layui-bg-cyan">
							</div>
							<div class="userMessage"
								style="margin-right: 200px; padding: 50px; padding-left: 150px;">
								<div class="layui-form-item">
									<label id="um-username"></label></div>
								<div class="layui-form-item">
									<label id="um-email"></label></div>
								<div class="layui-form-item">
									<label id="um-phone"></label></div>
							</div>
						</div>
						
						<div id="passwordResetDiv" style="display: none;">
							<div><blockquote class="layui-elem-quote layui-quote-nm">
									<font size='5'><spring:message code="PasswordReset" /></font></blockquote>
								    <hr class="layui-bg-cyan">
							</div>
							<div id="RePasswordBody" style="padding: 50px;">
								<div class="layui-form-item">
									<label class="layui-form-label" style="width:150px"><spring:message code="Password" />：</label>
									<div class="layui-input-inline">
										<input type="password" id="oldpassword" required lay-verify="required" 
											placeholder="<spring:message code='password'/>" autocomplete="off" class="layui-input"></div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label" style="width:150px"><spring:message code="NewPassword" />：</label>
									<div class="layui-input-inline">
										<input type="password" id="newpassword" required lay-verify="required" 
											placeholder="<spring:message code='newpassword'/>" autocomplete="off" class="layui-input"></div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label" style="width:150px"><spring:message code="RepeatNewPassword" />：</label>
									<div class="layui-input-inline">
										<input type="password" id="repassword" required lay-verify="required" 
											placeholder="<spring:message code='newpassword'/>" autocomplete="off" class="layui-input" 
											onblur="passwordTest()" onkeyup="passwordTest()">
										<span style="color:red; display:none;" id="passwordTestSpan"><spring:message code="ChangePasswordErrorTips" /></span>		
									</div>
								</div>
								<div class="layui-btn-container" style="padding-left: 180px;">
									<button type="button" class="layui-btn" onclick="changePasswordEnter()"><spring:message code="Confirm" /></button>
									<button type="button" class="layui-btn" onclick="changePasswordCancel()"><spring:message code="Cancel" /></button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
		
		<!-- 底部固定区域 -->
		<div class="layui-footer">
			© <spring:message code="foot.logo"/>
		</div>
		
	</div>

	<script>
	  layui.use('element', function() {
			var element = layui.element;
		});
    </script>
    <script type="text/javascript">
		/*
		*.初始化数据
		*/
	    var localhost = "<%=request.getContextPath()%>"; // 登入网址
	    var jsonObj = ${responseJson};  // 获取登录成功后control返回的数据
	    var Devices = jsonObj.devArr;   // 用户集控器对象集合
	    var DevAttrArr = jsonObj.devAttrArr; // 集控器对象参数集合
	    var Groups = jsonObj.groupArr;  // 用户控制组对象集合
	    var GroupPair = jsonObj.groupPairArr;  // 用户控制组pair对象集合
	    var Ploy = jsonObj.ployArr;     // 用户策略对象集合
	    var User = jsonObj.user;        // 该用户信息对象
	    var zigbeeArr = jsonObj.zigbeeArr;  // 用户节点对象集合
	    var zigbeeSet = new Array();        // 初始化节点数组，为后面提供
	    var ploySet = new Array();        // 初始化策略数组，为后面提供
	    var selectDevSet = new Array();  // 初始化集控器数组，为后面提供
	    var controlDiv = document.getElementById("controlDiv"); // 主体区域：集控器区域块
	    var GroupsDiv = document.getElementById("GroupsDiv"); // 主体区域：控制组区域块
	    var PloysDiv = document.getElementById("PloysDiv"); // 主体区域：策略区域块
	    var UserInfo = document.getElementById("UserInfo"); // 主体区域：用户信息区域块
	    var leftNavAll =  document.getElementById("leftNavAll");//左边导航栏区域：所有
	    var leftNavOne =  document.getElementById("leftNavOne");//左边导航栏区域 ：单个
	    var pageTimer = {}; // 定义定时器全局变量
	    var tableRefreshCount = 0;  //表格刷新计数
	    var mouse_x ; // 监听鼠标 
	    var mouse_y ; // 监听鼠标
	    /*自动刷新table表格时，单个集控器下、单个分组下、单个策略表格需要当前devmac/groupAddr/ployid参数，
	   		 方可以刷新表格；故建立三个暂存空间。每次点击单个分组、集控器、策略将他们的参数保存*/
	    var deviceMacSaveSpace = null; // devmac暂存空间
	    var groupAddrSaveSpace = null; // groupAddr暂存空间
	    var ployidSaveSpace = null; // ployid暂存空间
	   
	    document.getElementById("UserName").innerHTML = User.username; // 水平导航用户信息区域插入用户名
	 	/*
	 	*.刷新用户数据
	 	*/
	 	function intervalRefresh() {
	 	  $.ajax({
	 	    type:"post",
	 	    url:localhost + "/user/refresh.do",
	 	    data:{
	 	      userid:User.id,
	 	    },
	 	    async : true,
	 	    datatype: "json",
	 	    success:function(datasource, textStatus, jqXHR) {
	 	      var data = eval('(' + datasource + ')');
	 	      if (data.error == null || data.error == "" || data.error == undefined) {
	 	        userDataRefresh(data);//调用数据更新函数
	 	      } else {
	 	    	/*语言未定义：
	 	    	      接口层刷新函数返回的error为undefined;故else内的函数不会执行;
	 	    	  alert提示的字符串不需要进行语言切换，故alert内的字符串未定义  */
	 	    	layer.alert(data.error,{
	 	    		title:"<spring:message code='error'/>",
	 	    		closeBtn: 0,
		 	        btn : "<spring:message code='btn.Close'/>",
	 			    yes : function(index, layero) {
	 		         	 layer.close(index);
	 		        },
	 	    	}); 
	 	    	  
	 	      }
	 	    },
	 	    error: function() {
	 	      layer.alert("<spring:message code='Connectionfailure'/>" + "!",{
	 	    	  title:"<spring:message code='error'/>",
	 	    	  closeBtn: 0,
	 	    	  btn : "<spring:message code='btn.Close'/>",
 			      yes : function(index, layero) {
 			    	 layer.close(index);
 			      },
	 	      });
	 	      window.clearInterval(pageTimer.timer1);
	 	    }
	 	  });
	 	}
	 	pageTimer.timer1 = setInterval("intervalRefresh()",5000);//定时刷新，单位毫秒
	 	pageTimer.timer2 = setInterval("tableRefresh()",1000*60);
	 	function userDataRefresh(data) {
		     Devices = data.devArr;   // 用户集控器对象集合
		     DevAttrArr = data.devAttrArr; // 集控器对象参数集合
		     Groups = data.groupArr;  // 用户控制组对象集合
		     Ploy = data.ployArr;     // 用户策略对象集合
		     GroupPair = data.groupPairArr;
		     User = data.user;        // 该用户信息对象
		     zigbeeArr = data.zigbeeArr;  // 用户节点对象集合
		    if(controlDiv.style.display == "block" && GroupsDiv.style.display == "none" &&  PloysDiv.style.display == "none" &&  UserInfo.style.display == "none"){
				//1.集控器导航栏更新
		    	leftNavAll.innerHTML = "<a href='javascript:;' onclick='allDeviceTable()'><spring:message code='Nav.AllContorllers'/></a>";
	 			inner = " ";
	 			for(var i = 0; i < Devices.length; i++){
	  				inner = inner + "<li class='layui-nav-item layui-nav-itemed'><a href='javascript:;' onclick='nodeMessage(this.id)' name='dev'></a></li>";
	 			}
	 			leftNavOne.innerHTML = inner;
	 			var aDevice = " ";
	 			aDevice = document.getElementsByName("dev");
	 			for(var i = 0; i < aDevice.length; i++){
	 				aDevice[i].innerHTML = Devices[i].devName;
	 				aDevice[i].id = "devNavId-" + Devices[i].devMac;
	 			}
	 			
			}else if(controlDiv.style.display == "none" && GroupsDiv.style.display == "block" &&  PloysDiv.style.display == "none" &&  UserInfo.style.display == "none"){
				//2.控制组导航栏更新
				leftNavAll.innerHTML = "<a href='javascript:;'onclick='allGroupsTable()'><spring:message code='Nav.AllGroups'/></a>";
	 			inner = " ";
	 			for(var i = 0; i < Groups.length; i++){
	 				inner = inner + "<li class='layui-nav-item layui-nav-itemed'><a href='javascript:;' onclick='oneGroupMessage(this.id)' name='group'></a></li>";
	 			}
	 			leftNavOne.innerHTML = inner;
	 			var aGroup = " ";
	 			aGroup = document.getElementsByName("group");
	 			for(var i = 0; i < aGroup.length; i++){
	 				aGroup[i].innerHTML = Groups[i].groupName;
	 				aGroup[i].id = "groupNavId-" + Groups[i].groupid;
	 			}
				
			}else if(controlDiv.style.display == "none" && GroupsDiv.style.display == "none" &&  PloysDiv.style.display == "block" &&  UserInfo.style.display == "none"){
				//3.策略导航栏更新
				leftNavAll.innerHTML = "<a href='javascript:;'onclick='allPloysTable()'><spring:message code='Nav.AllPloys'/></a>";
	 			inner = " ";
	 			for(var i = 0; i < Ploy.length; i++){
	 				inner = inner + "<li class='layui-nav-item layui-nav-itemed'><a href='javascript:;' onclick='onePloyMessage(this.id)' name='ploy'></a></li>";
	 			}
	 			leftNavOne.innerHTML = inner;
	 			var aPloy = " ";
	 			aPloy = document.getElementsByName("ploy");
	 			for(var i = 0; i < aPloy.length; i++) {
	 				aPloy[i].innerHTML = Ploy[i].ployName;
	 				aPloy[i].id = "ployNavId-" +  Ploy[i].id;
	 			}
			}
		  //.保存节点数据；注意：弄清在哪里使用过，能否不通过初始登录时的数据进行js操作
				 for (var i in data.zigbeeArr) {
					 zigbeeSet.push(new Zigbee(
						    zigbeeArr[i].zigbeeName, 
						    zigbeeArr[i].zigbeeMac, 
						    zigbeeArr[i].devMac, 
					        zigbeeArr[i].zigbeeBright, 
					        zigbeeArr[i].zigbeeNet, 
					        zigbeeArr[i].zigbeeStatus
					      ));
					 for (var index in data.zigbeeAttrArr) {
						 if (data.zigbeeAttrArr[index].zigbeeMac == data.zigbeeArr[i].zigbeeMac) {
					        count = zigbeeSet.length - 1;
					        zigbeeSet[count].temperature = data.zigbeeAttrArr[index].temperature / 100;
					        zigbeeSet[count].humidity = data.zigbeeAttrArr[index].humidity / 100;
					        zigbeeSet[count].type = data.zigbeeAttrArr[index].type;
					        if (zigbeeSet[count].type != null) {
					          if (zigbeeSet[count].type == 1 || zigbeeSet[count].type == 2 || zigbeeSet[count].type == 17 || zigbeeSet[count].type == 18) {
					            zigbeeSet[count].minPower = 50;
					          } else if (zigbeeSet[count].type == 3 || zigbeeSet[count].type == 19) {
					            zigbeeSet[count].minPower = 1;
					          } else {
					            zigbeeSet[count].minPower = 1;
					          }
					        } else {
					          zigbeeSet[count].minPower = 1;
					        }
					        zigbeeSet[count].power = zigbeeAttrArr[index].power;
					      }
					    }			
							
				 }
		 	
				//5.注意核对这段代码在哪里用过，最好可以直接从后台获取
				for(var i in data.ployArr) {
					ploySet.push(new ploy(
						data.ployArr[i].ployName,
						data.ployArr[i].id,
						data.ployArr[i].status,
						data.ployArr[i].userid,
						data.ployArr[i].bindType,
						data.ployArr[i].bindData,
						data.ployArr[i].timeZone));
			    }
	 	}
	 	
	 //.监听鼠标或键盘5分钟未操作，刷新table
	 function tableRefresh(){
		  tableRefreshCount = tableRefreshCount + 1;
		  if (tableRefreshCount == 5) {
			  //重载表格
				layui.use('table',function(){
				    var table = layui.table;
				    //1.重载所有集控器表格
				    table.reload('allDeviceTable', {
						   url: localhost + '/model/devices.do' 
				          ,where: {
				        	  userid : User.id
					  	   }
						});
				    
				    //2.重载集控器下单个节点表格
					table.reload('nodeTable', {
						url:localhost+'/model/zigbee.do'
				        ,where: {
				        	 devMac: deviceMacSaveSpace
					  	  }
					  });	
				    //3.重载所有分组表格
					table.reload('allGroupsTable', {
						url:localhost+'/model/groups.do'
				        ,where: {
				        	 userid : User.id
					  	  }
					  });	
				    //4.重载单个分组表格
					table.reload('oneGroupsTable', {
						 url:localhost+'/model/groupDetail.do'
				        ,where: {
				        	groupid:groupAddrSaveSpace
					  	  }
					  });
				    //5.重载所有策略表格
					table.reload('allPloysTable', {
						 url:localhost+'/model/ploys.do'
				        ,where: {
				        	 userid : User.id
					  	  }
					  });	
				    //6.重载单个策略表格
					table.reload('onePloysTable', {
						 url:localhost+'/model/ployOperate.do'
				        ,where: {
				        	id:ployidSaveSpace
					  	  }
					  });	
				});	
				tableRefreshCount = 0;
	        }
		    //监听鼠标
		    document.onmousemove = function (event) {
		        var x1 = event.clientX;        
		        var y1 = event.clientY;
		        if (mouse_x != x1 || mouse_y != y1) {
		        	tableRefreshCount = 0;
		        }
		        mouse_x = x1;
		        mouse_y = y1;
		    };
		    //监听键盘
		    document.onkeydown = function () {
		    	tableRefreshCount = 0;
		    };
		    
	 	}
	 	
	    /*
	    *.构造对象
	    */
	    //1.添加ployOperate时参数保存时的对象
	    function PloyOperate(id, hours, minutes, operateType, operateParam, ployid) {//策略项
			    this.id = id;
				this.hours = hours;
				this.minutes = minutes;
				this.operateType = operateType;//操作类型(1,开关、2,调光)
				this.operateParam = operateParam;//参数(1开，0关)
			    this.ployid = ployid;
		}
	    //2.创建节点对象
		function Zigbee(zigbeeName, mac, devMac, zigbeeBright, zigbeeNet, zigbeeStatus,
				  version, type, temperature, humidity, minPower) {  
					this.name = zigbeeName;
				  if (zigbeeNet == 1) {
				    this.online = true;
				  } else {
				    this.online = false;
				  }
					this.brightness = zigbeeBright;
				  if (zigbeeStatus == 1) {
				    this.workStatus = true;
				  } else {
				    this.workStatus = false;
				  }
					this.mac = mac;
					this.devMac = devMac;
					this.groupAddrs = new Array();
				  this.groupNames = new Array();
				  this.version = version;
				  this.type = type;
				  this.temperature = temperature;
				  this.humidity = humidity;
				  this.minPower = minPower;
				}
		//3.保存节点数据；注意：弄清在哪里使用过，能否不通过初始登录时的数据进行js操作
		for (var i in jsonObj.zigbeeArr) {
				zigbeeSet.push(new Zigbee(
			      jsonObj.zigbeeArr[i].zigbeeName, 
			      jsonObj.zigbeeArr[i].zigbeeMac, 
			      jsonObj.zigbeeArr[i].devMac, 
			      jsonObj.zigbeeArr[i].zigbeeBright, 
			      jsonObj.zigbeeArr[i].zigbeeNet, 
			      jsonObj.zigbeeArr[i].zigbeeStatus
			      ));
				 for (var index in jsonObj.zigbeeAttrArr) {
					 if (jsonObj.zigbeeAttrArr[index].zigbeeMac == jsonObj.zigbeeArr[i].zigbeeMac) {
				        count = zigbeeSet.length - 1;
				        zigbeeSet[count].temperature = jsonObj.zigbeeAttrArr[index].temperature / 100;
				        zigbeeSet[count].humidity = jsonObj.zigbeeAttrArr[index].humidity / 100;
				        zigbeeSet[count].type = jsonObj.zigbeeAttrArr[index].type;
				        if (zigbeeSet[count].type != null) {
				          if (zigbeeSet[count].type == 1 || zigbeeSet[count].type == 2 || zigbeeSet[count].type == 17 || zigbeeSet[count].type == 18) {
				            zigbeeSet[count].minPower = 50;
				          } else if (zigbeeSet[count].type == 3 || zigbeeSet[count].type == 19) {
				            zigbeeSet[count].minPower = 1;
				          } else {
				            zigbeeSet[count].minPower = 1;
				          }
				        } else {
				          zigbeeSet[count].minPower = 1;
				        }
				        zigbeeSet[count].power = jsonObj.zigbeeAttrArr[index].power;
				      }
				    }
				
			}
		
		//4.构造策略对象
		function ploy(ployName, ployId, status, userid, bindType, bindParam, timeZone) {//控制策略
			this.name = ployName; // 策略名
			this.id = ployId; // 策略id
			this.status = status; // 策略执行状态
		    this.userid = userid; // 用户id
		  	this.bindType = bindType; // 绑定类型(1组、2集控器、3节点)
		  	this.bindParam = bindParam; // 绑定参数(组id、集控器mac地址、节点mac地址)
		  	this.timeZone = timeZone; // 时区(时间差值，单位分钟) 
		/*
		      注意：ploy对象所有属性需要添加完整，要不会有错误
		  this.currentOperate = new PloyOperate(0, 0, 0, 1, 0);
	      this.operateArray = new Array();
		  this.operateBackUp;
	      this.editStarted = false;
		*/
		}
		//5.注意核对这段代码在哪里用过，最好可以直接从后台获取
		for(var i in jsonObj.ployArr) {
			ploySet.push(new ploy(
		      jsonObj.ployArr[i].ployName,
		      jsonObj.ployArr[i].id,
		      jsonObj.ployArr[i].status,
		      jsonObj.ployArr[i].userid,
		      jsonObj.ployArr[i].bindType,
		      jsonObj.ployArr[i].bindData,
		      jsonObj.ployArr[i].timeZone));
		}  
		
		//6.将gmt时间转换成当地时间函数
		function getLocalTime(hours, minutes, offset) {
			  var hoursOffset = offset / 60;
			  var minutesOffset = offset % 60;
			  var localhours = hours - hoursOffset;
			  var localminutes = minutes - minutesOffset;
			  if (localminutes < 0) {
			    localminutes += 60;
			    localhours -= 1;
			  } else if (localminutes >= 60) {
			    localminutes -= 60;
			    localhours += 1;
			  }
			  localhours = localhours % 24;
			  if (localhours < 0) {
			    localhours += 24;
			  }
			  return {
			    "localhours":localhours,
			    "localminutes":localminutes
			  };
		}
		
		//7.将本地时间转换成gmt时间	
		function getGMTTime(localhours, localminutes, offset) {
			  var hoursOffset = offset / 60;
			  var minutesOffset = offset % 60;
			  var gmthours = parseInt(localhours,10) + hoursOffset;
			  var gmtminutes = parseInt(localminutes,10) + minutesOffset;
			  if (gmtminutes < 0) {
			    gmtminutes += 60;
			    gmthours -= 1;
			  } else if (gmtminutes >= 60) {
			    gmtminutes -= 60;
			    gmthours += 1;
			  }
			  gmthours = gmthours % 24;
			  if (gmthours < 0) {
			    gmthours += 24;
			  }
			  return {
			    "gmthours":gmthours,
			    "gmtminutes":gmtminutes
			  };
		}
		
		
	  
	   /*
	    *layui数据表格监听
	    */
		layui.use(['table','layer','form'], function(){
			var table = layui.table;
			var layer = layui.layer;
			var form = layui.form;
			//1.监听所有集控器表格头部工具栏
			table.on('toolbar(allDeviceTableFilter)', function(obj){
			   	var checkStatus = table.checkStatus(obj.config.id); // 获取选中行状态
		   	    var devData = checkStatus.data;  // 获取选中行数据
		   	    //alert(JSON.stringify(devData)+"data[0].devMac"+data[0].devMac);
			    switch(obj.event){
			      case 'addDev':
			    	  addDev(); // 添加集控器
			      	  break;
			      case 'removeDev':
			    	  if(devData.length > 0 ){
			    		  var devMac = devData[0].devMac;
			    		  var devName = devData[0].devName;
			    		  var userid = devData[0].userid;
				    	  removeDev(devMac,userid,devName); // 删除集控器
			    	  }else{
			    		   layer.msg("<spring:message code='UnselectedOperatingObject'/>" + "!");
			    	  }
			          break;
			      case 'renameDev':
			    	  if(devData.length > 0){
			    		  var devMac = devData[0].devMac;
			    		  renameDev(devMac); // 集控器重命名
			    	  }else{
			    		  layer.msg("<spring:message code='UnselectedOperatingObject'/>" + "!");
			    	  }
			          break;    
			    };
			   
			 });	
			//2.监听所有集控器表格内事件
			 table.on('tool(allDeviceTableFilter)', function(obj) { 
			 	   var devData = obj.data;  // 获取行数据
				   var data = eval('('+ JSON.stringify(devData) +')');
				   if(obj.event == 'openBroadcast') {
					    	if(data.devNet == 1){
					        	var Switch = "打开";
						        broadcastSwitch(data,Switch);//广播控制
					    	}else{
					    		//离线状态不可操作
					    		layer.alert(data.devName + " <spring:message code='offline.unoperational'/>" + "!",{
					    			title: " <spring:message code='Tips'/>",
					 	    		closeBtn: 0,
						 	        btn : "<spring:message code='btn.Close'/>",
					 			    yes : function(index, layero) {
					 		         	 layer.close(index);
					 		        },
					 	    	}); 
					    	}
					   
				    } else if(obj.event == 'closeBroadcast') {
						    	if(data.devNet == 1){
						    		 var Switch = "关闭";
							        broadcastSwitch(data,Switch);//广播控制
						    	}else{
						    		//离线状态不可操作
						    		layer.alert(data.devName + " <spring:message code='offline.unoperational'/>" + "!",{
						 	    		title: " <spring:message code='Tips'/>",
						 	    		closeBtn: 0,
							 	        btn : "<spring:message code='btn.Close'/>",
						 			    yes : function(index, layero) {
						 		         	 layer.close(index);
						 		        },
						 	    	}); 
						    	}
				    	
				    	
				    } else if(obj.event == 'dimBroadcast') {
						    	if(data.devNet == 1){
						    		setAllBrightness(data);//广播调光控制
						    	}else{
						    		//离线状态不可操作
						    		layer.alert(data.devName + " <spring:message code='offline.unoperational'/>" + "!",{
						 	    		title: " <spring:message code='Tips'/>",
						 	    		closeBtn: 0,
							 	        btn : "<spring:message code='btn.Close'/>",
						 			    yes : function(index, layero) {
						 		         	 layer.close(index);
						 		        },
						 	    	}); 
						    	}
				    	
				    	
				    } else if(obj.event == 'setZigbeeFinder') {
				    	setZigbeeFinder(data,obj);//开启集控器允许被发现
				    }  
			});
			//3.监听zigbee节点表格头部工具栏
			table.on('toolbar(nodeTableFilter)', function(obj) {
				 var checkStatus = table.checkStatus(obj.config.id); // 获取选中行状态
			     var zigbeeCheckData = checkStatus.data;  // 获取选中行数据
		   	     //alert(JSON.stringify(zigbeeCheckData));
			   	 switch(obj.event){
			      	case 'removeOfflineZigbee': // 重要：删除节点，此处是移除离线节点
				    	if(zigbeeCheckData.length > 0 ){
				    		var zigbeeName = zigbeeCheckData[0].zigbeeName;
				    		if(zigbeeCheckData[0].zigbeeNet == "0") {  
				    	       var zigbeeMac = zigbeeCheckData[0].zigbeeMac;
				    		   var userid = User.id;
				    	   	   var devMac = zigbeeCheckData[0].devMac;
				    		   removeOfflineZigbee(zigbeeMac,userid,zigbeeName,devMac); 
				    		 }else{ 
				    			//注意： 删除节点时选中状态未清除。(表格重载可以解决)
				    			 layer.alert(zigbeeName + " <spring:message code='online.undelete'/>" + "!",{
						 	    		title: " <spring:message code='Tips'/>",
						 	    		closeBtn: 0,
							 	        btn : "<spring:message code='btn.Close'/>",
						 			    yes : function(index, layero) {
						 		         	 layer.close(index);
						 		        },
						 	    	}); 
				    		 }
				    	  }else{
				    		  layer.msg("<spring:message code='UnselectedOperatingObject'/>" + "!");
				    	  }
				          break;
			      	 case 'renameZigbee':
				   	     if(zigbeeCheckData.length > 0){
				    		  var zigbeeMac = zigbeeCheckData[0].zigbeeMac;
				    		  var devMac = zigbeeCheckData[0].devMac;
				    		  renameZigbee(zigbeeMac,obj,devMac); // 节点重命名
				    	  }else{
				    		  layer.msg("<spring:message code='UnselectedOperatingObject'/>" + "!");
				    	  }
				          break;
			    };
			});
			//4.监听zigbee节点表格事件
			table.on('tool(nodeTableFilter)', function(obj) { 
				    var zigbeeData = obj.data; // 获取行数据
				    var zbData = eval('('+ JSON.stringify(zigbeeData) +')');
				    if(obj.event == 'openZigbeeBroadcast') {  // 节点状态控制
				    	if(zbData.zigbeeNet == 1) {
					    	var Switch = "打开";
					    	switchSingle(zbData,Switch);	
				    	}else{
				    		layer.alert(zbData.zigbeeName + " <spring:message code='offline.unoperational'/>" + "!",{
				 	    		title: " <spring:message code='Tips'/>",
				 	    		closeBtn: 0,
					 	        btn : "<spring:message code='btn.Close'/>",
				 			    yes : function(index, layero) {
				 		         	 layer.close(index);
				 		        },
				 	    	}); 
				    	}
				    } else if(obj.event == 'closeZigbeeBroadcast') { // 节点状态控制
				    	if(zbData.zigbeeNet == 1){
				    		var Switch = "关闭";
					    	switchSingle(zbData,Switch);	
				    	}else{
				    		layer.alert(zbData.zigbeeName + " <spring:message code='offline.unoperational'/>" + "!",{
				 	    		title: " <spring:message code='Tips'/>",
				 	    		closeBtn: 0,
					 	        btn : "<spring:message code='btn.Close'/>",
				 			    yes : function(index, layero) {
				 		         	 layer.close(index);
				 		        },
				 	    	}); 
				    		/*layer.alert(zbData.zigbeeName + "处于离线状态，不可操作！");*/
				    	}
				    } else if(obj.event == 'dimZigeeBroadcast') { // 节点调光控制
				    	if(zbData.zigbeeNet == 1){
				    		setBrightness(zbData);
				    	}else{
				    		layer.alert(zbData.zigbeeName + " <spring:message code='offline.unoperational'/>" + "!",{
				 	    		title: " <spring:message code='Tips'/>",
				 	    		closeBtn: 0,
					 	        btn : "<spring:message code='btn.Close'/>",
				 			    yes : function(index, layero) {
				 		         	 layer.close(index);
				 		        },
				 	    	}); 
				    	}
				    } else if(obj.event == 'showZigbeeDetail') { // 查看节点信息
				    	showZigbeeDetail(zbData);
				    }  
			 });
			//5监听所有Group表格头部工具栏
			table.on('toolbar(allGroupsTableFilter)', function(obj){
			   	var checkStatus = table.checkStatus(obj.config.id); // 获取选中行状态
		   	    var groupData = checkStatus.data;  // 获取选中行数据
			    switch(obj.event){
			      case 'addGroup':
			    	  addGroup(); // 添加控制组
			      	  break;
			      case 'removeGroup':
			    	  if(groupData.length > 0) {
			    		  var groupAddr = groupData[0].groupid;
				    	  var userid  = groupData[0].userid;
				    	  var groupName  = groupData[0].groupName;
				    	  removeGroup(groupAddr,userid,groupName);  // 删除控制组
			    	   }else{
			    		  layer.msg("<spring:message code='UnselectedOperatingObject'/>" + "!");
			    	   }
			           break;
			      case 'renameGroup':
			    	  if(groupData.length > 0) {
			    		  var groupAddr = groupData[0].groupid;
			    		  var userid  = groupData[0].userid;
			    		  renameGroup(groupAddr,obj,userid); // 控制组重命名
			    	  }else{
			    		  layer.msg("<spring:message code='UnselectedOperatingObject'/>" + "!");
			    	  }
			          break;
			     };
			});	
			//6.监听所有gruop表格事件
			table.on('tool(allGroupsTableFilter)', function(obj) { 
				  var groupData = obj.data; // 获取行数据
				  var groupdata = eval('('+ JSON.stringify(groupData) +')');
			      if(obj.event == 'openGroupBroadcast') {
			        	var Switch = "打开";
				    	switchBroadcastByGroup(groupdata,Switch);  // 控制组下所有节点的状态控制
				  } else if(obj.event == 'closeGroupBroadcast') {
					    var Switch = "关闭";
					    switchBroadcastByGroup(groupdata,Switch);  // 控制组下所有节点的状态控制
				  } else if(obj.event == 'dimGroupBroadcast') {
				    	setBrightnessByGroup(groupdata);   // 控制组下所有节点的灯光调节
			      } else if(obj.event == 'allGroupDetailMessage') {
				    	allGroupDetailMessage(groupdata); // 控制组信息显示
			      }  
			 });
			//7.监听单个控制组表格头部工具栏
			table.on('toolbar(oneGroupsTableFilter)',function(obj) {
				var ogcStatus = table.checkStatus(obj.config.id); // 获取选中行状态
		   	    var ogcsData = ogcStatus.data;  // 获取选中行数据
		   	    switch(obj.event){
		   	    	case 'addZigbee':
		   	    		addZigbeeToGroup(); // 控制组添加节点
		   	    	break;
		   	    	case 'removeZigbee':
		   	    		if(ogcsData.length > 0) {
				    		if(ogcsData[0].zigbeeNet == 1) {
				    			var zigbeeMac = ogcsData[0].zigbeeMac;
						    	removeZigbeeFromGroup(zigbeeMac); // 重要：删除控制组内的节点，此处是删除在线节点
				    		}else{
				    			layer.alert("Node" + " <spring:message code='offline.undelete'/>" + "!",{
					 	    		title: " <spring:message code='Tips'/>",
					 	    		closeBtn: 0,
						 	        btn : "<spring:message code='btn.Close'/>",
					 			    yes : function(index, layero) {
					 		         	 layer.close(index);
					 		        },
					 	    	}); 
				    		}  
				    	}else{
				    		layer.msg("<spring:message code='UnselectedOperatingObject'/>" + "!");
				    	}
		   	    		break;
		   	    	case 'zigbeeTableRenameGroup':
					    zigbeeTableRenameGroup(); // 控制组重命名
		   	    		break;
		   	    }
			});
			//8.监听单个控制组表格内事件
			table.on('tool(oneGroupsTableFilter)', function(obj) { 
				    var ogData = obj.data; // 获取行数据
				    var ogdata = eval('('+ JSON.stringify(ogData) +')');
				    if(obj.event == 'showZigbeeDetail') { 
				    	showZigbeeDetailByGroupTable(ogdata); // 查看控制组内节点的信息
				    	
				    } else if(obj.event == 'openZbBroadcastInGroup'){
				    	if(ogdata.zigbeeNet == 1){ 
					    	var Switch = "打开";
					    	switchSingleInGroup(ogdata,Switch);  // 控制组内的节点的状态控制
				    	}else{
				    		layer.alert(ogdata.zigbeeName + " <spring:message code='offline.unoperational'/>" + "!",{
				 	    		title: " <spring:message code='Tips'/>",
				 	    		closeBtn: 0,
					 	        btn : "<spring:message code='btn.Close'/>",
				 			    yes : function(index, layero) {
				 		         	 layer.close(index);
				 		        },
				 	    	}); 
				    		
				    	}
				    	
				    } else if(obj.event == 'closeZbBroadcastInGroup'){
				    	if(ogdata.zigbeeNet == 1){
					    	var Switch = "关闭";
					    	switchSingleInGroup(ogdata,Switch); // 控制组内的节点的状态控制
				    	}else{
				    		layer.alert(ogdata.zigbeeName + " <spring:message code='offline.unoperational'/>" + "!",{
				 	    		title: " <spring:message code='Tips'/>",
				 	    		closeBtn: 0,
					 	        btn : "<spring:message code='btn.Close'/>",
				 			    yes : function(index, layero) {
				 		         	 layer.close(index);
				 		        },
				 	    	}); 
				    	}
				    	
				    } else if(obj.event == 'dimZbBroadcastInGroup'){
				    	if(ogdata.zigbeeNet == 1){
					    	setSingleBrightnessInGroup(ogdata); // 调节控制组内节点的调光
				    	}else{
				    		layer.alert(ogdata.zigbeeName + " <spring:message code='offline.unoperational'/>" + "!",{
				 	    		title: " <spring:message code='Tips'/>",
				 	    		closeBtn: 0,
					 	        btn : "<spring:message code='btn.Close'/>",
				 			    yes : function(index, layero) {
				 		         	 layer.close(index);
				 		        },
				 	    	}); 
				    	}
				    }
			});
			//9.监听所有ploy表格头部工具栏
			table.on('toolbar(allPloysTableFilter)', function(obj){
			   	var checkStatus = table.checkStatus(obj.config.id); 
		   	    var pcsdata = checkStatus.data; 
			    switch(obj.event){
				      case 'addPloy':
				    	  addPloy(pcsdata); // 添加策略
				      	  break;
				      case 'removePloy':
				    	 if(pcsdata.length > 0){
					    	  removePloy(pcsdata); // 删除策略
				    	  }else{
				    		  layer.msg("<spring:message code='UnselectedOperatingObject'/>" + "!");
				    	  }
				          break;
				      case 'renamePloy':
				    	  if(pcsdata.length > 0){
				    		 renamePloy(pcsdata); // 策略重命名
				    	  }else{
				    		  layer.msg("<spring:message code='UnselectedOperatingObject'/>" + "!");
				    	  }
				          break;
			     };
			 });
			 //10.监听所有ploy表格单元格内事件
			 table.on('tool(allPloysTableFilter)', function(obj) { 
			 	var Data = obj.data; 
			    var ploydata = eval('('+ JSON.stringify(Data) +')');
			    if(obj.event == 'showPloyDetailMessage') {
			    	var ployid = ploydata.id;
			    	showPloyDetail(ployid);  // 查看策略信息
			    }else if(obj.event == 'runPloy') {
				    runPloy(ploydata); // 执行策略
				}else if(obj.event == 'stopPloy') {
				    stopPloy(ploydata); // 停止策略
				} 
			 });
			 //11.监听单个ploy表格工具栏
			 table.on('toolbar(onePloysTableFilter)', function(obj){
			  //var checkStatus = table.checkStatus(obj.config.id); //获取选中行状态
		   	  //var opcsdata = checkStatus.data;  //获取选中行数据 注意：目前该表格内未使用CheckBox
			    switch(obj.event){
			      case 'addBroadcastPlan':
			    	  addBroadcastPlan(); // 添加定时控制
			      	  break;
			      case 'changeGroup':
			    	  changeGroup(); // 重新绑定分组
			          break;
			    };
			  });
			
			//12.监听单个ploy表格单元格内事件
			 table.on('tool(onePloysTableFilter)', function(obj) { 
			 	var Data = obj.data;
				var opdata = eval('('+ JSON.stringify(Data) +')');
				if(obj.event == 'deleteBroadcastPlan') {
				    deleteBroadcastPlan(opdata); // 删除策略内的定时操作
				} 
			 });
		}); 
	   
/*************************************控制主体区域*******************************************/	    
	    if(controlDiv.style.display == "block" && GroupsDiv.style.display == "none" &&  PloysDiv.style.display == "none" &&  UserInfo.style.display == "none"){
 			showAllDevice();
	    }
	    //1.点击水平导航栏，切换主体区域
	   function ControllersHide(){ 
		   controlDiv.style.display = "block";
		   GroupsDiv.style.display = "none";
		   PloysDiv.style.display = "none";
		   UserInfo.style.display = "none";
		   showAllDevice();
	   } 
	   function GroupsHide(){
		   GroupsDiv.style.display = "block";
		   controlDiv.style.display = "none";
		   PloysDiv.style.display = "none";
		   UserInfo.style.display = "none";
		   showAllGroups();
	   }
 	   function PloysHide(){
		   PloysDiv.style.display = "block";
 		   GroupsDiv.style.display = "none";
		   controlDiv.style.display = "none";
		   UserInfo.style.display = "none";
		   showAllPloys();
	   }  
 	   function UserInfoHide(){
		   UserInfo.style.display = "block";
 		   PloysDiv.style.display = "none";
		   GroupsDiv.style.display = "none";
		   controlDiv.style.display = "none";
		   inner1 = "<div class='layui-nav-item'><a href='javascript:;' onclick='changePassword()'><i class='layui-icon layui-icon-home' style='font-size: 30px;'></i> <spring:message code='Nav.PasswordReset' /></a></div>";
		   inner = "<div class='layui-nav-item'><a href='javascript:;' onclick='userInformation()'><i class='layui-icon layui-icon-user' style='font-size: 30px;'></i> <spring:message code='Nav.UserInformation'/></a></div>";
		   leftNavAll.innerHTML = inner;
		   leftNavOne.innerHTML = inner1;
		   userInformation();
	   }
 	   //2.显示所有集控器表格区域以及插入左侧导航栏
 	   function showAllDevice() {
 			leftNavAll.innerHTML = "<a href='javascript:;' onclick='allDeviceTable()'><spring:message code='Nav.AllContorllers'/></a>";
 			inner = " ";
 			for(var i = 0; i < Devices.length; i++){
  				inner = inner + "<li class='layui-nav-item layui-nav-itemed'><a href='javascript:;' onclick='nodeMessage(this.id)' name='dev'></a></li>";
 			}
 			leftNavOne.innerHTML = inner;
 			var aDevice = " ";
 			aDevice = document.getElementsByName("dev");
 			for(var i = 0; i < aDevice.length; i++){
 				aDevice[i].innerHTML = Devices[i].devName;
 				aDevice[i].id = "devNavId-" + Devices[i].devMac;
 			}
 	        allDeviceTable();
	   }
	   //3.显示所有控制组以及插入左侧导航栏
 	   function showAllGroups() {
 			leftNavAll.innerHTML = "<a href='javascript:;'onclick='allGroupsTable()'><spring:message code='Nav.AllGroups'/></a>";
 			inner = " ";
 			for(var i = 0; i < Groups.length; i++){
 				inner = inner + "<li class='layui-nav-item layui-nav-itemed'><a href='javascript:;' onclick='oneGroupMessage(this.id)' name='group'></a></li>";
 			}
 			leftNavOne.innerHTML = inner;
 			var aGroup = " ";
 			aGroup = document.getElementsByName("group");
 			for(var i = 0; i < aGroup.length; i++){
 				aGroup[i].innerHTML = Groups[i].groupName;
 				aGroup[i].id = "groupNavId-" + Groups[i].groupid;
 			}
 			allGroupsTable();
 	   }
	   //4.显示所有策略以及插入左侧导航栏
 	   function showAllPloys(){
 			leftNavAll.innerHTML = "<a href='javascript:;'onclick='allPloysTable()'><spring:message code='Nav.AllPloys'/></a>";
 			inner = " ";
 			for(var i = 0; i < Ploy.length; i++){
 				inner = inner + "<li class='layui-nav-item layui-nav-itemed'><a href='javascript:;' onclick='onePloyMessage(this.id)' name='ploy'></a></li>";
 			}
 			leftNavOne.innerHTML = inner;
 			var aPloy = " ";
 			aPloy = document.getElementsByName("ploy");
 			for(var i = 0; i < aPloy.length; i++) {
 				aPloy[i].innerHTML = Ploy[i].ployName;
 				aPloy[i].id = "ployNavId-" +  Ploy[i].id;
 			}
 			allPloysTable();
 	    }
 		//5.显示用户信息资料
 		function userInformation() {
 			document.getElementById("userMessageDiv").style.display = "block";
 			document.getElementById("passwordResetDiv").style.display = "none";
 			document.getElementById("um-username").innerHTML = 	"<spring:message code='Username'/>" + "：" + User.username;
 	 		document.getElementById("um-email").innerHTML = "<spring:message code='Email'/>"+ "：" + User.email;
 	 		document.getElementById("um-phone").innerHTML = "<spring:message code='Phone'/>" + "：" + User.phone;
 		}
/****************************************主体table数据表格******************************************/
      	//1.所有集控器表格
	  	function allDeviceTable() {
			//alert("所有集控器表格刷新");
		   document.getElementById("nodeDiv").style.display = "none"; //将单个表格数据隐藏
		   document.getElementById("allDeviceDiv").style.display = "block";
		   layui.use(['table','layer','form'], function(){
			  var table = layui.table;
	 	 	  var layer = layui.layer;
	 	 	  var form = layui.form;
	 	 	  var userid = User.id;
	 		  table.render({
	 	   		  elem:'#allDeviceTable'
	 		     ,skin: 'line'
	 	   		 ,url: localhost + '/model/devices.do' + "?userid=" + userid //2数据接口
	 	   		 ,toolbar:'#toolbarControllers' 
	 	   		 ,page: true //3开启分页
	 	   		 ,cols: [[ //4表头
	 	   			  {type:'checkbox', fixed: 'left'}
	 	    		 ,{field: 'devName', title: "<spring:message code='Name'/>", width:'190',}
	 	    		 ,{field: 'devMac', title: "<spring:message code='DeviceMac'/>", width:'190',}
	 	     		 ,{field: 'devNet', title: "<spring:message code='Network'/>", width:'132', sort: true, templet:function(d){
	 	     			 	if(d.devNet == '0') {
	 	     				 	return "<spring:message code='Offline'/>";
	 	     				}else if(d.devNet == '1') {
	 	     					return "<spring:message code='Online'/>";
	 	     				}
	 	     		   	  }
	 	     		   }
	 	      		 ,{field: 'onlineNodes', title: "<spring:message code='NodesOnline'/>", width:'129',}
	 	      		 ,{field: 'offlineNodes', title: "<spring:message code='NodesOffline'/>",width:'129',} 
	 	      		 ,{field: 'zigbeeFinder', title: "<spring:message code='NodesFinder'/>", width:'129',event: 'setZigbeeFinder', templet:function(d){
	 	     			 	if(d.zigbeeFinder == '0'){   //0关闭，1打开   
	 	     				 	return'<span style="color: #009688;">ON</span>';
	 	     				}else if(d.zigbeeFinder == '1'){
	 	     					return'<span style="color:#009688;">OFF</span>';
	 	     				}else{
	 	     					return'<span style="color:#009688;">--</span>';
	 	     				}
	 	     		   	  }
	 	      		 } 
	 	      		 ,{fixed: 'right', title: "<spring:message code='Broadcast'/>", width:'200', toolbar: '#barBroadcast',} 	 
	 	          ]]
	 	 	 	});
		 	});
		   	render;    
		}
       //2.所有组表格 
       function	allGroupsTable(){
    	    //alert("所有分组表格刷新");
	        document.getElementById("oneGroupsDiv").style.display = "none"; 
	        document.getElementById("allGroupsDiv").style.display = "block"; 
	  	    layui.use(['table'], function(){
	  	    	var table = layui.table;
	    		table.render({
	    			elem:'#allGroupsTable'
		    			 ,skin: 'line'
		    	   		 ,url:localhost+'/model/groups.do'
		    	   		 ,where: { //2.接口的其它参数
		    	   			 userid : User.id
		    	   			 }
		    	   		 ,toolbar:'#toolbarGroups'  
		    	   		 ,page: true 
		    	   		 ,cols: [[
		    	   			  {type:'checkbox',fixed: 'left'}
		    	    		 ,{field: 'groupName' , title: "<spring:message code='GroupName'/>",event:'allGroupDetailMessage', 
		    	    			 templet: '<div><span style="color:#009688;">{{d.groupName}}</span></div>'	 
		    	    		 }
		    	     		 ,{field: 'onlineNodes' , title: "<spring:message code='NodesOnline'/>",}
		    	      		 ,{field: 'offlineNodes' , title: "<spring:message code='NodesOffline'/>",}
		    	      		 ,{fixed: 'right', title: "<spring:message code='GroupControl'/>", toolbar: '#barGroupBroadcast',}  
		    	         ]]
	    	 	}); 	 
		    });  
	  		render;
	  }
      
  	 //3.所有策略表格
  	 function allPloysTable() {
  		  //alert("所有策略表格刷新");
		  document.getElementById("onePloyDiv").style.display = "none"; 
		  document.getElementById("allPloyDiv").style.display = "block"; 
	  	  layui.use(['table'], function(){
		    	 var table = layui.table;
		    	 table.render({
		    	   		 elem:'#allPloysTable'
		    	   		 ,skin: 'line'
		    	   		 ,url:localhost+'/model/ploys.do'
		    	   		 ,where: { 
		    	   			 userid : User.id
		    	   			 }
		    	   		 ,toolbar:'#toolbarPloys' 
		    	   		 ,page: true 
		    	   		 ,cols: [[
		    	   			  {type:'checkbox',fixed: 'left'}
		    	    		 ,{field: 'ployName', title: "<spring:message code='PloyName'/>",event:'showPloyDetailMessage', 
		    	    			 templet:'<div><span style="color:#009688;">{{d.ployName}}</span></div>',	 
		    	    		 }
 		    	     		 ,{field: 'bindData', title: "<spring:message code='BindData'/>",
 		    	     			 templet:function(d){
			    	      			 	if(d.bindData == null || d.bindData == "") {
			    	      			 		return '--';
			    	      			 	}else {
			    	      			 		var groupName = '--';
			    	      			 		for(var i in Groups) {
			    	      			 			if(d.bindData == Groups[i].groupid){
			    	      			 				groupName = Groups[i].groupName;
			    	      			 			}
			    	      			 		}
			    	      			 		return groupName;
			    	      			 	}
			    	      			} 
 		    	     		 }
// 		    	     		 ,{field: 'NextTimePoint', title: 'NextTime Point'}
// 		    	     		 ,{field: 'NextCmd', title: 'Next Cmd'}
		    	      		 ,{field: 'status', title: "<spring:message code='CmdStatus'/>",
			    	      			 templet:function(d){
			    	      			 	if(d.status == "1") {
			    	      			 		return "<spring:message code='Running'/>";
			    	      			 	}else if (d.status == "0"){
			    	      			 		return "<spring:message code='Stopped'/>";
			    	      			 	}else if(d.status == undefined || d.status == "" || d.status ==null){
			    	      			 		return '--';
			    	      			 	}
			    	      			} 
	    	      		      }
		    	      		 ,{fixed: 'right', title: "<spring:message code='ExecutionControl'/>",templet:'#temPloyControl',}  
		    	         ]]
		    	 	 });
		    	});  
	  		render;
		}
  	 
  	function nodeMessage(leftNavDevId) {
	    var arr = leftNavDevId.split("-"); 
	    var devMac = arr[1];
	    deviceMacSaveSpace = devMac; // devmac暂存空间
	    document.getElementById("allDeviceDiv").style.display = "none";
	    document.getElementById("nodeDiv").style.display = "block";
	    nodeBelongDevTable();
  	}
  	
  	function nodeBelongDevTable() {
		layui.use(['table'], function(){
			 var table = layui.table;
    		 table.render({
    	   		 elem:'#nodeTable'
    	   		 ,skin: 'line'
    	   		 ,url:localhost+'/model/zigbee.do'
    	   		 ,where: { 
    	   			 devMac: deviceMacSaveSpace
    	   			 }
    	   		 ,toolbar:'#toolbarNodesTable' 
    	   		 ,page: true 
    	   		 ,cols: [[
    	   			  {type:'checkbox',fixed: 'left'}
    	    		 ,{field: 'zigbeeName', title: "<spring:message code='NodeName'/>", event: 'showZigbeeDetail', width:'200',
    	    			 templet: '<div><span style="color:#009688;">{{d.zigbeeName}}</span></div>'
    	    		  }
    	     		 ,{field: 'zigbeeNet', title: "<spring:message code='Network'/>",width:'127', sort: true, templet:function(d) {
    	     			 	if(d.zigbeeNet == '0') {
    	     			 		return "<spring:message code='Offline'/>";
    	     				}else if(d.zigbeeNet == '1') {
    	     					return "<spring:message code='Online'/>";
    	     				}
    	     		   	  }
    	     		 }
    	      		 ,{field: 'zigbeeBright', title: "<spring:message code='Brightness'/>", width:'127',}
    	      		 ,{field: 'zigbeeStatus', title: "<spring:message code='Status'/>", width:'127', templet:function(d) {
    	     			 	if(d.zigbeeStatus == '1') {
    	     				 	//节点点亮;
    	     			 		return "<img style='width:25px;height:25px' src='${pageContext.request.contextPath }/jsp/image/dengpaoON.png'>";
    	     				}
    	     			 	if(d.zigbeeStatus == '0') {
    	     					//节点关闭;
    	     			 		return "<img style='width:25px;height:25px' src='${pageContext.request.contextPath }/jsp/image/dengpaoOFF.png'>";	
    	     				}
    	     			 	
    	     		   	  }
    	      		 }
    	      		 ,{field: 'temperature',width:'160', title: "<spring:message code='Temperature'/>"+'(&#176;C)',
    	      			templet:function(d) {
    	      				// if(d.temperature == null || d.temperature == "" || d.temperature == undefined || (d.temperature)/100 > 100){ //前端屏蔽异常温度
    	      				 if(d.temperature == null || d.temperature == "" || d.temperature == undefined){
    	      					 return '--';
    	      				 }else{
    	      				 	 var temp = d.temperature/100;
    	      				 	 return temp;
    	      				 }
    	      			}
    	      		 }
    	      		 ,{field: 'humidity', width:'158', title: "<spring:message code='Humidity'/>"+'(%)', 
    	      			templet:function(d) {
    	      				// if(d.humidity == null || d.temperature == "" || d.temperature == undefined || (d.humidity/100 > 100)){ //前端屏蔽异常湿度
    	      				 if(d.humidity == null || d.temperature == "" || d.temperature == undefined){
    	      					 return '--';
    	      				 }else{
    	      				 	 var hum = d.humidity/100;
    	      				 	 return hum;
    	      				 }
    	      			}	 
    	      		 }
    	      		 ,{fixed: 'right', title: "<spring:message code='NodeControl'/>", width:'200', toolbar: '#barZigbeeBroadcast',} 
    	         ]]
    	 	 });	 	 
	    });  
		render;
		}
/*	
  		//4.显示单个集控器下节点表格信息
  		function nodeMessage(leftNavDevId) {
		    var arr = leftNavDevId.split("-"); 
		    var devMac = arr[1];
		    document.getElementById("getData").value = devMac;
	    	document.getElementById("allDeviceDiv").style.display = "none";
	    	document.getElementById("nodeDiv").style.display = "block";
			layui.use(['table'], function(){
				 var table = layui.table;
	    		 table.render({
	    	   		 elem:'#nodeTable'
	    	   		 ,skin: 'line'
	    	   		 ,url:localhost+'/model/zigbee.do'
	    	   		 ,where: { 
	    	   			 devMac: devMac
	    	   			 }
	    	   		 ,toolbar:'#toolbarNodesTable' 
	    	   		 ,page: true 
	    	   		 ,cols: [[
	    	   			  {type:'checkbox',fixed: 'left'}
	    	    		 ,{field: 'zigbeeName', title: "<spring:message code='NodeName'/>", event: 'showZigbeeDetail', width:'200',
	    	    			 templet: '<div><span style="color:#009688;">{{d.zigbeeName}}</span></div>'
	    	    		  }
	    	     		 ,{field: 'zigbeeNet', title: "<spring:message code='Network'/>",width:'127', sort: true, templet:function(d) {
	    	     			 	if(d.zigbeeNet == '0') {
	    	     			 		return "<spring:message code='Offline'/>";
	    	     				}else if(d.zigbeeNet == '1') {
	    	     					return "<spring:message code='Online'/>";
	    	     				}
	    	     		   	  }
	    	     		 }
	    	      		 ,{field: 'zigbeeBright', title: "<spring:message code='Brightness'/>", width:'127',}
	    	      		 ,{field: 'zigbeeStatus', title: "<spring:message code='Status'/>", width:'127', templet:function(d) {
	    	     			 	if(d.zigbeeStatus == '1') {
	    	     				 	//节点点亮;
	    	     			 		return "<img style='width:25px;height:25px' src='${pageContext.request.contextPath }/jsp/image/dengpaoON.png'>";
	    	     				}
	    	     			 	if(d.zigbeeStatus == '0') {
	    	     					//节点关闭;
	    	     			 		return "<img style='width:25px;height:25px' src='${pageContext.request.contextPath }/jsp/image/dengpaoOFF.png'>";	
	    	     				}
	    	     			 	
	    	     		   	  }
	    	      		 }
	    	      		 ,{field: 'temperature',width:'150', title: "<spring:message code='Temperature'/>"+'(&#176;C)',
	    	      			templet:function(d) {
	    	      				 if(d.temperature == null || d.temperature == "" || d.temperature == undefined){
	    	      					 return '--';
	    	      				 }else{
	    	      				 	 var temp = d.temperature/100;
	    	      				 	 return temp;
	    	      				 }
	    	      			}
	    	      		 }
	    	      		 ,{field: 'humidity', width:'153', title: "<spring:message code='Humidity'/>"+'(%)', 
	    	      			templet:function(d) {
	    	      				 if(d.humidity == null || d.temperature == "" || d.temperature == undefined){
	    	      					 return '--';
	    	      				 }else{
	    	      				 	 var hum = d.humidity/100;
	    	      				 	 return hum;
	    	      				 }
	    	      			}	 
	    	      		 }
	    	      		 ,{fixed: 'right', title: "<spring:message code='Broadcast'/>", width:'200', toolbar: '#barZigbeeBroadcast',} 
	    	         ]]
	    	 	 });	 	 
		    });  
			render;
  		}*/
  
  		
  		function oneGroupMessage(leftNavGroupId) {
  			var arr = leftNavGroupId.split("-"); 
		    var groupAddr = arr[1];
		    groupAddrSaveSpace = groupAddr; // devmac暂存空间
		    document.getElementById("oneGroupsDiv").style.display = "block";
		    document.getElementById("allGroupsDiv").style.display = "none";
  		    nodeBelongGroupTable();
  	  	}
  		
  		function nodeBelongGroupTable() {	
			layui.use(['table'], function(){
				 var table = layui.table;
	    		 table.render({
	    	   		 elem:'#oneGroupsTable'
	    			 ,skin: 'line' 
	    	   		 ,url:localhost+'/model/groupDetail.do'
	    	   		 ,where:{
	    	   			groupid:groupAddrSaveSpace
	    	   		 }
	    	   		 ,toolbar:'#toolbarOneGroup'
	    	   		 ,page: true 
	    	   		 ,cols: [[ 
	    	   			  {type:'checkbox',fixed: 'left',}
	    	   			 ,{field: 'zigbeeName', title: "<spring:message code='NodeName'/>", event:'showZigbeeDetail',width:'200',
	    	   				 	  templet: '<div><span style="color:#009688;">{{d.zigbeeName}}</span></div>'	 
	    	   			 }
	    	     		 ,{field: 'zigbeeNet', title: "<spring:message code='Network'/>", sort: true, width:'127',
		    	     			templet:function(d) {
		    	     			 	if(d.zigbeeNet == '1') {
		    	     				 	return "<spring:message code='Online'/>";
		    	     				}else if(d.zigbeeNet == '0') {
		    	     					return "<spring:message code='Offline'/>";
		    	     				}
		    	     		   	}
	    	     		 }
	    	      		 ,{field: 'zigbeeBright', title: "<spring:message code='Brightness'/>", width:'127', templet:function(d) {
	    	     					return d.zigbeeBright + '%';
	    	     		   	  }
	    	      		 }
	    	      		 ,{field: 'zigbeeStatus', title: "<spring:message code='Status'/>",  width:'127',
	    	      			 	templet:function(d) {
		    	     			 	if(d.zigbeeStatus == '1') {
		    	     				 	//打开节点
		    	     				 	return "<img style='width:25px;height:25px' src='${pageContext.request.contextPath }/jsp/image/dengpaoON.png'>";
		    	     				}else if(d.zigbeeStatus == '0') {
		    	     					//关闭节点
		    	     					return "<img style='width:25px;height:25px' src='${pageContext.request.contextPath }/jsp/image/dengpaoOFF.png'>";
		    	     				}
	    	     		   	    }
	    	      		 }
	    	      		 ,{field: 'temperature', title: "<spring:message code='Temperature'/>"+'(&#176;C)', width:'160',
		    	      			templet:function(d) {
		    	      				// if(d.temperature == null || d.temperature == "" || d.temperature == undefined || (d.temperature/100) > 100){ //前端屏蔽异常温度
		    	      				 if(d.temperature == null || d.temperature == "" || d.temperature == undefined){
		    	      					 return '--';
		    	      				 }else{
		    	      				 	 var temp = d.temperature/100;
		    	      				 	 return temp;
		    	      				 }
		    	      			}	 
	    	      		 }
	    	      		 ,{field: 'humidity', title:  "<spring:message code='Humidity'/>",  width:'158',
		    	      			templet:function(d) {
		    	      				 //if(d.humidity == null || d.humidity == "" || d.humidity == undefined || (d.humidity/100 > 100)){ //前端屏蔽异常湿度
		    	      				 if(d.humidity == null || d.humidity == "" || d.humidity == undefined){
		    	      					 return '--';
		    	      				 }else{
		    	      				 	 var hum = d.humidity/100;
		    	      				 	 return hum;
		    	      				 }
		    	      			}	 
	    	      		 }
	    	      		 ,{fixed: 'right', title:  "<spring:message code='NodeControl'/>", toolbar: '#barSingleZbBroadcast', width:'200',}
	    	         ]]
	    	 	 });	 	
		    });  
			render;
  		}
  		
  		
/*  		//5.显示组内表格信息
 	    function oneGroupMessage(leftNavGroupId) {
		    var arr = leftNavGroupId.split("-"); 
		    var groupAddr = arr[1];
		    document.getElementById("getData").value = groupAddr;
	    	document.getElementById("oneGroupsDiv").style.display = "block";
		    document.getElementById("allGroupsDiv").style.display = "none";
			layui.use(['table'], function(){
				 var table = layui.table;
	    		 table.render({
	    	   		 elem:'#oneGroupsTable'
	    			 ,skin: 'line' 
	    	   		 ,url:localhost+'/model/groupDetail.do'
	    	   		 ,where:{
	    	   			groupid:groupAddr
	    	   		 }
	    	   		 ,toolbar:'#toolbarOneGroup'
	    	   		 ,page: true 
	    	   		 ,cols: [[ 
	    	   			  {type:'checkbox',fixed: 'left',}
	    	   			 ,{field: 'zigbeeName', title: "<spring:message code='NodeName'/>", event:'showZigbeeDetail',fixed: 'left',width:'200',
	    	   				 	  templet: '<div><span style="color:#009688;">{{d.zigbeeName}}</span></div>'	 
	    	   			 }
	    	     		 ,{field: 'zigbeeNet', title: "<spring:message code='Network'/>", sort: true, width:'140',
		    	     			templet:function(d) {
		    	     			 	if(d.zigbeeNet == '1') {
		    	     				 	return "<spring:message code='Online'/>";
		    	     				}else if(d.zigbeeNet == '0') {
		    	     					return "<spring:message code='Offline'/>";
		    	     				}
		    	     		   	}
	    	     		 }
	    	      		 ,{field: 'zigbeeBright', title: "<spring:message code='Brightness'/>", width:'135', templet:function(d) {
	    	     					return d.zigbeeBright + '%';
	    	     		   	  }
	    	      		 }
	    	      		 ,{field: 'zigbeeStatus', title: "<spring:message code='Status'/>",  width:'130',
	    	      			 	templet:function(d) {
		    	     			 	if(d.zigbeeStatus == '1') {
		    	     				 	//打开节点
		    	     				 	return "<img style='width:25px;height:25px' src='${pageContext.request.contextPath }/jsp/image/dengpaoON.png'>";
		    	     				}else if(d.zigbeeStatus == '0') {
		    	     					//关闭节点
		    	     					return "<img style='width:25px;height:25px' src='${pageContext.request.contextPath }/jsp/image/dengpaoOFF.png'>";
		    	     				}
	    	     		   	    }
	    	      		 }
	    	      		 ,{field: 'temperature', title: "<spring:message code='Temperature'/>"+'(&#176;C)', width:'160',
		    	      			templet:function(d) {
		    	      				 if(d.temperature == null || d.temperature == "" || d.temperature == undefined){
		    	      					 return '--';
		    	      				 }else{
		    	      				 	 var temp = d.temperature/100;
		    	      				 	 return temp;
		    	      				 }
		    	      			}	 
	    	      		 }
	    	      		 ,{field: 'humidity', title:  "<spring:message code='Humidity'/>",  width:'140',
		    	      			templet:function(d) {
		    	      				 if(d.humidity == null || d.humidity == "" || d.humidity == undefined){
		    	      					 return '--';
		    	      				 }else{
		    	      				 	 var hum = d.humidity/100;
		    	      				 	 return hum;
		    	      				 }
		    	      			}	 
	    	      		 }
	    	      		 ,{fixed: 'right', title:  "<spring:message code='Broadcast'/>", toolbar: '#barSingleZbBroadcast', width:'180',}
	    	         ]]
	    	 	 });	 	
		    });  
			render;
  		}*/
    
  		
  		
  		function onePloyMessage(leftNavPloyId) {
  			var arr = leftNavPloyId.split("-"); 
		    var ployid = arr[1];
		    ployidSaveSpace = ployid;
		    document.getElementById("allPloyDiv").style.display = "none";
	    	document.getElementById("onePloyDiv").style.display = "block";
  		    ployOperateTable();
  	  	}
  		
  		
  		function ployOperateTable() {
			layui.use(['table'], function(){
				 var table = layui.table;
	    		 table.render({
	    	   		 elem:'#onePloysTable'
	    	   	     ,skin: 'line' 
	    	   		 ,url:localhost+'/model/ployOperate.do'
	    	   		 ,where:{
	    	   			 id:ployidSaveSpace
	    	   		 }
	    	   		,toolbar:'#toolbarOnePloy'
	    	   		 ,page: true 
	    	   		 ,cols: [[
	    	   		      {type:'checkbox',fixed: 'left'}
	    	   			 ,{field: 'Time Point', title: new Date().toTimeString().substring(8),sort: true, width:"280",
		    	   				 templet:function(d) {
		    	   				    //以本地时区显示时间
		    	   				 	var offset = new Date().getTimezoneOffset();
		    	   				 	var getlocaltime = getLocalTime(d.hours,d.minutes,offset);
		    	   				 	var localHours = getlocaltime.localhours;
		    	   				 	var localMinutes = getlocaltime.localminutes;
		    	   				    var hour = localHours < 10 ? "0" + localHours : localHours;
		    	   				    var minute = localMinutes < 10 ? "0" + localMinutes : localMinutes;
		    	   				    return hour +':'+ minute;
		    	   			 	  }
	    	   			  }
	    	     		 ,{field: 'Cmd Type', title:  "<spring:message code='CmdType'/>",width:"269",
		    	     			templet:function(d) {
		    	      				 if(d.operateType == 1){
		    	      					 return "<spring:message code='Switch'/>";
		    	      				 }if(d.operateType == 2){
		    	      				 	 return "<spring:message code='Dim'/>";
		    	      				 }
		    	      			}		 
	    	     		 }
	    	      		 ,{field: 'Cmd param', title: "<spring:message code='CmdParam'/>",width:"269",
	    	      			 	templet:function(d) {
		    	      				 if(d.operateParam == 1){
		    	      					 return "<spring:message code='ON'/>";
		    	      				 }else if(d.operateParam == 0){
		    	      				 	 return "<spring:message code='OFF'/>";
		    	      				 }else{
		    	      					return d.operateParam;
		    	      				 }
		    	      			}	
	    	     		 }
	    	      		 ,{fixed: 'right', title: "<spring:message code='Delete'/>", toolbar: '#barDeleteBroadcast',width:"280",}
	    	         ]]
	    	 	 });	 	 
		    });  
			render;
	  }
/*	   //6.显示单个策略表格信息
	   function onePloyMessage(leftNavPloyId) {
		    var arr = leftNavPloyId.split("-"); 
		    var ployid = arr[1];	    
		    document.getElementById("getData").value = ployid;
		    document.getElementById("allPloyDiv").style.display = "none";
	    	document.getElementById("onePloyDiv").style.display = "block";
			layui.use(['table'], function(){
				 var table = layui.table;
	    		 table.render({
	    	   		 elem:'#onePloysTable'
	    	   	     ,skin: 'line' 
	    	   		 ,url:localhost+'/model/ployOperate.do'
	    	   		 ,where:{
	    	   			 id:ployid
	    	   		 }
	    	   		,toolbar:'#toolbarOnePloy'
	    	   		 ,page: true 
	    	   		 ,cols: [[
	    	   		      {type:'checkbox',fixed: 'left'}
	    	   			 ,{field: 'Time Point', title: new Date().toTimeString().substring(8),sort: true, 
		    	   				 templet:function(d) {
		    	   				    //以本地时区显示时间
		    	   				 	var offset = new Date().getTimezoneOffset();
		    	   				 	var getlocaltime = getLocalTime(d.hours,d.minutes,offset);
		    	   				 	var localHours = getlocaltime.localhours;
		    	   				 	var localMinutes = getlocaltime.localminutes;
		    	   				    var hour = localHours < 10 ? "0" + localHours : localHours;
		    	   				    var minute = localMinutes < 10 ? "0" + localMinutes : localMinutes;
		    	   				    return hour +':'+ minute;
		    	   			 	  }
	    	   			  }
	    	     		 ,{field: 'Cmd Type', title:  "<spring:message code='CmdType'/>",
		    	     			templet:function(d) {
		    	      				 if(d.operateType == 1){
		    	      					 return "<spring:message code='Switch'/>";
		    	      				 }if(d.operateType == 2){
		    	      				 	 return "<spring:message code='Dim'/>";
		    	      				 }
		    	      			}		 
	    	     		 }
	    	      		 ,{field: 'Cmd param', title: "<spring:message code='CmdParam'/>",
	    	      			 	templet:function(d) {
		    	      				 if(d.operateParam == 1){
		    	      					 return "<spring:message code='ON'/>";
		    	      				 }else if(d.operateParam == 0){
		    	      				 	 return "<spring:message code='OFF'/>";
		    	      				 }else{
		    	      					return d.operateParam;
		    	      				 }
		    	      			}	
	    	     		 }
	    	      		 ,{fixed: 'right', title: "<spring:message code='Delete'/>", toolbar: '#barDeleteBroadcast',}
	    	         ]]
	    	 	 });	 	 
		    });  
			render;
	  }
 */
	   
/********************************allDeviceTable表格内的函数事件***************************************/  
  	//1.添加集控器
 	 function addDev(){
  	     layui.use(['layer','table'], function(){
	   	 	 var layer = layui.layer;
	   	 	 var table = layui.table;
	   	 	 var devMac = "";
	   	 	 var userid = User.id;
	   	 	 inner = "<input type='text' id='addDevInput' placeholder='<spring:message code='PleaseEnter'/>' autocomplete='off' class='layui-input'>";
	  	  	 layer.open({
	  			 area : [ '600px', '150px' ],
	  			 btnAlign : 'l',
	  			 resize : false,
	  			 closeBtn : 1,
	  			 type : 1,
	  			// title:"Please enter the mac address of the controller: ",
	  			 title:"<spring:message code='enterDevMac'/>",
	  			 content : inner,
	  		     btn : "<spring:message code='Confirm'/>",
	  		     yes : function(index, layero) {
	  				    devMac = document.getElementById("addDevInput").value;
	  					if(devMac != ""){
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
		  			            	 /* layer.msg('Added successfully!', function(){*/
		  			            	  layer.msg("<spring:message code='Addedsuccessfully'/>"+"!", function(){
		  			            	  });
			  			              table.reload('allDeviceTable', {
			  		            	      url:localhost+'/model/devices.do'
			  		            	      ,where:{ 
			  		            	    	   userid:userid 
			  		            		   }	 
			  		            	   });
		  			            	    
		  			              }else{
		  			            	 switch(data.error){
	  							      case 'The device is not connected to the server!':
	  							    	  layer.msg("<spring:message code='devUnconnectedServer'/>" + "!");
	  							      	  break;
	  							      case 'User does not exist!':
	  							    	  layer.msg("<spring:message code='userUnexist'/>" + "!");
	  							          break;
	  							      case 'Failed to write to database!':
	  							    	  layer.msg("<spring:message code='failedWriteDatabase'/>" + "!");
	  							          break;
	  							     case 'The device has been added by other user':
	  							    	layer.msg("<spring:message code='PER.devAddByOther'/>" + "!");
	  							          break;
	  						     		};
		  			              }
		  			              
		  			            },
		  			            error: function() {
		  			            	 layer.msg("<spring:message code='Connectionfailure'/>" + "!");
		  			                 
		  			            }
		  			          });
	  					}else{
	  						layer.msg("<spring:message code='enterDevMac'/>" + "!");
	  					}
	  					
	  					//最后清除输入框内容
	  					document.getElementById("addDevInput").value = "";
	  					
	  				 },
	  			 cancel : function() {
	  				
	  			 }
	  		});
  	    });
     }
  
  	 //2.删除集控器
     function removeDev(devMac,userid,devName){
    	 layer.confirm("<spring:message code='Note'/>" + "：" + "<spring:message code='deleteAsk'/>" + "&nbsp;" + devName + '?</br>' + "<spring:message code='PER.deleteDev'/>"
  	        ,{  
  	        	title:"<spring:message code='Warnning'/>",
  	        	btn: ['<spring:message code='Confirm'/>','<spring:message code='Cancel'/>'],
  	        	btn1: function(){
  	        	  //确认按钮提交删除
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
			              if (data.error == null || data.error == "" || data.error == undefined) {
			            	  layer.msg("<spring:message code='successfullyDeleted'/>"+"!");
			            	  layui.use('table',function(){
			            		  var table = layui.table;
	  			            	  table.reload('allDeviceTable', { 
		  		            		    url:localhost+'/model/devices.do'
		  		            		   ,where:{ 
		  		            			   userid:userid 
		  		            			   }
		  		            	  });
			            	  });  
			              } else {
	  			              switch(data.error){
							      case 'The device is not connected to the server!':
							    	  layer.msg("<spring:message code='devUnconnectedServer'/>" + "!");
							      	  break;
							      case 'User does not exist!':
							    	  layer.msg("<spring:message code='userUnexist'/>" + "!");
							          break;
							      case 'Failed to write to database!':
							    	  layer.msg("<spring:message code='failedWriteDatabase'/>" + "!");
							          break;
							     case 'Insufficient permissions!':
							    	  layer.msg("<spring:message code='insufficientPermissions'/>" + "!");
							          break;
						     	};
			              }
			            },
			            
			            error: function() {  
			            	layer.msg("<spring:message code='Connectionfailure'/>" + "!");	
			            }
			    	}); 
  	        	  
  	        	}
             	,btn2: function(){
                    //取消按钮取消删除操作
                }
        	 });
     }

	 //3.集控器重命名
	 function renameDev(devMac){
	 	  layui.use(['layer','table'], function(){
	 		 var layer = layui.layer;
	 		 var table = layui.table;
 	 	 	 inner = "<input type='text' id='renameDevInput' placeholder='<spring:message code='PleaseEnter'/>'  autocomplete='off' class='layui-input'>";
 		  	 layer.open({
 				 area : [ '600px', '150px' ],
 				 btnAlign : 'l',
 				 resize : false,
 				 closeBtn : 1,
 				 type : 1,
 				 title:"<spring:message code='PleaseEnterDevName'/>",
 				 content : inner,
 			     btn : "<spring:message code='Confirm'/>",
 			     yes : function(index, layero) {
 						var newName = document.getElementById("renameDevInput").value;
 						if(newName != null && newName != " " && newName != "" && newName.length <=16){
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
				                       var data = eval('(' + datasource + ')');
				                       if (data.error == null || data.error == "" || data.error == undefined) {
				            	             layer.msg("<spring:message code='successfullyModified'/>"+"!", function(){      
				            	             });
				            	             table.reload('allDeviceTable', {  
					  		            		    url:localhost+'/model/devices.do'
					  		            		   ,where:{ 
					  		            			   userid:User.id 
					  		            			   }
					  		            		});
				            	             
				                       } else {
				                    	   switch(data.error){
										      case 'The device is not connected to the server!':
										    	  layer.msg("<spring:message code='devUnconnectedServer'/>" + "!");
										      	  break;
										      case 'Failed to write to database!':
										    	  layer.msg("<spring:message code='failedWriteDatabase'/>" + "!");
										          break;
									     	};
				                    	  
				              	      }   
				                 },
				                 error: function() {
				            	     layer.msg("<spring:message code='Connectionfailure'/>" + "!", function(){
				            		            
				            		   }); 
				                }
				             });
 						 }else if (newName == " " || newName == "") {//点击取消返回的是null
 							  layer.msg("<spring:message code='NewNameUnempty'/>");
 				         } else if (newName.length > 16){
 				        	  layer.msg("<spring:message code='NameLengthOver16Words'/>");
 				         }
 						
 						//最后清除输入框
 						document.getElementById("renameDevInput").value = "";
 					
 					  },
 				  cancel : function() {
 					
 				  }
 			 });	 	 
	 	  }); 	  
	   }
	   
	   //4.集控器广播开关操作
	   function broadcastSwitch(data,Switch) {
		  var devMac = data.devMac;
		  if(data.zigbeeFinder == 0){
			  layui.use(['table','layer'], function(){
	 	 	 	 var layer = layui.layer;
	 	 	 	 var table = layui.table;
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
				          if (data.error == null || data.error == "" || data.error == undefined) {
				        	layer.msg("<spring:message code='commandSentSuccessfully'/>"+"!", function(){
				        			  
				           	  });
				        	setTimeout(function(){
				        		table.reload('allDeviceTable', { 
		  		            	    url:localhost+'/model/devices.do'
		  		           		   ,where:{ 
		  		           			   userid:User.id
		  		           			   }
		  		           	  });
					          	  },3000);
				        	
				          }else{ 
				        	 switch(data.error){
							     case "The device is offline or you haven't added the device yet!":
							    	layer.msg("<spring:message code='devOfflineTips'/>" + "!");
							     break;
					     	};  
				          }
				        },
				        error: function() {
				        	layer.msg("<spring:message code='Connectionfailure'/>" + "!", function(){
			        			  //doSomething
				            	  });
				        }
				      });
			 	});
			  
			  
		  }else{
			   layer.alert("<spring:message code='zigbeeFinding.unoperational'/>" + "!",{
	    			title: " <spring:message code='Tips'/>",
	 	    		closeBtn: 0,
		 	        btn : "<spring:message code='btn.Close'/>",
	 			    yes : function(index, layero) {
	 		         	 layer.close(index);
	 		        },
	 	    	});   
		   }
	   }
	   
	  //5.设置集控器下所有zigbee节点的亮度
	  function setAllBrightness(data) {
		  var devMac = data.devMac;
		  if(data.zigbeeFinder == 0){
		 	  layui.use(['table','layer'], function(){
		 	 	 	 var layer = layui.layer;
		 	 	 	 var table = layui.table;
		 	 	 	 inner = "<input type='text' id='setDevBrightnessInput' placeholder='<spring:message code='PleaseEnter'/>'  autocomplete='off' class='layui-input'>";
		 		  	 layer.open({
		 				 area : [ '600px', '150px' ],
		 				 btnAlign : 'l',
		 				 resize : false,
		 				 closeBtn : 1,
		 				 type : 1,
		 				 title:"<spring:message code='enterInteger'/>"+"1~100",
		 				 content : inner,
		 				 btn : "<spring:message code='Confirm'/>",
		 			     yes : function(index, layero) {
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
		 				                if (data.error == null || data.error == "" || data.error == undefined) {
		 				                  	layer.msg("<spring:message code='commandSentSuccessfully'/>");
		 				                	
		 				                }else{
		 				                	switch(data.error){
		 								      case "The device is offline or you haven't added the device yet!":
		 								    	  layer.msg("<spring:message code='devOfflineTips'/>" + "!");
		 								      break;
		 						     		};
		 				                }
		 				              },
		 				              error: function() {
		 				            	 layer.msg("<spring:message code='Connectionfailure'/>"+"!");
		 				              }
		 				            });
		 				          }else{
		 				        	  layer.msg("<spring:message code='error'/>"+"："+"<spring:message code='enterInteger'/>"+"1~100");
		 				          }
		 						document.getElementById('setDevBrightnessInput').value = "";
		 					 },
		 				 cancel : function() {
		
		 				 }
		 			 });
		 		  });
		 	  
		  }else{
			   layer.alert("<spring:message code='zigbeeFinding.unoperational'/>" + "!",{
	    			title: " <spring:message code='Tips'/>",
	 	    		closeBtn: 0,
		 	        btn : "<spring:message code='btn.Close'/>",
	 			    yes : function(index, layero) {
	 		         	 layer.close(index);
	 		        },
	 	    	});   
		   }
	 	}
	  
	   //6.开启允许节点查询
	   function setZigbeeFinder(data,obj) {
		  var devMac = data.devMac;
		  var timeCmd = "";
		  layui.use(['layer','form'], function(){
 	 	 	 var layer = layui.layer;
 	 	 	 var form = layui.form;
 		  	 layer.open({
 				 area : [ '350px', '250px'],
 				 btnAlign : 'l',
 				 resize : false,
 				 closeBtn : 1,
 				 type : 1,
 				 title:"<spring:message code='PER.zbFinderSelectLable'/>",
 				 content:$('#setZigbeeFinderWindow'),
 				 success:function() {
		    			form.render(null,'form4'); 
		    			form.on('select(zigbeeFinderSelectFilter)', function(data) {
							 timeCmd = data.value;
		    			});			 
		    	 },
		    	 btn : "<spring:message code='Confirm'/>",
 			     yes : function(index, layero) {
 			    	 if(timeCmd != ""){
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
	 			              if (data.error == null || data.error == "" || data.error == undefined) {
	 			                  layer.msg("<spring:message code='commandSentSuccessfully'/>");
	 			                 //注意：更新zigbeefinder选中的时间；有待确认
	 			                 /* obj.update({
	 			                	 zigbeeFinder: timeCmd
	 			                  });*/
	 			              
	 			              } else {
	 			            	switch(data.error){
							      case "The device is offline or you haven't added the device yet!":
							    	  layer.msg("<spring:message code='devOfflineTips'/>" + "!");
							      break;
					     		};
	 			              }
	 			            },
	 			            error: function() {
	 			            	 layer.msg("<spring:message code='Connectionfailure'/>"+"!");
	 			            }
	 			          });
 			    	 }else{
 			    		 layer.msg("<spring:message code='PER.zbFinderTime'/>"+"!");
 			    	 }
 				 },
 				 cancel : function() {
 					
 				 }
 			 });
 		  });
	  }
	
	   
/***********************************nodeTable表格内的函数事件***************************************/    
	//1.删除zigbee节点，节点处于离线状态时才可进行删除操作
	 function removeOfflineZigbee(zigbeeMac,userid,zigbeeName,devMac) {
		 layer.confirm("<spring:message code='deleteAsk'/>" + "&nbsp;" + zigbeeName +"?"
		  	   ,{  
		  	    title:"<spring:message code='Warnning'/>",
		      	btn: ['<spring:message code='Confirm'/>','<spring:message code='Cancel'/>'],
	        	btn1: function(){
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
				          if (data.error == null || data.error == "" || data.error == undefined) {
				        	  layer.msg("<spring:message code='commandSentSuccessfully'/>" + "!", function(index){
				        		  layui.use('table',function(){
	  			            		 var table = layui.table;
	  			            	 	 table.reload('nodeTable', {
			  			        		   url:localhost+'/model/zigbee.do'
			  			           		  ,where: {
			  			           			  devMac: devMac
			  			           			  }
			  			            		});
	  			            		});		
	  			              });   
				          } else {
				        	  switch(data.error){
							      case 'This node does not exist!':
							    	  layer.msg("<spring:message code='nodeUnexist'/>"+"!");
							      	  break;
							      case 'Parameter error!':
							    	  layer.msg("<spring:message code='parameterError'/>"+"!");
							          break;
					     	  };
				          }
				        },
				        error: function() {
				        	layer.msg("<spring:message code='Connectionfailure'/>"+"!");
				        }
				  }); 	
	        	
	         }
         	,btn2: function(){
                //取消按钮取消删除操作
            }
    	 });    		 
	 }
	 
	 //2.zigbee节点重命名   
	 function renameZigbee(zigbeeMac,obj,devMac){
		 inner = "<input type='text' id='renameZigbeeInput' placeholder='<spring:message code='PleaseEnter'/>'  autocomplete='off' class='layui-input'>";
		 layer.open({
				 area : [ '600px', '150px' ],
				 btnAlign : 'l',
				 resize : false,
				 closeBtn : 1,
				 type : 1,
				 title:"<spring:message code='newZbname'/>",
				 content : inner,
			     btn : "<spring:message code='Confirm'/>",
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
					              var data = eval('(' + datasource + ')');
					              if (data.error == null || data.error == "" || data.error == undefined) {//未出错
					            	  layer.msg("<spring:message code='successfullyModified'/>"+"!", function(){
					            	  });
					            	  layui.use('table',function() {
		  			            			var table = layui.table;
		  			            			table.reload('nodeTable', {
				  			            		   url:localhost+'/model/zigbee.do'
				  			            		  ,where: {devMac: devMac} //设定异步数据接口的额外参数
				  			            		});
		  			            		});
					              
					              } else {
					            		 switch(data.error){
										      case 'This node does not exist!':
										    	  layer.msg("<spring:message code='nodeUnexist'/>"+"!");
										      	  break;
										      case 'Failed to write to database!':
										    	  layer.msg("<spring:message code='failedWriteDatabase'/>" + "!");
										          break;
								     	 };
					              	}
					            },
					            error: function() {
					            	layer.msg("<spring:message code='Connectionfailure'/>" + "!");
					            }
					          });
						}else if (newName == "") {//点击取消返回的是null
							 layer.msg("<spring:message code='NewNameUnempty'/>" + "!");
				        } else if (newName.length > 16) {
				             layer.msg("<spring:message code='NameLengthOver16Words'/>" + "!");
				        }
						//最后清除input状态
						document.getElementById("renameZigbeeInput").value = "";
					 },
				 cancel : function() {

				 }
			 });
	 }
		 
		 
	 //3.显示zigbee节点详细信息
	 function showZigbeeDetail(zbData) {
		    var groupPair = "";
		    var groupName = null;
		    for(var i in GroupPair){
		    	if(zbData.zigbeeMac == GroupPair[i].zigbeeMac){
		    		groupPair = GroupPair[i];
		    	}
		    }
		    for(var j in Groups){
		    	if(groupPair.groupid == Groups[j].groupid){
		    		groupName = Groups[j].groupName;
		    	}
		    }
		
		    var tempString = "<br/>"+ "&nbsp;&nbsp;<spring:message code='nodeName'/>"+"："+ zbData.zigbeeName +"<br/>"
			 + "&nbsp;&nbsp;<spring:message code='macAddress'/>" + "：" + zbData.zigbeeMac +"<br/>"
			 + "&nbsp;&nbsp;<spring:message code='controller'/>" + "："+ zbData.devMac + "<br/>"
			 + "&nbsp;&nbsp;<spring:message code='network'/>" + "：" + zbData.zigbeeNet + "<br/>" 
			 + "&nbsp;&nbsp;<spring:message code='status'/>" + "：" + zbData.zigbeeStatus +"<br/>"
			 + "&nbsp;&nbsp;<spring:message code='brightness'/>" + "：" + zbData.zigbeeBright + "<br/>"
			 + "&nbsp;&nbsp;<spring:message code='groups'/>" + "：" + groupName + "<br/>"
			 + "&nbsp;&nbsp;<spring:message code='ratedPower'/>" + "：" + zbData.power +"W"
			 if (zbData.type == 1) {
			        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='deviceType'/>" + "：" + "<spring:message code='sodiumLamp'/>";
			        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='dimmingRange'/>" + "：" + "50 - 100";
			      } else if (zbData.type == 2) {
			        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='deviceType'/>" + "：" + "<spring:message code='metalHalideLamp'/>";
			        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='dimmingRange'/>" + "：" + "50 - 100";
			      } else if (zbData.type == 3) {
			        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='deviceType'/>" + "：" + "<spring:message code='ledLighting'/>";
			        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='dimmingRange'/>" + "：" + "1 - 100";
			      } else if (zbData.type == 17) {
			        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='deviceType'/>" + "：" + "<spring:message code='sodiumLamp'/>" + "SHT10";
			        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='dimmingRange'/>" + "：" + "50 - 100";
			      } else if (zbData.type == 18) {
			        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='deviceType'/>" + "：" + "<spring:message code='metalHalideLamp'/>" + "SHT10";
			        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='dimmingRange'/>" + "：" + "50 - 100";
			      } else if (zbData.type == 19) {
			        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='deviceType'/>" + "：" + "<spring:message code='ledLighting'/>" + "SHT10";
			        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='dimmingRange'/>" + "：" + "1 - 100";
			      } else if (zbData.type == 33) {
			        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='deviceType'/>" + "：" + "SHT10";
			        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='temperatureRange'/>" + "：" + "-50°C - 125°C";
			      } else {
			        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='deviceType'/>" + "：" + "<spring:message code='unknown'/>";
			        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='dimmingRange'/>" + "：" + "50 - 100";
			      }
			 layer.open({
				 area : [ '300px', '300px' ],
				 btnAlign : 'l',
				 resize : false,
				 closeBtn : 1,
				 type : 1,
				 title:"<spring:message code='detailMessage'/>",
				 content : tempString,
				 cancel : function(){
				 }
			 });
	 }
	 
	 //4.节点表格单灯调光开关 
	 function switchSingle(zbData,Switch){
		 var zbFinder = 0;
		 for(var index = 0; index < DevAttrArr.length; index++){
			 if(DevAttrArr[index].devMac == zbData.devMac){
				 zbFinder = DevAttrArr[index].zigbeeFinder;
			 }
		 }
		 // 当前节点的集控器处于在发现节点的过程中，不进行开、关、调光操作
		 if(zbFinder == 0){
			 $.ajax({
			        type:"post",
			        url:localhost + "/user/switchZigbee.do",
			        data:{
			          zigbeeMac:zbData.zigbeeMac,
			          cmd:Switch
			        },
			        async : true,
			        datatype: "json",
			        success:function(datasource, textStatus, jqXHR) {
			          var returndata = eval('(' + datasource + ')');
			          if (returndata.error == null || returndata.error == "" || returndata.error == undefined) {
			        	  layer.msg("<spring:message code='commandSentSuccessfully'/>");
			             //重要：状态更改完成后由于集控器反馈到服务器需要时间，故添加延时3秒钟重载表格；重载表格，表格数据未发生改变
			             setTimeout(function(){
			            	 layui.use('table',function() {
			            			var table = layui.table;	
			            			table.reload('nodeTable', {
					            		   url:localhost+'/model/zigbee.do'
					            		  ,where: {devMac: zbData.devMac} //设定异步数据接口的额外参数
					            		});
			            		
			            		});
			            	 },3000);	
			          }else{
			        	  switch(returndata.error){
					      case 'Node does not exist!':
					    	  layer.msg("<spring:message code='nodeUnexist'/>"+"!");
					      	  break;
					      case 'Unable to connect to the controller where the node is located!':
					    	  layer.msg("<spring:message code='unConnectDev'/>"+"!");
					          break;
				     		};
			          }
			        },
			        error: function() {
			        	layer.msg("<spring:message code='Connectionfailure'/>"+"!");
			        }
			      });
			 
			 
		 }else{
			   layer.alert("<spring:message code='zigbeeFinding.unoperational'/>" + "!",{
	    			title: " <spring:message code='Tips'/>",
	 	    		closeBtn: 0,
		 	        btn : "<spring:message code='btn.Close'/>",
	 			    yes : function(index, layero) {
	 		         	 layer.close(index);
	 		        },
	 	    	});   
		   }
 		
	 }
	  
	 //5.节点表格的节点单灯调光 
	 function setBrightness(zbData) {
		 var zigbeeMac = zbData.zigbeeMac;
		 var zigbee = new Zigbee();
		 var lowRange = 1;
		 var newBrightness = "";
		 var zbFinder = 0;
		 //var highRange = 100;
		 //1.获取节点的调光范围
	 	 for(var i = 0; i < zigbeeSet.length; i++){
	 		 if(zigbeeSet[i].mac == zigbeeMac){
	 			 zigbee = zigbeeSet[i]; 
	 		 }
	 	 }
	 	 if(zigbee.type == 1 || zigbee.type == 2 || zigbee.type == 17 || zigbee.type == 18 || zigbee.type == null || zigbee.type == ""){
	 		lowRange = 50;
	 	 }else if(zigbee.type == 33){
	 		lowRange = -50;
	 		//highRange = 125;
	 	 }
	 	 
	 	 //2.判断集控器是否在发现节点；
		 for(var index = 0; index < DevAttrArr.length; index++){
			 if(DevAttrArr[index].devMac == zbData.devMac){
				 zbFinder = DevAttrArr[index].zigbeeFinder;
			 }
		 }
		 //3当前节点的集控器处于在发现节点的过程中，不进行开、关、调光操作
		 if(zbFinder == 0){
		 	 inner = "<input type='text' id='zigbeeBrightnessInput' placeholder='<spring:message code='PleaseEnter'/>'  autocomplete='off' class='layui-input'>";
			  	 layer.open({
					 area : [ '600px', '150px' ],
					 btnAlign : 'l',
					 resize : false,
					 closeBtn : 1,
					 type : 1,
					 title:"<spring:message code='enterInteger'/>" + lowRange +  "~100",
					 content : inner,
					 btn : "<spring:message code='Confirm'/>",
				     yes : function(index, layero) {
						    newBrightness = document.getElementById("zigbeeBrightnessInput").value;
							if (newBrightness != null) {
						        if (!Number.isNaN(newBrightness) && newBrightness >= lowRange && newBrightness <= 100 && newBrightness.indexOf(".") == -1) {
		 				            $.ajax({
			 				              type:"post",
			 				              url:localhost + "/user/setBrightness.do",
			 				              data:{
			 				                zigbeeMac:zigbeeMac,
			 				                brightness:newBrightness
			 				              },
			 				              async : true,
			 				              datatype: "json",
			 				              success:function(datasource, textStatus, jqXHR) {
			 				                var data = eval('(' + datasource + ')');
			 				                if (data.error == null || data.error == "" || data.error == undefined) {
			 				                	layer.msg("<spring:message code='commandSentSuccessfully'/>");
			 				                	//重要：状态更改完成后由于集控器反馈到服务器需要时间，故添加延时3秒钟重载表格；重载表格，表格数据未发生改变
			 						             setTimeout(function(){
			 						            	 layui.use('table',function() {
			 						            			var table = layui.table;	
			 						            			table.reload('nodeTable', {
			 								            		   url:localhost+'/model/zigbee.do'
			 								            		  ,where: {
			 								            			  devMac: zbData.devMac
			 								            			  } 
			 								            		});
			 						            		
			 						            		});
			 						            	 },2000);
			 				                	
			 				  
			 				                } else {
			 				                	switch(data.error){
			 								      case 'Instructions that already have the same address are being executed':
			 								    	  layer.msg("<spring:message code='sameInstructions'/>"+"!");
			 								      	  break;
			 								      case 'Unable to connect to the controller where the node is located!':
			 								    	  layer.msg("<spring:message code='unConnectDev'/>"+"!");
			 								          break;
			 							     		};
			 				                }
			 				              },
			 				              error: function() {
			 				            	 layer.msg("<spring:message code='Connectionfailure'/>"+"!");
			 				              }
		 				             });
		 				            
		 				            
					          }else{
					        	  layer.msg("<spring:message code='error'/>" + "：" + "<spring:message code='enterInteger'/>" + lowRange + "~100");
					          }
						      //最后清除输入框内容
						      document.getElementById('zigbeeBrightnessInput').value = "";
						    }
						 },
					 cancel : function() {
						
					 }
				 });
			  	 
			  	 
			  	 
		 }else{
			   layer.alert("<spring:message code='zigbeeFinding.unoperational'/>" + "!",{
	    			title: " <spring:message code='Tips'/>",
	 	    		closeBtn: 0,
		 	        btn : "<spring:message code='btn.Close'/>",
	 			    yes : function(index, layero) {
	 		         	 layer.close(index);
	 		        },
	 	    	});   
		   }
	 }
	 
	 
/**********************************allGroupTable控制组表格相关操作***********************************/    
	  //1.添加控制组
	  function addGroup() {
		 var userid = User.id;
		 var newGroupName = "";
		 inner = "<input type='text' id='addGroupInput' placeholder='<spring:message code='PleaseEnter'/>' autocomplete='off' class='layui-input'>";
  	  	 layer.open({
  			 area : [ '600px', '150px' ],
  			 btnAlign : 'l',
  			 resize : false,
  			 closeBtn : 1,
  			 type : 1,
  			 title:"<spring:message code='enterGroupName'/>",
  			 content : inner,
  		     btn : "<spring:message code='Confirm'/>",
  		     yes : function(index, layero) {
  				    newGroupName = document.getElementById("addGroupInput").value;
  					if (newGroupName != null && newGroupName != "" && newGroupName.length <= 16) {
  						for (var index in Groups) {
	  			            if (Groups[index].groupName == newGroupName) {
	  			            	layer.msg("<spring:message code='PER.addGroupTip1'/>");
	  			                return;
	  			            }
  			          	}
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
	  			              var data = eval('(' + datasource + ')');
	  			              if (data.error == null || data.error == "" || data.error == undefined) {
	  			            	  layer.msg("<spring:message code='Addedsuccessfully'/>");
	  			            	  layui.use('table',function() {
	  			            		 var table = layui.table;
			             			 table.reload('allGroupsTable', {
			  		            		   url:localhost+'/model/groups.do'
			  		            		  ,where: {
			  		            			  userid: userid
			  		            		   }
			  		            		});
			             		   });
	  			              }else{
	  			            	  switch(data.error){
							         case 'Failed to write to database!':
							    	    layer.msg("<spring:message code='failedWriteDatabase'/>" + "!");
							      	 break;
						     	};
	  			              }
	  			            },
	  			            error: function() {
	  			            	alert("出错了");
	  			            	//layer.msg("<spring:message code='Connectionfailure'/>"+"!");
	  			            }
	  			          });
  					} else if (newGroupName == "") {//点击取消返回的是null
  						layer.msg("<spring:message code='NewNameUnempty'/>");
  			        } else if (newGroupName.length > 16) {
  			        	layer.msg("<spring:message code='NameLengthOver16Words'/>");
  			        }
  					//最后清除输入框内容
  					document.getElementById("addGroupInput").value = "";
  				 },
  		  cancel : function() {
 	  			
 	  		 }
  		 });
	 }
	 
	 
	 //2.删除控制组
	 function removeGroup(groupAddr,userid,groupName) {
		 layer.confirm("<spring:message code='deleteAsk'/>" + groupName + "?"
			,{  
	        	title:"<spring:message code='Warnning'/>",
	        	btn: ['<spring:message code='Confirm'/>','<spring:message code='Cancel'/>'],
	        	btn1: function(){
	        		//do something
	  				$.ajax({
	  					 type:"post",
  					     url:localhost + "/user/removeGroup.do",
  				         data:
  				         {
  			             groupid:groupAddr,
  		    	         userid:userid  
  		    	         },
  				         async : true,
  				         datatype: "json",
  				         success:function(datasource, textStatus, jqXHR) {
     			                var data = eval('(' + datasource + ')');
  			    	            if (data.error == null || data.error == "" || data.error == undefined) {//未出错
  					            	 layer.msg("<spring:message code='successfullyDeleted'/>"+"!", function(index) { 
  					            		layui.use('table',function() {
  					             			var table = layui.table;
  					             			table.reload('allGroupsTable', {
  					  		            		   url:localhost+'/model/groups.do'
  					  		            		  ,where: {
  					  		            			  userid: userid
  					  		            		   }
  					  		            		
  					  		            		});
  					             		});
  					           		});
  					            }else{
  					            	 switch(data.error){
  								      case 'User does not exist!':
  								    	  layer.msg("<spring:message code='userUnexist'/>" + "!");
  								      	  break;
  								      case 'Failed to write to database!':
  								    	  layer.msg("<spring:message code='failedWriteDatabase'/>" + "!");
  								          break;
  								      case 'Insufficient permissions!':
  								    	  layer.msg("<spring:message code='insufficientPermissions'/>" + "!");
  								          break;
  							     	};
  					            }
  					          },
  					     error: function() {
  					       	 layer.msg("<spring:message code='Connectionfailure'/>"+"!");
	  					 }
	  			      });
	        	}
          	,btn2: function(){
                 //取消按钮取消删除操作
             }
     	   });
	 }
	 
	 //3.控制组重命名
	 function renameGroup(groupAddr,obj,userid) {	 
		 inner = "<input type='text' id='renameGroupInput' placeholder='<spring:message code='PleaseEnter'/>'  autocomplete='off' class='layui-input'>";
  	  	 layer.open({
  			 area : [ '600px', '150px' ],
  			 btnAlign : 'l',
  			 resize : false,
  			 closeBtn : 1,
  			 type : 1,
  			 title:"<spring:message code='enterNewName'/>",
  			 content : inner,
  			 btn : "<spring:message code='Confirm'/>",
  		     yes : function(index, layero) {
  					var newName = document.getElementById("renameGroupInput").value;
  					if(newName != null && newName != "" && newName.length <=16){
  						 for (var index in Groups) {
  				            if (Groups[index].groupName == newName) {
  				              layer.msg("<spring:message code='PER.addGroupTip1'/>" + "!");
  				              return;
  				            }
  						 }
  						$.ajax({
  				            type:"post",
  				            url:localhost + "/user/renameGroup.do",
  				            data:{
  				            	groupid:groupAddr,
  				                groupNewName:newName
  				            },
  				            async : true,
  				            datatype: "json",
  				            success:function(datasource, textStatus, jqXHR) {
  				            var data = eval('(' + datasource + ')');
  				            if (data.error == null || data.error == "" || data.error == undefined) {//未出错
  				            	  layer.msg("<spring:message code='successfullyModified'/>"+"!", function(){
  				            		   layui.use('table',function() {
  				            				var table = layui.table;
  				            				table.reload('allGroupsTable', {
  						            		     url:localhost+'/model/groups.do'
  						            		     ,where: {userid: userid} //设定异步数据接口的额外参数
  						            		});
  				            			});
  				            		}); 
  				            
  				              }else{
	  				            	switch(data.error){
								      case 'The group does not exist!':
								    	  layer.msg("<spring:message code='groupUnexist'/>"+"!");
								      	  break;
								      case 'Failed to write to database!':
								    	  layer.msg("<spring:message code='failedWriteDatabase'/>"+"!");
								          break;
							     	};
  				              }
  				            
  				            },
  				            error: function() {
  				            	layer.msg("<spring:message code='Connectionfailure'/>"+"!"); 
  				            }
  				          });
  					}else if (newName == "") {//点击取消返回的是null
  						 layer.msg("<spring:message code='NewNameUnempty'/>");
  			        } else if (newName.length > 16) {
  			        	 layer.msg("<spring:message code='NameLengthOver16Words'/>");
  			        }
  					//清空输入框内容
  					document.getElementById("renameGroupInput").value = "";
  					
  				 },
  			 cancel : function() {
  			 }
  		 }); 	 	 
	 }
	 
	 //4.查看控制组详细信息
	 function allGroupDetailMessage(groupdata) {
		 inner = "</br>&nbsp;&nbsp;<spring:message code='groupName'/>" + "：" + groupdata.groupName + "</br>" + "&nbsp;&nbsp;<spring:message code='groupId'/>" + "： " + groupdata.groupid;
		 layer.open({
			  type: 1
			  ,area : [ '250px', '150px' ]
	  		  ,btnAlign : 'l'
	  		  ,resize : false
	  		  ,title:"<spring:message code='detailMessage'/>"
			  ,content: inner //这里content是一个普通的String
	  		  ,closeBtn : 1
			}); 
	 }
	 
	 //5.控制组广播开关转换
	 function switchBroadcastByGroup(groupdata,Switch) {
		 var groupAddr = groupdata.groupid;
		 var userid = groupdata.userid;
		 var zbMacList = [];// 分组下节点的mac地址数组
		 var zbFinder = 0;
		 //1.获取该控制组下的所有节点mac地址，存入zbMacList;
		 for(var i = 0; i < GroupPair.length; i++){
			 if(GroupPair[i].groupid == groupAddr){
				 zbMacList.push(GroupPair[i].zigbeeMac);
			 }
		 }
		 //2.根据zbMac获取每一个节点对应的集控器
		 for(var i = 0; i < zigbeeArr.length; i++){
			 var a = zbMacList.indexOf(zigbeeArr[i].zigbeeMac); 
			 if(zbMacList.indexOf(zigbeeArr[i].zigbeeMac) > -1){
				 var devMac = zigbeeArr[i].devMac;
				 for(var index = 0; index < DevAttrArr.length; index++){
						if(DevAttrArr[index].devMac == devMac && DevAttrArr[index].zigbeeFinder == 1){
							zbFinder = 1;
						}
					}
			 }
		 }
		 //3.for循环当前分组下的所有节点的集控器，当这些集控器中存在正在处于发现节点的过程中，则整组指令不可以发送
		 if(zbFinder == 0){
			 $.ajax({
			        type:"post",
			        url:localhost + "/user/switchByGroup.do",
			        data:{
			          groupid:groupAddr,
			          cmd:Switch
			        },
			        async : true,
			        datatype: "json",
			        success:function(datasource, textStatus, jqXHR) {
			          var data = eval('(' + datasource + ')');
			          if (data.error == null || data.error == "" || data.error == undefined) {//未出错
			        	  layer.msg("<spring:message code='commandSentSuccessfully'/>"+"!", function(){
			            	}); 
			        	  setTimeout(function(){
			        		  layui.use('table',function() {
		            				var table = layui.table;
		            				table.reload('allGroupsTable', {
				            		     url:localhost+'/model/groups.do'
				            		     ,where: {userid: userid} //设定异步数据接口的额外参数
				            		});
		            			});
				          	  },3000);
			          
			          
			          }else{
			        	  switch(data.error){
						      case 'Group does not exist!':
						    	  layer.msg("<spring:message code='groupUnexist'/>"+"!");
						      	  break;
						      case 'Unable to connect offline controller!':
						    	  layer.msg("<spring:message code='unConnectOfflineController'/>"+"!");
						          break;
					     	};
			          }
			        },
			        error: function() {
			        	layer.msg("<spring:message code='Connectionfailure'/>" + "!");
			        }
			    });   
			 
			 
		 }else{
			   layer.alert("<spring:message code='zigbeeFinding.unoperational'/>" + "!",{
	    			title: " <spring:message code='Tips'/>",
	 	    		closeBtn: 0,
		 	        btn : "<spring:message code='btn.Close'/>",
	 			    yes : function(index, layero) {
	 		         	 layer.close(index);
	 		        },
	 	    	});   
		   }
	 }
	 
	 //6.控制组广播调光控制
	 function setBrightnessByGroup(groupdata) {
		 var groupAddr = groupdata.groupid;
		 var userid = groupdata.userid;
		 var newBrightness = "";
		 var zbMacList = [];// 分组下节点的mac地址数组
		 var zbFinder = 0;
		 //1.获取该控制组下的所有节点mac地址，存入zbMacList;
		 for(var i = 0; i < GroupPair.length; i++){
			 if(GroupPair[i].groupid == groupAddr){
				 zbMacList.push(GroupPair[i].zigbeeMac);
			 }
		 }
		 //2.根据zbMac获取每一个节点对应的集控器
		 for(var i = 0; i < zigbeeArr.length; i++){
			 var a = zbMacList.indexOf(zigbeeArr[i].zigbeeMac); 
			 if(zbMacList.indexOf(zigbeeArr[i].zigbeeMac) > -1){
				 var devMac = zigbeeArr[i].devMac;
				 for(var index = 0; index < DevAttrArr.length; index++){
						if(DevAttrArr[index].devMac == devMac && DevAttrArr[index].zigbeeFinder == 1){
							zbFinder = 1;
						}
					}
			 }
		 }
		 //3.for循环当前分组下的所有节点的集控器，当这些集控器中存在正在处于发现节点的过程中，则整组指令不可以发送
		 if(zbFinder == 0){
			 inner = "<input type='text' id='setGroupBrightnessInput' placeholder='<spring:message code='PleaseEnter'/>'  autocomplete='off' class='layui-input'>";
			  	 layer.open({
					 area : [ '600px', '150px' ],
					 btnAlign : 'l',
					 resize : false,
					 closeBtn : 1,
					 type : 1,
					 title:"<spring:message code='enterInteger'/>" + "1~100",
					 content : inner,
					 btn : "<spring:message code='Confirm'/>",
				     yes : function(index, layero) {
						    newBrightness = document.getElementById("setGroupBrightnessInput").value;
							if (newBrightness != null) {
						        if (!Number.isNaN(newBrightness) && newBrightness >= 1 && newBrightness <= 100 && newBrightness.indexOf(".") == -1) {
						              $.ajax({
						                type:"post",
						                url:localhost + "/user/setBrightnessByGroup.do",
						                data:{
						                  groupid:groupAddr,
						                  brightness:newBrightness
						                },
						                async : true,
						                datatype: "json",
						                success:function(datasource, textStatus, jqXHR) {
						                  var data = eval('(' + datasource + ')');
						                  if (data.error == null || data.error == "" || data.error == undefined) {
						                	  layer.msg("<spring:message code='commandSentSuccessfully'/>"+"!", function(){
				  			            	  	    table.reload('allGroupsTable', {
				  			            		           url:localhost+'/model/groups.do'
				  			            		           ,where: {userid: userid} 
				  			            		   
				  			            		     });
				  			            		}); 
						                  } else {
						                	  switch(data.error){
											      case 'Group does not exist!':
											    	  layer.msg("<spring:message code='groupUnexist'/>"+"!");
											      	  break;
											      case 'Unable to connect offline controller!':
											    	  layer.msg("<spring:message code='unConnectOfflineController'/>"+"!");
											          break;
										     	};
						                  }
						                
						                },
						                error: function() {
						                	layer.msg("<spring:message code='Connectionfailure'/>"+"!");
						                }
						              });
						            } else {
						            	layer.msg("<spring:message code='error'/>" +"：" + "<spring:message code='enterInteger'/>" + "1~100");
						        }
						     }	
							//最后清除input状态
							document.getElementById("setGroupBrightnessInput").value = "";
						 },
					 cancel : function() {
						
					 }
			});
			  	 
			  	 
		 }else{
			   layer.alert("<spring:message code='zigbeeFinding.unoperational'/>" + "!",{
	    			title: " <spring:message code='Tips'/>",
	 	    		closeBtn: 0,
		 	        btn : "<spring:message code='btn.Close'/>",
	 			    yes : function(index, layero) {
	 		         	 layer.close(index);
	 		        },
	 	    	});   
		   }
	 }
	 
/**********************************OneGroupTable功能函数*********************************/  
	 //1.添加节点进控制组 
	 function addZigbeeToGroup() {
		 /*
		 var groupAddr = document.getElementById("getData").value;
		 重要： 对单个分组、集控器、策略下的表格操作时，需要对应的groupAddr/devMac/ployid;
		 最初始将这些值动态存在id为getData的输入框内；后来因为需要动态刷新表格；一个输入框存三个不同类型的参数，
		 无法刷新刷新表格；故采用定义三个全局变量groupAddrSaveSpace； deviceMacSaveSpace；ployidSaveSpace分别存储三个参数
		 */
		 var groupAddr = groupAddrSaveSpace;
		 var userid = User.id;
		 var NodecheckBox = document.getElementById("addNodeDiv");
		 var getdata = "";
		 var devArr = [];
		 var zigbeeArr = [];
		 var zbMacList = [];
		 layui.use(['form','table'],function() {
		    	var form = layui.form;
		    	var table = layui.table;
			 	$.ajax({
			       type:"post",
			       url:localhost + "/user/getUseZigbeeMessage.do",
			       data:{
			         groupid:groupAddr,
			         userid:userid,
			       },
			       async : true,
			       datatype: "json",
			       success:function(datasource, textStatus, jqXHR) {
			         //1.后台查询到集控器和节点无错误后，出现弹窗，填充弹窗内容
			         var getdata = eval('(' + datasource + ')');
			         if (getdata.error == null || getdata.error == "" || getdata.error == undefined) {
			        	 devArr = getdata.devArr;
			        	 zigbeeArr = getdata.zigbeeArr;
			        	 //2.有数据时添加弹窗内容 
			        	 if(zigbeeArr.length > 0){ 
			        		 var inner = "";
			        		 for(var i = 0; i < zigbeeArr.length; i++) {
			        				inner = inner + "<input type='checkbox' lay-filter='NodeCheckBox' lay-skin='primary' name='nodeCheckBox'>" + zigbeeArr[i].zigbeeName + "(" + zigbeeArr[i].devMac + ")" + "</br>";
			        		 } 
			        		 NodecheckBox.innerHTML = inner;
			            	 var aNode = document.getElementsByName("nodeCheckBox");
			            	 for(var j = 0 ; j < aNode.length ; j++) {
			        			  aNode[j].value = zigbeeArr[j].zigbeeMac;
			        		 }
			            	 //3.有数据弹窗（）
			            	 layer.open({
			    				 area : [ '450px', '400px'],
			    				 btnAlign : 'l',
			    				 resize : false,
			    				 closeBtn : 1,
			    				 type : 1,
			    				 title:"<spring:message code='pleaseChooseNodesToAdd'/>",
			    				 content : $('#addNodeWindow'),
			    				 success:function() {
			    						 form.render(null,'form3'); 
			    						 form.on('checkbox(NodeCheckBox)', function(data) {
			    							 zbMacList.push(data.value);//选中的节点mac集合
			    						 }); 
			    	        	 },
			    	        	 btn : "<spring:message code='Confirm'/>",
			    			     yes : function(index, layero) {
			    			    	 //4.选中后提交至后台进行添加
			    			    	 if(zbMacList.length > 0) {
			    			    		 $.ajax({
			    				    		type:"post",
			    				    	    url:localhost + "/user/addZigbeeToGroup.do",
			    				    	    data:{
			    				    	       groupid:groupAddr,
			    				    	       zigbeeList:zbMacList.toString()
			    				    	    },
			    				            async : true,
			    				            datatype: "json",
			    				            success:function(datasource, textStatus, jqXHR) {
			    				              var data = eval('(' + datasource + ')');
			    				              if (data.error == null || data.error == "" || data.error == undefined) {
			    				                  layer.msg("Command sent successfully!",function(){
			    				                	  table.reload('oneGroupsTable', {
							  		            		   url:localhost+'/model/groupDetail.do'
							  		            		   ,where:{  
							  		            			   groupid:groupAddr
							  		            			} 
							  		              		});
			    				                	  
			    				                  });
			    				              /*重要：添加节点完成后，弹窗内节点需要更新;可以设置自动退出弹窗；或者重新调用addZigbeeToGroup()函数
			    				              		因实现添加节点进分组后，弹窗内容无法自动更新，
			    				              		故添加指令发送完成后自动退出弹窗，再次添加则再次进入添加节点弹窗
			    				              	*/
			    				              	layer.close(index);
			    				              } else {
			    				            	 switch(data.error){
					   							      case 'Unable to connect offline controller!':
					   							    	  layer.msg("<spring:message code='unConnectOfflineController'/>");
					   							      	  break;
					   							      case 'Group does not exist!':
					   							    	  layer.msg("<spring:message code='groupUnexist'/>");
					   							          break;
				   						     	 };
			    				            	
			    				              }
			    				            },
			    				            error: function() {
			    				            	 layer.msg("<spring:message code='Connectionfailure'/>");
			    				            }
			    				          });
			    			    		 //集合清零,清除操作的状态
			    			    		 zbMacList = [];
			    			    		 var checkbox = document.getElementsByName('nodeCheckBox');
			    					  	 for(var i = 0; i < checkbox.length; i++){
			    					  		checkbox[i].checked = false;
			    					  	 }
			    						 form.render(null,'form3');  
			    						 
			    			    	 }else{
			    			    		layer.msg("<spring:message code='nodeUnselect'/>");
			    			    	 }
			    			    	//
			    				 },
			    				 cancel : function() {
			    				 }
			    			 });
			            	 
			        	 }else{ //无节点
			        		 //3.弹窗（无节点信息）
			        		 layer.open({
			    				 area : [ '450px', '400px'],
			    				 btnAlign : 'l',
			    				 resize : false,
			    				 closeBtn : 1,
			    				 type : 1,   
			    				 title:"<spring:message code='pleaseChooseNodesToAdd'/>",  
			    				 content : "<spring:message code='PER.noAvailableNode'/>",
			    				 success:function() {
			    					 
			    	        	 },
			    	        	 btn : "<spring:message code='Confirm'/>",
			    			     yes : function(index, layero) {
			    			    	 layer.msg("<spring:message code='PER.noAvailableNode'/>");    	 
			    				 },
			    				 cancel : function() {
			    				 }
			    			 });
			        	 }
			        
			        	 	 
			         }else{
				           if(getdata.error == "参数错误，未查询到可用的节点信息"){
				        	   layer.alert("<spring:message code='PER.paramError'/>",{
					 	    		title:"<spring:message code='error'/>",
					 	    		closeBtn: 0,
						 	        btn : "<spring:message code='btn.Close'/>",
					 			    yes : function(index, layero) {
					 		         	 layer.close(index);
					 		        },
					 	    	}); 
				           }
			           }
			         
			       }, //success;
			       error: function() {
			    	   layer.msg("<spring:message code='Connectionfailure'/>"+"!");
			       }
			   });
		  });
		     
	 }
	
	 //2.从控制组删除节点
	 function removeZigbeeFromGroup(zigbeeMac) {
		 //var groupAddr = document.getElementById("getData").value;
		 var groupAddr = groupAddrSaveSpace;
		 layer.confirm("<spring:message code='deleteAsk'/>" + " " + "<spring:message code='node'/>"+"?"
		  	 ,{  
		  	    title:"<spring:message code='Warnning'/>",
		  	    btn: ['<spring:message code='Confirm'/>','<spring:message code='Cancel'/>'],
		  	    btn1: function(){
		  	    	//do something
		  	    	$.ajax({
 					     type:"post",
 					     url:localhost + "/user/removeZigbeeFromGroup.do",
 					  	 data:{
 				         	zigbeeMac:zigbeeMac,
 				          	groupid:groupAddr
 				       	 },
 				         async : true,
 				         datatype: "json",
 				         success:function(datasource, textStatus, jqXHR) {
    			                var data = eval('(' + datasource + ')');
 			    	            if (data.error == null || data.error == "" || data.error == undefined) {//未出错
 					            	 layer.msg("<spring:message code='successfullyDeleted'/>", function(index){ 
 					            		//layer.close(index);
 					            		layui.use('table',function() {
					             			 var table = layui.table;
					             			 table.reload('oneGroupsTable', {
					  		            		   url:localhost+'/model/groupDetail.do'
					  		            		   ,where:{  
					  		            			   groupid:groupAddr 
					  		            		    } 
					  		            	  });
					             		  });
 					           		  }); 
 					            	
 					            } else {
 					            	switch(data.error){
	  							      case 'Unable to connect offline controller!':
	  							    	  layer.msg("<spring:message code='unConnectOfflineController'/>"+"!");
	  							      	  break;
	  							      case 'Node or group does not exist!':
	  							    	  layer.msg("<spring:message code='nodeOrGroupUnexist'/>"+"!");
	  							          break;
 						     		};
 					            	  
 					            }
 					        },
 					        error: function() {
 					        	layer.msg("<spring:message code='Connectionfailure'/>"+"!");
 					        },
 			      	});	
		  	    }
		        ,btn2: function(){
		            //取消按钮取消删除操作
		         }
		      });   
	 }
	 
	 //3.节点表格内控制组重命名
	function zigbeeTableRenameGroup(){
	    //var groupAddr = document.getElementById("getData").value;
	    var groupAddr = groupAddrSaveSpace;
	    var newName = "";
		inner = "<input type='text' id='renameGroupInput' placeholder='<spring:message code='PleaseEnter'/>'  autocomplete='off' class='layui-input'>";
 	  	layer.open({
 			 area : [ '600px', '150px' ],
 			 btnAlign : 'l',
 			 resize : false,
 			 closeBtn : 1,
 			 type : 1,
 			 title:"<spring:message code='enterNewName'/>",
 			 content : inner,
 			 btn : "<spring:message code='Confirm'/>",
 		     yes : function(index, layero) {
 				    newName = document.getElementById("renameGroupInput").value;
 					if(newName != null && newName != "" && newName.length <=16){
 						for (var index in Groups) {
 				            if(Groups[index].groupName == newName) {
 				               layer.msg("<spring:message code='PER.addGroupTip1'/>"+"!");
 				               return;
 				            }
 						 }
 						$.ajax({
 				            type:"post",
 				            url:localhost + "/user/renameGroup.do",
 				            data:{
 				            	groupid:groupAddr,
 				                groupNewName:newName
 				            },
 				            async : true,
 				            datatype: "json",
 				            success:function(datasource, textStatus, jqXHR) {
 				            var data = eval('(' + datasource + ')');
 				            if (data.error == null || data.error == "" || data.error == undefined) {
 				            	 layer.msg("<spring:message code='successfullyModified'/>"+"!");
 				            	 layui.use('table',function() {
 				            		var table = layui.table;
			             			 table.reload('oneGroupsTable', {
			  		            		   url:localhost+'/model/groupDetail.do'
			  		            		   ,where:{  
			  		            			   groupid:groupAddr 
			  		            		    } 
			  		            	  });
				             	  });
 				              }else{
 				            	 switch(data.error){
							      case 'The group does not exist!':
							    	  layer.msg("<spring:message code='groupUnexist'/>" + "!");
							      	  break;
							      case 'Failed to write to database!':
							    	  layer.msg("<spring:message code='failedWriteDatabase'/>" + "!");
							          break;
						     	};
 				              }
 				            },
 				            error: function() {
 				            	 layer.msg("<spring:message code='Connectionfailure'/>"+"!");		 
 				            }
 				          });
 					}else if (newName == "") {
 					    layer.msg("<spring:message code='NewNameUnempty'/>");
 			        } else if (newName.length > 16) {
 			        	layer.msg("<spring:message code='NameLengthOver16Words'/>");
 			        }
 					//最后清除输入框信息
 				   document.getElementById("renameGroupInput").value = " ";
 					
 				 },
 			 cancel : function() {
 			 }
 		 });
	 }
	 
	//4.通过单个控制组展示控制组的详细信息
 	function showZigbeeDetailByGroupTable(ogdata) {
	 	var zigbee = new Zigbee(); 
	    for(var i = 0; i < zigbeeSet.length; i++) {
	 		if(zigbeeSet[i].mac == ogdata.zigbeeMac && zigbeeSet[i].devMac == ogdata.devMac){
	 			zigbee = zigbeeSet[i];
	 		 }
	 	}
	    var groupPair = "";
	    var groupName = null;
	    for(var i in GroupPair){
	    	if(zigbee.mac == GroupPair[i].zigbeeMac){
	    		groupPair = GroupPair[i];
	    	}
	    }
	    for(var j in Groups){
	    	if(groupPair.groupid == Groups[j].groupid){
	    		groupName = Groups[j].groupName;
	    	}
	    }
	 	var tempString = "&nbsp;&nbsp;<spring:message code='nodeName'/>" + "：" + zigbee.name + "<br/>" 
        + "&nbsp;&nbsp;<spring:message code='macAddress'/>" + "：" + zigbee.mac + "<br/>" 
        + "&nbsp;&nbsp;<spring:message code='controller'/>" + "：" + zigbee.devMac + "<br/>" 
        + "&nbsp;&nbsp;<spring:message code='network'/>" + "：" + zigbee.online + "<br/>" 
        + "&nbsp;&nbsp;<spring:message code='status'/>" + "：" + zigbee.workStatus + "<br/>" 
        + "&nbsp;&nbsp;<spring:message code='brightness'/>" + "：" + zigbee.brightness + "<br/>" 
        + "&nbsp;&nbsp;<spring:message code='groups'/>" + "：" + groupName + "<br/>" 
        + "&nbsp;&nbsp;<spring:message code='ratedPower'/>" + "：" + zigbee.power + "W";
      if (zigbee.type == 1) {
        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='deviceType'/>" + "：" + "<spring:message code='sodiumLamp'/>";
        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='dimmingRange'/>" + "：" + "50 - 100";
      } else if (zigbee.type == 2) {
        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='deviceType'/>" + "：" + "<spring:message code='metalHalideLamp'/>";
        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='dimmingRange'/>" + "：" + "50 - 100";
      } else if (zigbee.type == 3) {
        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='deviceType'/>" + "：" + "<spring:message code='ledLighting'/>";
        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='dimmingRange'/>" + "：" + "1 - 100";
      } else if (zigbee.type == 17) {
        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='deviceType'/>" + "：" + "<spring:message code='sodiumLamp'/>"+"SHT10";
        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='dimmingRange'/>" + "：" + "50 - 100";
      } else if (zigbee.type == 18) {
        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='deviceType'/>" + "：" + "<spring:message code='metalHalideLamp'/>"+"SHT10";
        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='dimmingRange'/>" + "：" + "50 - 100";
      } else if (zigbee.type == 19) {
        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='deviceType'/>" + "：" + "<spring:message code='ledLighting'/>"+"SHT10";
        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='dimmingRange'/>" + "：" + "1 - 100";
      } else if (zigbee.type == 33) {
        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='deviceType'/>" + "：" + "SHT10";
        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='temperatureRange'/>" + "：" + "-50°C - 125°C";
      } else {
        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='deviceType'/>" + "：" + "<spring:message code='unknown'/>";
        tempString = tempString + "<br/>" + "&nbsp;&nbsp;<spring:message code='dimmingRange'/>" + "：" + "50 - 100";
      }
      layer.open({
			 area : [ '250px', '300px' ],
			 btnAlign : 'l',
			 resize : false,
			 closeBtn : 1,
			 type : 1,
			 title:"<spring:message code='detailMessage'/>",
			 content : tempString,
			 cancel : function(){
			 }
		 });
 	}
	 
    //5.设置组内节点的广播控制开关 
	function switchSingleInGroup(data,Switch) {
		 var groupAddr = groupAddrSaveSpace;
		 var devMac = data.devMac;
		 var zbFinder = 0;
		//1.判断集控器是否在发现节点；
		 for(var index = 0; index < DevAttrArr.length; index++){
			 if(DevAttrArr[index].devMac == devMac){
				 zbFinder = DevAttrArr[index].zigbeeFinder;
			 }
		 }
		 //2.当前节点的集控器处于在发现节点的过程中，不进行开、关、调光操作
		 if(zbFinder == 0){ //
			 $.ajax({
			        type:"post",
			        url:localhost + "/user/switchZigbee.do",
			        data:{
			          zigbeeMac:data.zigbeeMac,
			          cmd:Switch
			        },
			        async : true,
			        datatype: "json",
			        success:function(datasource, textStatus, jqXHR) {
			          var data = eval('(' + datasource + ')');
			          if (data.error == null || data.error == "" || data.error == undefined) {
			        	  layer.msg("<spring:message code='commandSentSuccessfully'/>");
			            //重要：状态更改完成后由于集控器反馈到服务器需要时间，故添加延时3秒钟重载表格；重载表格，表格数据未发生改变
			          	  setTimeout(function(){
			          		layui.use('table',function() {
		            			var table = layui.table;
		            			table.reload('oneGroupsTable', {
				            		   url:localhost+'/model/groupDetail.do'
				            		   ,where:{  
				            			   groupid:groupAddr
				            			} 
				            		});
		            		});
			          		  
			          	  },3000);
			          
			          } else {
			        	  switch(data.error){
						      case 'Node does not exist!':
						    	  layer.msg("<spring:message code='nodeUnexist'/>"+"!");
						      	  break;
						      case 'Unable to connect to the controller where the node is located!':
						    	  layer.msg("<spring:message code='unConnectDev'/>"+"!");
						          break;
					     	};
	
			          }
			        },
			        error: function() {
			        	layer.msg("<spring:message code='Connectionfailure'/>"+"!");
			        }
			      });
		 
		 
		 }else{
			   layer.alert("<spring:message code='zigbeeFinding.unoperational'/>" + "!",{
	    			title: " <spring:message code='Tips'/>",
	 	    		closeBtn: 0,
		 	        btn : "<spring:message code='btn.Close'/>",
	 			    yes : function(index, layero) {
	 		         	 layer.close(index);
	 		        },
	 	    	});   
		   }
	 }
		 
	 //6.控制组下节点表格的节点单灯调光  
	 function setSingleBrightnessInGroup(ogdata) {
		 var groupAddr = groupAddrSaveSpace;
		 var zigbeeMac = ogdata.zigbeeMac;
	 	 var zigbee = new Zigbee();
	 	 var lowRange = 1;
	 	 var newBrightness = "";
	 	 var devMac = ogdata.devMac; 
	 	//1.判断集控器是否在发现节点；
		 for(var index = 0; index < DevAttrArr.length; index++){
			 if(DevAttrArr[index].devMac == devMac){
				 zbFinder = DevAttrArr[index].zigbeeFinder;
			 }
		 }
		 //2.当前节点的集控器处于在发现节点的过程中，不进行开、关、调光操作
		 if(zbFinder == 0){ //
		 	 //3.获取节点的调光范围
		 	 for(var i = 0; i < zigbeeSet.length; i++){
		 		 if(zigbeeSet[i].mac == zigbeeMac){
		 			 zigbee = zigbeeSet[i];
		 		 }
		 	 }
		 	if(zigbee.type == 1 || zigbee.type == 2 || zigbee.type == 17 || zigbee.type == 18 || zigbee.type == null || zigbee.type == ""){
		 		lowRange = 50;
		 	 }else if(zigbee.type == 33){
		 		lowRange = -50;
		 		//highRange = 125;
		 	 }
		 	 inner = "<input type='text' id='zigbeeBrightnessInput' placeholder='<spring:message code='PleaseEnter'/>'  autocomplete='off' class='layui-input'>";
		 	 layui.use('table',function(){
	 			 var table = layui.table;
			 	 layer.open({
					 area : [ '600px', '150px' ],
					 btnAlign : 'l',
					 resize : false,
					 closeBtn : 1,
					 type : 1,
					 title:"<spring:message code='enterInteger'/>" + lowRange + "~100",
					 content : inner,
					 btn : "<spring:message code='Confirm'/>",
				     yes : function(index, layero) {
						   newBrightness = document.getElementById("zigbeeBrightnessInput").value;
						   if (newBrightness != null) {
					          if (!Number.isNaN(newBrightness) && newBrightness >= lowRange && newBrightness <= 100 && newBrightness.indexOf(".") == -1) {
		 				            $.ajax({
			 				              type:"post",
			 				              url:localhost + "/user/setBrightness.do",
			 				              data:{
			 				                zigbeeMac:zigbeeMac,
			 				                brightness:newBrightness
			 				              },
			 				              async : true,
			 				              datatype: "json",
			 				              success:function(datasource, textStatus, jqXHR) {
			 				                var data = eval('(' + datasource + ')');
			 				                if (data.error == null || data.error == "" || data.error == undefined) {
			 				                	layer.msg("<spring:message code='commandSentSuccessfully'/>");
			 				            		//重要：状态更改完成后由于集控器反馈到服务器需要时间，故添加延时3秒钟重载表格；重载表格，表格数据未发生改变
			 				                	setTimeout(function() {
			 				                		table.reload('oneGroupsTable', {
									            		   url:localhost+'/model/groupDetail.do'
									            		   ,where:{  
									            			   groupid:groupAddr
									            			} 
									            		});
									          		  
									          	  },3000);
								 				 
			 				  
			 				                }else{
			 				                	switch(data.error){
			 								      case 'Unable to connect to the controller where the node is located!':
			 								    	  layer.msg("<spring:message code='unConnectDev'/>"+"!");
			 								      	  break;
			 								      case 'Instructions that already have the same address are being executed':
			 								    	  layer.msg("<spring:message code='sameInstructions'/>"+"!");
			 								          break;
			 								      case 'Node does not exist!':
			 								    	  layer.msg("<spring:message code='nodeUnexist'/>"+"!");
			 								          break;
			 							     	};
			 				                }
			 				              },
			 				              error: function() {
			 				            	 layer.msg("<spring:message code='Connectionfailure'/>"+"!");
			 				              }
		 				             });
					          } else {
					        	  layer.msg("<spring:message code='enterInteger'/>"+ lowRange + "~100");
					          }
					          //最后清除输入框状态
					          document.getElementById('zigbeeBrightnessInput').value = "";
						    }
						 },
					 cancel : function() {
						
					 }
				 });
		 	});
		 	 
		 	 
		 } else {
				   layer.alert("<spring:message code='zigbeeFinding.unoperational'/>" + "!",{
		    			title: " <spring:message code='Tips'/>",
		 	    		closeBtn: 0,
			 	        btn : "<spring:message code='btn.Close'/>",
		 			    yes : function(index, layero) {
		 		         	 layer.close(index);
		 		        },
		 	    	});   
			   }
	 }
 
/**************************************策略表格相关操作**************************************/ 
   //1.添加策略
	function addPloy() {
		layui.use(['form','table'],function() {
			 var form = layui.form;
			 var table = layui.table;
			 var groupid = "";//初始化id
			 var ployName = "";//初始化
		     var radio = document.getElementById("selectGroupDiv");
		 	 var inner="";
		 	 for(var i = 0; i < Groups.length; i++) {
		 		inner = inner + "<input type='radio' name='radioBindGroup' lay-filter='bindGroupFilter'>" + Groups[i].groupName + "</br>";
		 	 }
		 	 radio.innerHTML = inner;
		 	 var aRadio = document.getElementsByName("radioBindGroup");
		 	 for(var j = 0; j < aRadio.length; j++) {
		 		aRadio[j].value = Groups[j].groupid;
		 	 }
		 	 layer.open({
				 area : [ '400px', '400px' ],
				 btnAlign : 'l',
				 resize : false,
				 closeBtn : 1,
				 type : 1,
				 title:"<spring:message code='AddPloy'/>",
				 content : $('#addPlayWindow'),
				 success: function(layero, index) {
						//重要：改变绑定弹框内表单渲染；form表单不渲染layui表单控件无法加载；
						 form.render(null,'form0');  
						 form.on('radio(bindGroupFilter)', function(data) {
							 	groupid = data.value;
						 }); 	
		   	     },
		   	     btn : "<spring:message code='Confirm'/>",
			     yes : function(index, layero) {
			    		 ployName = document.getElementById("addPloyInput").value;
						 if (ployName != null && ployName != "" && ployName.length <= 16) {
							 for (var index in Ploy) {
		 				          if (Ploy[index].ployName == ployName) {
		 				              layer.msg("<spring:message code='PER.addPloyTip1'/>"+"!");
		 				              return;
		 				            }
		 						 }
							 if(groupid != ""){
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
								              var data = eval('(' + datasource + ')');
								              if (data.error == null || data.error == "" || data.error == undefined) {
								            	  layer.msg("<spring:message code='Addedsuccessfully'/>");
								            	  table.reload('allPloysTable', {
								            		   url:localhost+'/model/ploys.do'
								            		   ,where:{  
								            			   userid : User.id 
								            			   } 
								            		});
								              
								              } else {
								            		if(data.error == "Failed to add!"){	
									            	   layer.msg("<spring:message code='failedToAdd'/>");
								            		}
								              }
							            },
							            error: function() {
							            	layer.msg("<spring:message code='Connectionfailure'/>"+"!");
							            }
							          });
							 }else{
								 layer.msg("<spring:message code='noBindGroup'/>");
							 }
							
						 } else if (ployName == "") {//点击取消返回的是null
							 layer.msg("<spring:message code='NewNameUnempty'/>");
					     } else if (ployName.length > 16) {
					    	 layer.msg("<spring:message code='NameLengthOver16Words'/>");
					     }
						 //最后清除状态
						 var radio = document.getElementsByName('radioBindGroup');
					  	 for(var i = 0; i < radio.length; i++){
					  		 radio[i].checked = false;
					  	 }
						 document.getElementById("addPloyInput").value = "";
						 groupid = "";
						 form.render(null,'form0');  
						
					 },
				 cancel : function() {
				
				 }
			 });
		});
	}

	//2.删除策略
	function removePloy(pcsdata) {
		  var userid =  User.id;
		  var ployid = pcsdata[0].id;
		  var ployName = pcsdata[0].ployName;
		  layer.confirm("<spring:message code='deleteAsk'/>" + " " + ployName + "?"
			  ,{  
	        	title:"<spring:message code='Warnning'/>",
	        	btn: ['<spring:message code='Confirm'/>','<spring:message code='Cancel'/>'],
	        	btn1: function(){
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
				              if (data.error == null || data.error == "" || data.error == undefined) {
				            	  layer.msg("<spring:message code='successfullyDeleted'/>"+"!");
				            	  layui.use('table',function() {
 				            			var table = layui.table;
 				            			table.reload('allPloysTable', {
 					            		   url:localhost+'/model/ploys.do'
 					            		   ,where:{  
 					            			   userid : User.id 
 					            			   } 
 					            		});
 				            		});
 				            	
				              } else {
				            	  if(data.error == "Failed to delete!"){
				            		  layer.msg("<spring:message code='failedToDelete'/>"+"!");
				            	  }
				            	  
				              }
				          },
				          error: function() {
				            	layer.msg("<spring:message code='Connectionfailure'/>"+"!");
				          }
				  });
	        	}
           		,btn2: function(){
                  //取消按钮取消删除操作
             	 }
      	 		});
	 }
		 

	//3.策略重命名
	function renamePloy(pcsdata) {
		 var ployid = pcsdata[0].id;
		 var newName = ""; //初始化
		 inner = "<input type='text' id='renamePloyInput' placeholder='<spring:message code='PleaseEnter'/>'  autocomplete='off' class='layui-input'>";
		  	 layer.open({
				 area : [ '600px', '150px' ],
				 btnAlign : 'l',
				 resize : false,
				 closeBtn : 1,
				 type : 1,
				 title:"<spring:message code='enterNewName'/>",
				 content : inner,
				 btn : "<spring:message code='Confirm'/>",
			     yes : function(index, layero) {
						newName = document.getElementById("renamePloyInput").value;
						if(newName != null && newName != "" && newName.length <=16){
							 for (var index in ploySet) {
					            if (ploySet[index].name == newName) {
					              layer.msg("<spring:message code='samePloyName'/>" + "!");
					              return;
					            }
							 }
							$.ajax({
					            type:"post",
					            url:localhost + "/user/renamePloy.do",
				                data:{
				                   id:ployid,
				                   newName:newName
				                },
					            async : true,
					            datatype: "json",
					            success:function(datasource, textStatus, jqXHR) {
					            var data = eval('(' + datasource + ')');
					            if (data.error == null || data.error == "" || data.error == undefined) {
					            	  layer.msg("<spring:message code='successfullyModified'/>"+"!");
	  				            	  layui.use('table',function() {
		 				            		var table = layui.table;
		 				            		table.reload('allPloysTable', {
		 					           		   url:localhost+'/model/ploys.do'
		 					           		   ,where:{  
		 					           			   userid : User.id 
		 					           			   } 
		 					           		 });
		 				            	});
	 				          
					              } else {
					            		if(data.error == "Fail to edit!"){
					            			layer.msg("<spring:message code='failToEdit'/>"+"!");
					            		}
					              }
					            },
					            error: function() {
					            	layer.msg("<spring:message code='Connectionfailure'/>"+"!");
					            }
					          });
						}else if (newName == "") {//点击取消返回的是null
							layer.msg("<spring:message code='NewNameUnempty'/>");
				        } else if (newName.length > 16) {
				        	layer.msg("<spring:message code='NameLengthOver16Words'/>");
				        }
						//清空输入框信息
						document.getElementById("renamePloyInput").value = "";
					 },
				 cancel : function() {
				 }
			 });
	 }

	//5.开始执行策略
	function runPloy(ploydata) {
		var ployid = ploydata.id;
	    $.ajax({
	        type:"post",
	        url:localhost + "/user/ploySwitch.do",
	        data:{
	          id:ployid,
	          status:1,
	        },
	        async : true,
	        datatype: "json",
	        success:function(datasource, textStatus, jqXHR) {
	          var data = eval('(' + datasource + ')');
	          if (data.error == null || data.error == "" || data.error == undefined) {//未出错
	            layer.msg("Started successfully.");
	            layui.use('table',function() {
	        		var table = layui.table;
	        		table.reload('allPloysTable', {
	           		   url:localhost+'/model/ploys.do'
	           		   ,where:{  
	           			   userid : User.id 
	           			   } //设定异步数据接口的额外参数  	
	            	 });
	        	});
	          } else {
	        	  if(data.error == "Switch failed!"){
	        		  layer.alert("<spring:message code='switchFailed'/>"+"!",{
	  	 	    		 title:"<spring:message code='error'/>",
	  	 	    		 closeBtn: 0,
	  		 	         btn : "<spring:message code='btn.Close'/>",
	  	 			     yes : function(index, layero) {
	  	 		         	 layer.close(index);
	  	 		         },
	  	 	    	  }); 
	        	  } 
	          }
	        },
	        error: function() {
	        	layer.msg("<spring:message code='Connectionfailure'/>"+"!");
	        }
	      });
	}

	//6.停止执行策略
	function stopPloy(ploydata) {
		var ployid = ploydata.id;
	    $.ajax({
	        type:"post",
	        url:localhost + "/user/ploySwitch.do",
	        data:{
	          id:ployid,
	          status:0,
	        },
	        async : true,
	        datatype: "json",
	        success:function(datasource, textStatus, jqXHR) {
	          var data = eval('(' + datasource + ')');
	          if (data.error == null || data.error == "" || data.error == undefined) {
	            layer.msg("<spring:message code='stopRunningSuccessfully'/>");
	            layui.use('table',function() {
	        			var table = layui.table;
	        			table.reload('allPloysTable', {
	            		   url:localhost+'/model/ploys.do'
	            		   ,where:{  
	            			   userid : User.id 
	            			   } 
	            	 });
	        	});
	          } else {
	        	  if(data.error == "Switch failed!"){
	        		  layer.alert("<spring:message code='switchFailed'/>"+"!",{
		  	 	    		 title:"<spring:message code='error'/>",
		  	 	    		 closeBtn: 0,
		  		 	         btn : "<spring:message code='btn.Close'/>",
		  	 			     yes : function(index, layero) {
		  	 		         	 layer.close(index);
		  	 		         },
		  	 	    	  }); 
	        	  } 
	          }
	        },
	        error: function() {
	        	layer.msg("<spring:message code='Connectionfailure'/>"+"!");
	        }
	      });
	}
	
	//7.策略的详细信息
	function showPloyDetail(ployid){
		var ployObj = "";
		for(var i in Ploy){
			if(Ploy[i].id == ployid) {
				ployObj = Ploy[i];
			}
		}
		var str = "</br>&nbsp;&nbsp;<spring:message code='ployName'/>" + "：" + ployObj.ployName + "<br/>" + "&nbsp;&nbsp;<spring:message code='ployId'/>"+"：" + ployid + "<br/>";
		if (ployObj.status == 0) {
		        str = str + "&nbsp;&nbsp;<spring:message code='status'/>"+"：" + "<spring:message code='stop'/>" + "<br/>"
		      } else if (ployObj.status == 1) {
		        str = str + "&nbsp;&nbsp;<spring:message code='status'/>"+"：" + "<spring:message code='running'/>" + "<br/>"
		      }
		      switch (ployObj.bindType) {
		        case 1:
		          str = str + "&nbsp;&nbsp;<spring:message code='bindType'/>"+"：" + "<spring:message code='groups'/>" + "<br/>"
		          break;
		        case 2:
		          str = str + "&nbsp;&nbsp;<spring:message code='bindType'/>"+"：" + "<spring:message code='controller'/>" + "<br/>"
		          break;
		        case 3:
		          str = str + "&nbsp;&nbsp;<spring:message code='bindType'/>"+"：" + "<spring:message code='node'/>" + "<br/>"
		          break;
		        default:
		          break;
		      }
		str = str + "&nbsp;&nbsp;<spring:message code='bindAddress'/>"+"：" + ployObj.bindData + "<br/>";
		layer.open({
			  type: 1
			  ,area : [ '300px', '200px' ]
	  		  ,btnAlign : 'l'
	  		  ,resize : false
	  		  ,title:'<spring:message code='detailMessage'/>'
			  ,content: str //这里content是一个普通的String
	  		  ,closeBtn : 1
			}); 
	}
	
/****************************onePloyTable数据表格内的函数**********************************/
	//1.向策略内添加定时广播
	function addBroadcastPlan(){
		//var ployid = document.getElementById("getData").value;
		var ployid = ployidSaveSpace;
		var status = "";
		var type = "";// 初始化操作的类型，操作类型为1时，则为开关，操作类型为2时，值为调光
		var param = "";// 初始化操作类型对应的参数，操作类型为1时，1为开，0为关；操作类型为2时，值为调光值
		//1.获取到ploy对象
	     $.ajax({
	  	       type:"post",
	  	       url:localhost + "/user/getPloyStatusForAddBroadcastPlan.do",
	  	       data:{
	  	         ployid:ployid,
	  	       },
	  	       async : true,
	  	       datatype: "json",
	  	       success:function(datasource, textStatus, jqXHR) {
	  	    	   //成功获取到ploy数据后
	  	         var data = eval('(' + datasource + ')');
	  	         if(data.id != null){
	  	        	 status = data.status;
	  	         }
	  	         //2.弹窗：ploy状态是停止，则弹窗进行添加操作
	  			 if(status == 0){
	  				layui.use(['form','table','layer'],function() {
	  					 var form = layui.form;
	  					 var table = layui.table;
	  					 var layer = layui.layer;
	  					 layer.open({
	  						 area : [ '700px', '320px' ],
	  						 btnAlign : 'l',
	  						 resize : false,
	  						 closeBtn : 1,
	  						 type : 1,
	  						 title:"<spring:message code='AddBroadcast'/>",
	  						 content : $('#addPlanWindow'),
	  						 success: function(layero, index) {
	  							 form.render(null,'form2');  
	  							 form.on('select(selectSwitchFilter)', function(data) {
	  								 if(data.value == "dim"){
	  									type = 2;
	  									document.getElementById("SwitchParam").style.display = "none";
	  									document.getElementById("DimParam").style.display = "block";
	  								 }
	  								 if(data.value == "switch"){
	  									 type = 1;
	  									 document.getElementById("SwitchParam").style.display = "block";
	  									 document.getElementById("DimParam").style.display = "none";
	  								 }
	  							 });
	  							 form.on('select(selectOpenFilter)', function(data) {
	  								 	if(document.getElementById("SwitchParam").style.display == "block"){
	  								 		param = data.value;
	  								 	}
	  							 });
	  						 },
	  					     btn : "<spring:message code='Confirm'/>",
	  					     yes : function(index, layero) {
	  					    	 	    var hours = "";
	  					    	 	    var minutes = "";
	  					    	 	    hours = document.getElementById("HH").value;
	  					    	 		minutes = document.getElementById("MM").value;
	  								  	if(document.getElementById("DimParam").style.display == "block"){
	  								  		param = document.getElementById("DimParamInput").value;	
	  								  	}	
	  								 
	  								  	if(hours != "" && param != "" && minutes != "" && type != ""){
	  								  		if(hours >= 0 && hours < 24 && minutes >= 0 && minutes < 60) {
	  									  		 var offset = new Date().getTimezoneOffset();
	  									  	     var gmtTime;
	  									  	     gmtTime = getGMTTime(hours, minutes, offset);
	  									  	     gmthours = gmtTime.gmthours;
	  									  	     gmtminutes = gmtTime.gmtminutes;
	  									  	     //3.提交添加的策略操作至接口层
	  									  	     $.ajax({
	  									  	       type:"post",
	  									  	       url:localhost + "/user/addPloyOperate.do",
	  									  	       data:{
	  									  	         ployid:ployid,
	  									  	       	 hours:gmthours,
	  									  	         minutes:gmtminutes,
	  									  	         operateType:type,
	  									  	         operateParam:param
	  									  	       },
	  									  	       async : true,
	  									  	       datatype: "json",
	  									  	       success:function(datasource, textStatus, jqXHR) {
	  									  	         var data = eval('(' + datasource + ')');
	  									  	         if (data.error == null || data.error == "" || data.error == undefined) {
	  												     layer.msg("<spring:message code='Addedsuccessfully'/>"+"!");  
	  													 table.reload('onePloysTable', {
	  											     		  url:localhost+'/model/ployOperate.do'
	  											   	   		 ,where:{
	  											   	   			 id:ployid
	  										     	   		 }
	  								   	        		 });
	  												     
	  									  	         } else { 
	  									  	        	 if(data.error  == "Failed to add!"){
	  									  	        		layer.msg("<spring:message code='failedToAdd'/>"+"!");
	  									  	        	 }else if(data.error  == "该指令已存在"){
	  									  	        		layer.msg("<spring:message code='cmdExist'/>"+"!");
	  									  	        		 }
	  									  	        	 }
	  									  	       },
	  									  	       error: function() {
	  									  	    		layer.msg("<spring:message code='Connectionfailure'/>"+"!");
	  									  	     
	  									  	       }
	  									  	     });
	  									  	     
	  									  	     
	  									  		}else {
	  									  			layer.msg("<spring:message code='timeFormatException'/>"+"!"); 
	  									  		}
	  								  	} else {
	  								  		layer.msg("<spring:message code='incompleteInformation'/>"+"!");  
	  								  	}
	  								  //4.恢复添加操作表单至初始状态
  								  		document.getElementById("HH").value = "";
  							  			document.getElementById("MM").value = "";
  							  		    document.getElementById("DimParamInput").value = "";
  									  	var select1 = document.getElementById('selectSwitchParam');
  									  	var select2 = document.getElementById('selectSwitchStatus');
  										select1.options[0].selected = true; // 选中
  									  	select2.options[0].selected = true; // 选中
  									  	form.render(null,'form2');  
 	
	  							 },
	  						 cancel : function() {
	  							
	  						 }
	  					 });
	  				 }); 
	  				
	  				
	  			}else{
	  				layer.alert("<spring:message code='stopRunning'/>" + "!",{
		 	    		title:"<spring:message code='error'/>",
		 	    		closeBtn: 0,
			 	        btn : "<spring:message code='btn.Close'/>",
		 			    yes : function(index, layero) {
		 		         	 layer.close(index);
		 		        },
		 	    	}); 
	  			}
	  	         
	  	         
	  	         
	  	     },
	  	       error: function() {
	  	    	 layer.msg("<spring:message code='Connectionfailure'/>"+"!");
	  	       }
	  	     });	
	}
 
	//2.改变策略绑定控制组
	function changeGroup() {
		layui.use('form',function() {
			 var groupid = ""; //初始化全局变量groupid
			 //var ployid = document.getElementById("getData").value;
			 var ployid = ployidSaveSpace;
			 var form = layui.form;
		     var radio = document.getElementById("changeGroupDiv");
		 	 var inner="";
		 	 for(var i = 0; i < Groups.length; i++) {
		 		inner = inner + "<input type='radio' name='radioChangeGroup' lay-filter='radioFilter'>" + Groups[i].groupName + "</br>";
		 	 }
		 	 radio.innerHTML = inner;
		 	 var aRadio = document.getElementsByName("radioChangeGroup");
		 	 for(var j = 0; j < aRadio.length; j++) {
		 		aRadio[j].value = Groups[j].groupid;
		 	 }
			 layer.open({
				 area : [ '400px', '350px' ],
				 btnAlign : 'l',
				 resize : false,
				 closeBtn : 1,
				 type : 1,
				 title:"<spring:message code='16group'/>",
				 content : $('#changeGroupWindow'),
				 success: function(layero, index) {
			    	//重要：改变绑定弹框内表单渲染；form表单不渲染layui表单控件无法加载；
					 form.render(null,'form1');  
					 form.on('radio(radioFilter)', function(data) {
						 	groupid = data.value;
					 });
				 },
				 btn : "<spring:message code='Confirm'/>",
			     yes : function(index, layero) {
			    	if(groupid != ""){
			    		 $.ajax({
					          type:"post",
					          url:localhost + "/user/changePloyBind.do",
					          data:{
					            id:ployid,
					            bindType: 1,
					            bindData: groupid,
					          },
					          async : true,
					          datatype: "json",
					          success:function(datasource, textStatus, jqXHR) {
					            var data = eval('(' + datasource + ')');
					            if (data.error == null || data.error == "" || data.error == undefined) {//未出错
					            	layer.msg("<spring:message code='successfullyModified'/>"+"!");
					            } else {
					            	if(data.error == "Fail to edit!"){
					            		layer.msg("<spring:message code='failToEdit'/>"+"!");
					            	}
					            }
					          },
					          error: function() {
					        	  layer.msg("<spring:message code='Connectionfailure'/>"+"!");
					          }
						}); 	 
			    	}else{
			    		layer.msg("<spring:message code='UnboundGroup'/>"+"!");
			    	}
			    	//最后清空弹窗内状态
					var radio = document.getElementsByName("radioChangeGroup");  
					for(var i = 0; i < radio.length; i++){
						radio[i].checked = false;
						
					}
					groupid = "";
					form.render(null,'form1');  
						    
					
				 },
				 cancel : function() {	
				 }
			 });
		 });  
	}

	//4.删除策略内的定时广播,需要策略状态停止以后才可以进行删除
	function deleteBroadcastPlan(opdata) {
		var ployid = opdata.ployid;
		var id = opdata.id;//定时广播id
		var status = "";
		if(ployid != "" && ployid != null && ployid != undefined && id != "" && id != null && id != undefined){
			 $.ajax({
		          type:"post",
		          url:localhost + "/user/removePloyOperate.do",
		          data:{
		        	operateid:id,
		        	ployid:ployid,
		        	userid:User.id
		          },
		          async : true,
		          datatype: "json",
		          success:function(datasource, textStatus, jqXHR) {
		            var data = eval('(' + datasource + ')');
		            if (data.error == null || data.error == "" || data.error == undefined) {
		             	 layer.msg("<spring:message code='successfullyDeleted'/>"+"!");
		             	 layui.use(['table'],function() {
		           			 var table = layui.table;
		             		 table.reload('onePloysTable', {
			            		   url:localhost+'/model/ployOperate.do'
			            		   ,where:{
						   	   			 id:ployid
					     	   		 }
			            		});
		             	 });
		            } else {
		            	if(data.error == "Failed to delete!"){
		            		layer.alert("<spring:message code='failedToDelete'/>"+"!",{
		    	 	    		title:"<spring:message code='error'/>",
		    	 	    		closeBtn: 0,
		    		 	        btn : "<spring:message code='btn.Close'/>",
		    	 			    yes : function(index, layero) {
		    	 		         	 layer.close(index);
		    	 		        },
		    	 	    	}); 
		            	}else if(data.error == "Please stop the ploy running"){
		            		layer.alert("<spring:message code='stopRunning'/>"+"!",{
		    	 	    		title:"<spring:message code='Tips'/>",
		    	 	    		closeBtn: 0,
		    		 	        btn : "<spring:message code='btn.Close'/>",
		    	 			    yes : function(index, layero) {
		    	 		         	 layer.close(index);
		    	 		        },
		    	 	    	}); 
		            		}
		            }
		            
		          },
		          error: function() {
		        	layer.msg("<spring:message code='Connectionfailure'/>"+"!");
		        	
		          }
		 
			});  		
		}else{
			layer.alert("<spring:message code='failedToDelete'/>"+"!",{
	    		title:"<spring:message code='error'/>",
	    		closeBtn: 0,
	 	        btn : "<spring:message code='btn.Close'/>",
			    yes : function(index, layero) {
		         	 layer.close(index);
		        },
	    	});
		}
	}

/***************************************用户信息区域的功能函数***************************************/
	//1.更改密码
	function changePassword() {
			document.getElementById("userMessageDiv").style.display = "none";
			document.getElementById("passwordResetDiv").style.display = "block";
		}
	//2.测试设置密码是两次密码输入是否一致，提示错误
	function passwordTest() {
			var passwordTestSpan = document.getElementById("passwordTestSpan");
			var newPassword = document.getElementById("newpassword");
			var rePassword = document.getElementById("repassword");
			if (newPassword.value == rePassword.value) {
				passwordTestSpan.setAttribute('style', 'display: none');
			} else {
				passwordTestSpan.setAttribute('style', 'display: inline; color: red');
			}
		}
		
	//3.修改密码确认按钮
	function changePasswordEnter() {
		  var oldPassword = document.getElementById("oldpassword");
		  var newPassword = document.getElementById("newpassword");
		   	  var rePassword = document.getElementById("repassword");
			  if (newPassword.value == oldPassword.value) {
				  	layer.alert("<spring:message code='Per.newAndOldPasswordEqual'/>",{
		 	    		title:"<spring:message code='error'/>",
			 	        btn : "<spring:message code='btn.Close'/>",
		 			    yes : function(index, layero) {
		 		         	 layer.close(index);
		 		        },
	 	    		}); 
				   	oldPassword.value = "";
				  	newPassword.value = "";
				  	rePassword.value = "";
			      }else if (newPassword.value != rePassword.value) {
			    	 layer.alert("<spring:message code='ChangePasswordErrorTips'/>", {
		 	    		title:"<spring:message code='error'/>",
			 	        btn : "<spring:message code='btn.Close'/>",
		 			    yes : function(index, layero) {
		 		         	 layer.close(index);
		 		        },
	 	    		 }); 
				  	oldPassword.value = "";
				  	newPassword.value = "";
				  	rePassword.value = "";
			      }else if (newPassword.value == "" || newPassword.value == null) {
				  	layer.alert("<spring:message code='newPasswordUnempty'/>"+"!", {
		 	    		title:"<spring:message code='error'/>",
			 	        btn : "<spring:message code='btn.Close'/>",
		 			    yes : function(index, layero) {
		 		         	 layer.close(index);
		 		        },
	 	    		}); 
				  	oldPassword.value = "";
				  	newPassword.value = "";
				  	rePassword.value = "";
			      } else {
			        $.ajax({
			          type:"post",
			          url:localhost + "/user/changePassword.do",
			          data:{
			            userid:User.id,
			            oldPassword:oldPassword.value,
			            newPassword:newPassword.value
			          },
			          async : true,
			          datatype: "json",
			          success:function(datasource, textStatus, jqXHR) {
			            var data = eval('(' + datasource + ')');
			            if (data.error == null || data.error == "" || data.error == undefined) {//未出错
			            	layer.msg("<spring:message code='Per.passwordModifiedSuccessfully'/>");
			            	window.location.href = localhost + "/jsp/login_en.jsp";
			            	 
			            } else {
			            	switch(data.error){
						      case 'Failed to change password':
						    	  layer.alert("<spring:message code='Per.changePasswordFailed'/>",{
						 	    		title:"<spring:message code='error'/>",
							 	        btn : "<spring:message code='btn.Close'/>",
						 			    yes : function(index, layero) {
						 		         	 layer.close(index);
						 		        },
						 	    	}); 
						      	  break;
						      case 'Incorrect password':
						    	  layer.alert("<spring:message code='incorrectPassword'/>",{
						 	    		title:"<spring:message code='error'/>",
							 	        btn : "<spring:message code='btn.Close'/>",
						 			    yes : function(index, layero) {
						 		         	 layer.close(index);
						 		        },
						 	    	}); 
						          break;
						      case 'User does not exist':
						    	  layer.alert("<spring:message code='userUnexist'/>",{
						 	    		title:"<spring:message code='error'/>",
							 	        btn : "<spring:message code='btn.Close'/>",
						 			    yes : function(index, layero) {
						 		         	 layer.close(index);
						 		        },
						 	    	}); 
						          break;
					     	};
			            	
					     	
			            }
			          },
			          error: function() {
			        	 layer.alert("<spring:message code='Connectionfailure'/>",{
				 	    		title:"<spring:message code='error'/>",
					 	        btn : "<spring:message code='btn.Close'/>",
				 			    yes : function(index, layero) {
				 		         	 layer.close(index);
				 		        },
				 	    	}); 
			          }
			        });
			      }
		
		changePasswordCancel(); // 清空输入框
	}
	
	//4.修改密码取消按钮，重置修改密码输入框	
	function changePasswordCancel() {
	  document.getElementById("oldpassword").value = "";
	  document.getElementById("newpassword").value = "";
	  document.getElementById("repassword").value = "";
	}

	//5.退出登录；返回到与当前语言环境对应的登录页面
	function ExitCount(){
 		 location.href = localhost + "/user/Exit.do";
 	}
 	
/********************************语言切换********************************/
	//1.英文环境
	function English() {
		$.ajax({
	          type:"post",
	          url:localhost + "/user/language.do",
	          data:{
	            username:User.username,
	            lang:"en_US"
	          },
	          async : true,
	          datatype: "json",
	          success:function(datasource, textStatus, jqXHR) {
	        	  location.reload();
	        	
          		},
	          error: function() {
	        	  layer.alert("<spring:message code='PER.languageSetFail'/>" + "!",{
		 	    		title:"<spring:message code='error'/>",
			 	        btn : "<spring:message code='btn.Close'/>",
		 			    yes : function(index, layero) {
		 		         	 layer.close(index);
		 		        },
		 	    	}); 
	          }
	        });
 	}
	
	
	//2.中文环境
	function Chinese(){
		$.ajax({
	          type:"post",
	          url:localhost + "/user/language.do",
	          data:{
	            username:User.username,
	            lang:"zh_CN"
	          },
	          async : true,
	          datatype: "json",
	          success:function(datasource, textStatus, jqXHR) {
	        	  location.reload();
        		},
	          error: function() {
	        	  layer.alert("<spring:message code='PER.languageSetFail'/>" + "!",{
	        		  title:"<spring:message code='error'/>",
			 	      btn : "<spring:message code='btn.Close'/>",
		 			  yes : function(index, layero) {
		 		         	 layer.close(index);
		 		        },
		 	    	}); 
	          	}
        		
	     });
 	}
 	
	
	</script> 
	
<%-- **********************Control与Node表格的toolbar或templet *********************** --%>
	<script type="text/html" id="toolbarControllers">   
		<div class="layui-btn-container">	
			<button class="layui-btn layui-btn-sm"  lay-event="addDev"><spring:message code="AddController" /></button>
    		<button class="layui-btn layui-btn-sm"  lay-event="removeDev"><spring:message code="DeleteController" /></button>
   			<button class="layui-btn layui-btn-sm"  lay-event="renameDev"><spring:message code="RenameController" /></button>
  		</div>
    </script>
    
<!-- 广播控制显示三个按钮，ON.OFF,DIM，不根据广播状态进行改变    
	<script  type="text/html" id="barBroadcast"> 
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="openBroadcast"><spring:message code="ON" /></a>
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="closeBroadcast"><spring:message code="OFF" /></a>
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="dimBroadcast"><spring:message code="DIM" /></a>
    </script>
    			-->
<!-- 添加判断集控器广播的状态，页面广播按钮显示两种不同的情况，1.广播按钮为ON,DIM; 2.广播按钮为OFF,DIM -->
	<script  type="text/html" id="barBroadcast">
		 {{#  if(d.switchStatus == 1){ }}
			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="closeBroadcast"><spring:message code="OFF" /></a>
  			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="dimBroadcast"><spring:message code="DIM" /></a>
    	 {{#  } else { }}
			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="openBroadcast"><spring:message code="ON" /></a>
  			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="dimBroadcast"><spring:message code="DIM" /></a>
    	 {{#  } }}
    </script>
    <script type="text/html" id="toolbarNodesTable">   
		<div class="layui-btn-container">	
    		<button class="layui-btn layui-btn-sm"  lay-event="removeOfflineZigbee"><spring:message code="DeleteNode" /></button>
   			<button class="layui-btn layui-btn-sm"  lay-event="renameZigbee"><spring:message code="RenameNode" /></button>
  		</div>
    </script>
   
<!--     
	<script  type="text/html" id="barZigbeeBroadcast">
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="openZigbeeBroadcast"><spring:message code="ON" /></a>
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="closeZigbeeBroadcast"><spring:message code="OFF" /></a>
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="dimZigeeBroadcast"><spring:message code="DIM" /></a>
    </script>
    			 -->
	<!--     同集控器广播控制一样的原理 -->
    <script  type="text/html" id="barZigbeeBroadcast">
		 {{#  if(d.zigbeeStatus == 1){ }}
			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="closeZigbeeBroadcast"><spring:message code="OFF" /></a>
  			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="dimZigeeBroadcast"><spring:message code="DIM" /></a>
    	 {{#  } else { }}
			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="openZigbeeBroadcast"><spring:message code="ON" /></a>
  			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="dimZigeeBroadcast"><spring:message code="DIM" /></a>
    	 {{#  } }}
    </script>
    
<%--***********************Group表格的toolbar或templet ******************************* --%>  
    <script type="text/html" id="toolbarGroups">   
		<div class="layui-btn-container">	
			<button class="layui-btn layui-btn-sm"  lay-event="addGroup"><spring:message code="AddGroup" /></button>
    		<button class="layui-btn layui-btn-sm"  lay-event="removeGroup"><spring:message code="DeleteGroup" /></button>
   			<button class="layui-btn layui-btn-sm"  lay-event="renameGroup"><spring:message code="RenameGroup" /></button>
  		</div>
    </script>
<!--   同集控器广播注释 
	<script  type="text/html" id="barGroupBroadcast"> 
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="openGroupBroadcast"><spring:message code="ON"/></a>
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="closeGroupBroadcast"><spring:message code="OFF" /></a>
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="dimGroupBroadcast"><spring:message code="DIM"/></a>
    </script>
    			-->
    <script  type="text/html" id="barGroupBroadcast"> 
		 {{#  if(d.switchStatus == 1){ }}
			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="closeGroupBroadcast"><spring:message code="OFF" /></a>
  			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="dimGroupBroadcast"><spring:message code="DIM"/></a>
    	 {{#  } else { }}
			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="openGroupBroadcast"><spring:message code="ON"/></a>
  			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="dimGroupBroadcast"><spring:message code="DIM"/></a>
    	 {{#  } }}
    </script>
    <script  type="text/html" id="toolbarOneGroup">
  		<div class="layui-btn-container">
			<button class="layui-btn layui-btn-sm"  lay-event="addZigbee"><spring:message code="AddNode"/></button>
    		<button class="layui-btn layui-btn-sm"  lay-event="removeZigbee"><spring:message code="DeleteNode"/></button>
   			<button class="layui-btn layui-btn-sm"  lay-event="zigbeeTableRenameGroup"><spring:message code="RenameGroup"/></button>
  		</div>
    </script>
<!--
	<script  type="text/html" id="barSingleZbBroadcast"> 
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="openZbBroadcastInGroup"><spring:message code="ON" /></a>
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="closeZbBroadcastInGroup"><spring:message code="OFF" /></a>
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="dimZbBroadcastInGroup"><spring:message code="DIM" /></a>
    </script>  
				-->
	<script  type="text/html" id="barSingleZbBroadcast"> 
		 {{#  if(d.zigbeeStatus == 1){ }}
			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="closeZbBroadcastInGroup"><spring:message code="OFF" /></a>
  			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="dimZbBroadcastInGroup"><spring:message code="DIM" /></a>
    	 {{#  } else { }}
			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="openZbBroadcastInGroup"><spring:message code="ON" /></a>
  			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="dimZbBroadcastInGroup"><spring:message code="DIM" /></a>
    	 {{#  } }}
    </script>  
 <%-- **********************Ploy表格的toolbar或templet *********************** --%>    
 	<script type="text/html" id="toolbarPloys">   
		<div class="layui-btn-container">	
			<button class="layui-btn layui-btn-sm"  lay-event="addPloy"><spring:message code="AddPloy"/></button>
    		<button class="layui-btn layui-btn-sm"  lay-event="removePloy"><spring:message code="DeletePloy"/></button>
   			<button class="layui-btn layui-btn-sm"  lay-event="renamePloy"><spring:message code="RenamePloy"/></button>
  		</div>
    </script>
    <script type="text/html" id="temPloyControl">
   		 {{#  if(d.status == 1){ }}
      		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="stopPloy"><spring:message code="Stop"/></a>
    	 {{#  } else { }}
			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="runPloy"><spring:message code="Run"/></a>
    	 {{#  } }}
    </script> 
    <script type="text/html" id="toolbarOnePloy">   
		<div class="layui-btn-container">	
			<button class="layui-btn layui-btn-sm"  lay-event="addBroadcastPlan"><spring:message code="AddBroadcast"/></button>
   			<button class="layui-btn layui-btn-sm"  lay-event="changeGroup"><spring:message code="ChangeGroup"/></button>
  		</div>
    </script>
     <script  type="text/html" id="barDeleteBroadcast">
  		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="deleteBroadcastPlan"><spring:message code="Delete"/></a>
    </script>
</body>
</html>
