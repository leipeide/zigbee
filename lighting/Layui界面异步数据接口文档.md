# Layui界面异步数据接口文档

## 描述
该文档为Layui前端框架中table控件的数据接口文档。应用于zigbee控制系统的界面重构。

## 接口

### 1. 用户集控器数据查询

#### 1.1 接口说明

用户首页显示的集控器table的数据来源。

#### 1.2 接口地址

| 参数     | 描述                          |
| -------- | ----------------------------- |
| 接口地址 | /model/devices.do（相对路径） |
| 请求方式 | GET                           |

#### 1.3 请求参数

| 参数   | 名称     | 类型   | 描述                         | 示例值 |
| ------ | -------- | ------ | ---------------------------- | ------ |
| userid | 用户id   | Number | 用户id                       | 100000 |
| page   | 页码     | Number | 要查询的用户集控器数据的页码 | 1      |
| limit  | 数据长度 | Number | 进行分页查询的页面数据长度   | 10     |

#### 1.4 返回结果

##### 1.4.1 外层
| 参数  | 名称       | 类型   | 描述                        | 示例值         |
| ----- | ---------- | ------ | --------------------------- | -------------- |
| code  | 请求状态码 | Number | 成功返回为0，失败参考msg    | 0              |
| count | 数据长度   | Number | 用户的所有集控器数量        | 2              |
| msg   | 提示信息   | String | 当code不为0时，输出错误信息 | 参数不能为空！ |
| data  | json数据   | Array  | 集控器的数据对象集合        | 见下表1.4.2    |

##### 1.4.2 dataArray的数据结构

| 参数         | 名称           | 类型   | 描述                             | 示例值           |
| ------------ | -------------- | ------ | -------------------------------- | ---------------- |
| devMac       | 集控器mac地址  | String | 设备唯一标识                     | 02AB1205004B1200 |
| devName      | 集控器名称     | String | 设备名称                         | 02AB1205004B1200 |
| devNet       | 集控器网络状态 | Number | 在线为1，离线为0                 | 1                |
| gprsPhone    | 电话号码       | String | 设备sim卡电话号码                | 13116708817      |
| offlineNodes | 离线节点数量   | Number | 连接在集控器上的离线灯具节点数量 | 4                |
| onlineNodes  | 在线节点数量   | Number | 链接在集控器上的在线灯具节点数量 | 0                |
| userid       | 用户id         | Number | 使用该集控器的用户id             | 100000           |
| zigbeeFinder | 节点发现开关   | Number | 0关闭，1打开                     | 0                |

#### 1.5 调取示例

##### 1.5.1 调取成功

```
{
  "code": 0,
  "count": 2,
  "data": [
    {
      "devMac": "02AB1205004B1200",
      "devName": "02AB1205004B1200",
      "devNet": 0,
      "gprsPhone": "13116708817",
      "offlineNodes": 4,
      "onlineNodes": 0,
      "userid": 100000,
      "zigbeeFinder": 0
    },
    {
      "devMac": "03AB1205004B1200",
      "devName": "03AB1205004B1200",
      "devNet": 1,
      "gprsPhone": "unknown",
      "offlineNodes": 0,
      "onlineNodes": 0,
      "userid": 100000
    }
  ],
  "msg": ""
}
```

##### 1.5.2 调取失败

```
{
  "code": 1,
  "count": 0,
  "data": [
    
  ],
  "msg": "数据读取越界！"
}
```

### 2. 灯具节点数据查询

#### 2.1 接口说明

点击集控器后，进入到集控器详情界面，显示链接在集控器的灯具节点table的数据来源。返回的数据已经根据在线状态进行排序，先返回在线节点，后返回离线节点。

#### 2.2 接口地址

| 参数     | 描述                         |
| -------- | ---------------------------- |
| 接口地址 | /model/zigbee.do（相对路径） |
| 请求方式 | GET                          |

#### 2.3 请求参数

| 参数   | 名称          | 类型   | 描述                             | 示例值 |
| ------ | ------------- | ------ | -------------------------------- | ------ |
| devMac | 集控器mac地址 | String | zigbee链接的集控器的mac地址      | 100000 |
| page   | 页码          | Number | 要查询的zigbee灯具节点数据的页码 | 1      |
| limit  | 数据长度      | Number | 进行分页查询的页面数据长度       | 10     |

#### 2.4 返回结果

##### 2.4.1 外层
| 参数  | 名称       | 类型   | 描述                         | 示例值         |
| ----- | ---------- | ------ | ---------------------------- | -------------- |
| code  | 请求状态码 | Number | 成功返回为0，失败参考msg     | 0              |
| count | 数据长度   | Number | 集控器下的所有节点数量       | 2              |
| msg   | 提示信息   | String | 当code不为0时，输出错误信息  | 参数不能为空！ |
| data  | json数据   | Array  | zigbee灯具节点的数据对象集合 | 见下表2.4.2    |

##### 2.4.2 dataArray的数据结构

| 参数         | 名称          | 类型   | 描述                                                  | 示例值           |
| ------------ | ------------- | ------ | ----------------------------------------------------- | ---------------- |
| devMac       | 集控器mac地址 | String | 设备唯一标识                                          | 02AB1205004B1200 |
| humidity     | 湿度          | Number | 空气湿度，单位%，放大100倍后结果                      | 0                |
| temperature  | 温度          | Number | 空气温度，单位°C，放大100倍后结果                     | 0                |
| zigbeeBright | 亮度          | Number | 灯具输出的pwm占空比，范围0-100                        | 100              |
| zigbeeMac    | 节点mac地址   | String | 灯具唯一标识，primarykey                              | 0316CE0A004B1200 |
| zigbeeName   | 节点名称      | String | 节点名称                                              | 0316CE0A004B1200 |
| zigbeeNet    | 节点网络状态  | Number | 0离线，1在线                                          | 0                |
| zigbeeSaddr  | 节点短地址    | String | 节点在zigbee网络中的通讯地址，不需要显示              | 467F             |
| zigbeeStatus | 开关状态      | Number | 灯具输出使能，1打开，0关闭                            | 1                |
| minPower     | 最小输出      | Number | 功率输出最小值（某些灯具pwm输出0时功率为50%而不是0%） | 50               |
| power        | 额定功率      | Number | pwm输出100%时，灯具的额定功率，单位W                  | 1000             |
| type         | 灯具类型      | Number | 参见附表1                                             | 1                |
| version      | 软件版本号    | String | 灯具当前使用的软件版本号                              | 01               |

#### 2.5 调取示例

##### 2.5.1 调取成功

```
{
  "count": 4,
  "data": [
    {
      "devMac": "02AB1205004B1200",
      "humidity": 0,
      "temperature": 0,
      "zigbeeBright": 100,
      "zigbeeMac": "0316CE0A004B1200",
      "zigbeeName": "0316CE0A004B1200",
      "zigbeeNet": 0,
      "zigbeeSaddr": "467F",
      "zigbeeStatus": 1
    },
    {
      "devMac": "02AB1205004B1200",
      "zigbeeBright": 100,
      "zigbeeMac": "240FCE0A004B1200",
      "zigbeeName": "240FCE0A004B1200",
      "zigbeeNet": 0,
      "zigbeeSaddr": "CF1D",
      "zigbeeStatus": 1
    },
    {
      "devMac": "02AB1205004B1200",
      "humidity": 6000,
      "minPower": 50,
      "power": 1000,
      "temperature": 3652,
      "type": 1,
      "version": "01",
      "zigbeeBright": 50,
      "zigbeeMac": "4817CE0A004B1200",
      "zigbeeName": "4817CE0A004B1200",
      "zigbeeNet": 0,
      "zigbeeSaddr": "0AE4",
      "zigbeeStatus": 0
    },
    {
      "devMac": "02AB1205004B1200",
      "humidity": 0,
      "temperature": 0,
      "zigbeeBright": 100,
      "zigbeeMac": "CBA8AF14004B1200",
      "zigbeeName": "CBA8AF14004B1200",
      "zigbeeNet": 0,
      "zigbeeSaddr": "64A7",
      "zigbeeStatus": 1
    }
  ]
}
```

##### 2.5.2 调取失败

```
{
  "code": 2,
  "msg": "参数不能为空！"
}
```

## 附表1 -- zigbee.type

| 参数值 | 灯具类型                 | 调光范围                         |
| ------ | ------------------------ | -------------------------------- |
| 1      | 钠灯                     | 50 - 100                         |
| 2      | 金卤灯                   | 50-100                           |
| 3      | led灯                    | 0-100                            |
| 17     | 钠灯+SHT10温湿度传感器   | 50 - 100                         |
| 18     | 金卤灯+SHT10温湿度传感器 | 50-100                           |
| 19     | led灯+SHT10温湿度传感器  | 0-100                            |
| 33     | SHT10温湿度传感器        | Temperature range: -50°C - 125°C |
| NULL   | unknown                  | Dimming range: 0 - 100           |
