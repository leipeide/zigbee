package com.test.domain;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;

public class SendJMail {
	public boolean SendMail(String email, String emailMsg) {
		Logger log = Logger.getLogger("D");
		String sender = "leipeideyf@163.com";          //发件人的邮箱地址
		final String username = "leipeideyf@163.com"; //发件人的邮箱账户
		final String password = "NDOEAYWQOTENTHQH"; //发件人的邮箱授权码，注意，不是邮箱的登陆密码
		
		String receiver = email; //收件人的邮箱地址
		
		/*
		String sender = "yl_free@163.com";         //发件人的邮箱地址
		final String username = "yl_free@163.com"; //发件人的邮箱账户
		final String password = "EXXFDYMUYMIYUYHB";        //18080服务器发件人的邮箱授权码，注意，不是邮箱的登陆密码
		*/
		
		//定义properties对象，设置环境信息
		Properties props =  new Properties();
		//设置邮件服务器的地址
		props.setProperty("mail.smtp.auth", "true");
		props.setProperty("mail.transport.protocol", "smtp"); //设置发送邮件使用的协议
		props.setProperty("mail.smtp.host", "smtp.163.com"); //指定的smtp服务器
		props.setProperty("mail.debug", "false");//启用调试
		props.setProperty("mail.smtp.port", "465");//设置端口
		props.setProperty("mail.smtp.socketFactory.port", "465");//设置ssl端口
		props.setProperty("mail.smtp.socketFactory.fallback", "false");
		props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

		//创建sessoin对象，session对象表示整个邮件的环境信息
		Session session = Session.getInstance(props);
		try {
			//message的实例对象表示一封电子邮件
			MimeMessage message = new MimeMessage(session);
			//设置发件人的地址
			message.setSender(new InternetAddress(sender)); 
			//设置主题
			message.setSubject("Please check the verification code(请查收验证码)");
			//设置接收者
			try {
				message.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(receiver, "尊敬的用户", "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//设置邮件的文本内容
			message.setContent(emailMsg, "text/html;charset=utf-8");
			//从session中获取发送邮件的对象
			Transport transport = session.getTransport();
			//连接邮件服务器
			//transport.connect("smtp.163.com",587,username,password);
			transport.connect(username,password);
			//设置收件人地址，并发送信息
			//transport.sendMessage(message, new Address[]{new InternetAddress(receiver)});
			transport.sendMessage(message, message.getAllRecipients());
			transport.close();
			return true;
			
		
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		
	
	}
}
