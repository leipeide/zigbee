/*
function addDev(){
    	  alert("add集控器function");
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
	  			            	//alert("success");
	  			              var data = eval('(' + datasource + ')');
	  			              //alert(data.error);
	  			              if (data.error == null || data.error == "" || data.error == undefined) {//未出错
	  			            	  layer.msg('Added successfully!', function(){
	  			            		  //do something
	  			            		  document.getElementById("addDevInput").value = " ";
	  			            		  //location.reload();
	  			            		}); 
	  			                //userDataRefresh(user, data);用户数据刷新有待考虑
	  			              } else {
	  			            	  layer.msg(data.error, function(){
	  			            		  //do something
	  			            		  document.getElementById("addDevInput").value = " ";
	  			            		}); 
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
	 function removeDev(devMac,userid,devName){
	      alert("removeDev");
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
	  			            		//layer.close(index);
	  			            		//location.reload();
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
	  					            		  /*重载device表格*/
	  					            		/*  table.reload('allDeviceTable', {
	  		  			            		      url: localhost+'/model/devices.do'
	  		  			            		     ,where: {userid = User.id} //设定异步数据接口的额外参数
	  		  			            		  });*/
	  					              } else {
	  					            	  layer.msg(data.error, function(){
	  					            		  //do something
	  					            		  document.getElementById("renameDevInput").value = " ";
	  					            		}); 
	  					              	}
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