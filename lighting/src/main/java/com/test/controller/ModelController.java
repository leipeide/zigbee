package com.test.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.test.domain.LayuiTableModel;
import com.test.service.IModelService;
import com.test.service.socket.DeviceSocket;

@Controller
@RequestMapping("/model")
public class ModelController {

	@Resource 
	//按照名称注入
	private IModelService modelService;
	
	private Logger log = Logger.getLogger("D");

	public ModelController() {

	}

	private void myprint(DeviceSocket ds, String cmd) throws IOException {
		PrintWriter out = new PrintWriter(ds.getSocket().getOutputStream());// 得到输出流
		out.print(cmd);
		out.flush();
		// System.out.println("server to " + ds.getDevice().getDevMac() + ": " + cmd);
		log.info("server to " + ds.getDevice().getDevMac() + ": " + cmd);
	}
	@RequestMapping("/devices") // 根据用户id获取集控器列表
	public void devices(HttpServletRequest request, HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");  
	    response.setContentType("application/json; charset=utf-8");  
		String userid = request.getParameter("userid");
		String page = request.getParameter("page");
		String limit = request.getParameter("limit");
//		System.out.println("userid=" + userid + "  page=" + page + "  limit=" + limit);
		if (userid == null || page == null || limit== null) {
			LayuiTableModel model = new LayuiTableModel();
			model.setCode(2);
			model.setMsg("参数不能为空！");
			try {
				response.getWriter().write(JSONObject.toJSONString(model));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return;
		}
		LayuiTableModel ltmodel = modelService.getDeviceTableDataByUserid(Integer.parseInt(userid), Integer.parseInt(page), Integer.parseInt(limit));
		String dataJson = JSONObject.toJSONString(ltmodel);
//		System.out.println(dataJson);
		try {
			response.getWriter().write(dataJson);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
