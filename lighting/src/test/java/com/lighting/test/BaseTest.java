package com.lighting.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.test.dao.DeviceMapper;
import com.test.dao.ZigbeeMapper;
import com.test.domain.Device;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration("src/main/resouces")
@ContextConfiguration(locations = { "classpath:spring-mybatis.xml", "classpath:spring-mvc.xml" })
public class BaseTest {
	@Autowired
	private DeviceMapper devDao;
	
	@Autowired
	private ZigbeeMapper zigbeeDao;

	@Test
	public void test() {
		System.out.println(devDao);
	}

	@Test
	public void selectDeviceNumberOfUserTest() {
		int num = devDao.selectDeviceNumberOfUser(100000);
		System.out.println(num);
	}

	@Test
	public void selectDeviceByUseridPagedTest() {
		List<Device> list = devDao.selectByUseridPaged(100000, 0, 10);
		for (Device device : list) {
			System.out.println(device);
		}
	}

	@Test
	public void selectZigbeeNumberByDeviceTest() {
		int num =  zigbeeDao.selectZigbeeNumberByDeviceMac("dev1");
		int offlineNum = zigbeeDao.selectZigbeeNumberByDeviceMacAndOnlineStatus("dev1", 1);
		System.out.println("zigbeenum:" + num);
		System.out.println("zigbeeonlinenum:" + offlineNum);
	}
}
