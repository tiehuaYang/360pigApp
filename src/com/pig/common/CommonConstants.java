package com.pig.common;

public interface CommonConstants {
   public static String SALT = "mtoon-officialWebsite";
   public static String SESSION_USER_KEY = "USERVO";
   public static String SESSION_LOGINNAME = "LOGINNAME";
   public static String DB_CHAR_YES = "Y";
   public static String DB_CHAR_NO = "N";
   public static String REF_UUID_SEPERATOR = "|";

   //solrURL
   public static String SOLR_URL = "http://127.0.0.1:8080";

   //本地测试的
   public static String BREED_data = "jdbc:mysql://192.168.0.99/easyTransfer";
   public static String BREED_DATA_USERNAME = "mtoon";
   public static String BREED_DATA_PASSWORD = "mtoon123";

   //线上的
   //public static String BREED_data = "jdbc:mysql://rm-wz9m9ocb60e34c9hso.mysql.rds.aliyuncs.com:3306/easytransfer";
   //public static String BREED_DATA_USERNAME = "mutoon";
   //public static String BREED_DATA_PASSWORD = "Mutong2016#123";

   public static class USER {
      public static String USER_LEVEL_ENTERPRISE = "ENTERPRISE";
      public static String USER_LEVEL_PERSONAL = "PERSONAL";
      //用户类型
      public static String USER_TYPE_SUPPLY = "SUPPLY";
      public static String USER_TYPE_SALES = "SALES";
      public static String USER_TYPE_BUSINESS = "BUSINESS";

      //系统管理员
      public static String ROOTUSERNAME = "root";
      public static String ROOTPASSWORD = "0dd44f7ebffe5eb7045503150bc36b058ddb6ba630a66081d7bc061058663e6d";
      public static String ROOTSALT = "ca0b7b2fb03842319e5759cc438de595";
   }

   public static class ORDER {
      //订单状态
      public static String ORDER_STATE_INITCHECK = "1";//待订单审核
      public static String ORDER_STATE_FINACECHECK = "2";//待财务审核
      public static String ORDER_STATE_STORECHECK = "3";//待出库审核
      public static String ORDER_STATE_TRANSFERCHECK = "4";//待发货审核
      public static String ORDER_STATE_RECEIVECHECK = "5";//待收货确认
      public static String ORDER_STATE_RECEIPT = "6";//确认入库
      public static String ORDER_STATE_FINISH = "0";//最终完成
      public static String ORDER_STATE_CANCEL = "9";//订单作废

      //出库/发货状态
      public static String TRANSFER_STATE_PREPARE = "PREPARE";//备货中/待发货
      public static String TRANSFER_STATE_PREPAREED = "PREPAREED";//已出库/待发货
      public static String TRANSFER_STATE_OUT = "OUT";// 已出库/已发货

      //付款状态
      public static String PAID_STATE_NOTPAID = "N";//未付款
      public static String PAID_STATE_PAIDED = "Y";//已付款
      public static String PAID_STATE_PART = "P";//部分付款
      public static String PAID_STATE_CONFIRM = "C";//付款待确认

      //付款方式
      public static String PAID_TYPE_OFFLINE = "OFFLINE";//线下转账
      public static String PAID_TYPE_FINANCING = "FINANCING";//融资账户
      public static String PAID_TYPE_ONLINE = "ONLINE";//线上支付
      public static String PAID_TYPE_ACCOUNT = "ACCOUNT";//账户余额支付

      public static String P = "P";//当前页
      public static String H = "H";//历史页
      //付款记录状态
      public static String PAY_RECORD_PAID = "PAID";//已付款
      public static String PAY_RECORD_BAND = "BAND";//已作废
      public static String PAY_RECORD_CONFIRM = "CONFIRM";//待确认
   }

   public static class RETURN {
      public static String ORDER_STATE_RETURN = "1";//退货审核
      public static String ORDER_STATE_INRETURN = "2";//入库确认
      public static String ORDER_STATE_RETURNPAY = "3";//退款审核
      public static String ORDER_STATE_INRETURNPAY = "4";//退款确认

      //退款状态
      public static String PAREID_STATE_NOTPAID = "N";//未退款
      public static String PAREID_STATE_PAIDED = "Y";//已退款
      public static String PAREID_STATE_PART = "P";//部分退款

      public static String P = "P";//原本
      public static String H = "H";//历史

      public static String PAY_RECORD_PAID = "PAID";//已退款
      public static String PAY_RECORD_BAND = "BAND";//已作废

   }

   public static class Serial {
      public static String TYPE_ORDER_CODE = "order";//订单流水号
      public static String TYPE_RETURN_CODE = "return";
      public static String TYPE_INVENTORY_CODE = "inventory";//出入库流水号
      public static String TYPE_STOCK_CODE = "stock";//物料出入库
      public static String TYPE_TRADE_CODE = "trade";//交易流水号
      public static String TYPE_TASK_CODE = "task";//任务批次号
      public static String TYPE_QUARANTINE_CODE = "quarantine";//检疫单号
      public static String TYPE_IMMUNE_CODE = "immune";//检疫单号
   }

   public static class Summery {
      public static String DATE_TYPE_MONTH = "1";
      public static String DATE_TYPE_PREMONTH = "2";
      public static String DATE_TYPE_WEEK = "3";
      public static String DATE_TYPE_PREWEEK = "4";
      public static String DATE_TYPE_CUSTOM = "0";
   }

   public static class Alarm {
      public static String ALARM_TYPE_BREED = "BREED";
      public static String ALARM_LEVEL_NORMAL = "NORMAL";
      public static String ALARM_LEVEL_IMPORTANT = "IMPORTANT";
      public static String ALARM_LEVEL_EMERGENCY = "EMERGENCY";
   }

   public static class SESSION {
      //购物车
      public static String SHOPPING_CART_LIST = "SHOPPINGCART_LIST";//购物车
      public static String SHOPPING_CART_COUNT = "SHOPPINGCART_COUNT";//购物车中的商品种类数

      //告警信息
      public static String ALARM_COUNT = "ALARMCOUNT";//最新告警数统计
      public static String ALARM_LIST = "ALARMLIST";//最新告警列表

      //短信
      public static String SESSION_VERIFICATIONCODE = "VERIFICATIONCODE";
      public static String SESSION_PHONE = "PHONE";
   }

   public static class GOOD {
      public static String STATE_VALID = "0";
      public static String STATE_INVALID = "1";
   }

   public static class MATERIAL {
      public static String STATE_VALID = "0";
      public static String STATE_INVALID = "1";
   }

   public static class ROLE {
      //角色名称
      public static String ROLE_ADMIN = "admin";//管理员
      public static String ROLE_BUS = "business";//业务负责人
      public static String ROLE_ORDER = "order";//订单审核员
      public static String ROLE_FIN = "finacal";//财务审核员
      public static String ROLE_DEL = "deliver";//发货审核员
      public static String ROLE_SALES = "sales";//业务员（业务经理）

      public static String ROLE_CATE = "category";//仓库管理员
      public static String ROLE_FILE = "file";//资料维护员
      public static String ROLE_U1 = "udefine1";//自定义角色一
      public static String ROLE_U2 = "udefine2";//自定义角色二

   }

   //默认分页大小
   public static int DEFAULT_PAGE_SIZE = 10;

   //计划细项的天数分页
   public static int BREED_STANDARD_DAY_PAGE = 30;

   //临时上传文件路径
   public static String UPLOAD_FILE_DIRECTORY_NAME = "uploadTemp";

   public static String UPLOAD_IMG_DIR = "/uploadImg";

   public static String UPLOAD_EDITORIMG_DIR = "/img/uploadImg";

   public static String TWO_DIMENSION_DIR = "/qrCode";

   public static String ORIGINS_TWO_DIMENSION_DIR = "/oqrCode";

   public static String INORIGINS_TWO_DIMENSION_DIR = "/inOQRCode";

   public static String OUTORIGINS_TWO_DIMENSION_DIR = "/outOQRCode";

   public static int LOGO_MAX_SIZE = 10 * 600 * 1024; // 最大上传文件，不超过600k

   public static int RANDOM_SIGNATURE_LENGTH = 10;

   //用于微信接入
   public static String APP_ID = "wxbf9d6bf2c5e525bd";
   public static String APP_SECRET = "594d5beeffd78a51733624497a41e7b8";
   public static String DOMAIN = "http://testjava.chiefdom.net";

   //默认类别及默认单位
   public static String DEFAULTGOODSTYPE = "未设置";
   public static String DEFAULTGOODSUNIT = "未设置";

   //设置后台主题
   public static String THEME = "sidebar-icons"; //sidebar-icons  sidebar-default  sidebar-colors  sidebar-collapsed

   //阿里大于短信服务
   public static String ALIDAYU_URL = "http://gw.api.taobao.com/router/rest";   //正式环境
   public static String ALIDAYU_APPKEY = "23546874";    //appkey
   public static String ALIDAYU_SECRET = "e0c4929370a45ba85ee5966e914d69c8";    //secret
   public static String ALIDAYU_SIGNNAME = "牧通科技信息";    //短信签名
   public static String ALIDAYU_TEMPLATECODE = "SMS_31535044"; //短信模板

   //七牛云
   public static String ACCESSKEY = "1qKtP4A8sXNks4uGoXsoInwhX1HyoAyIfjbcA2DQ";
   public static String SECRETKEY = "0zI25WgYeB3-6FZOHoqWYnS2eiVzGJiUrAQhHzrs";

   //正式环境

/*   //外链默认域名
public static String QIMGS = "http://imgs.mtoon.com.cn";
public static String QQRCODE = "http://qrcode.mtoon.com.cn";
public static String QUPLOADIMG = "http://uploadimg.mtoon.com.cn";
public static String QOQRCODE = "http://oqrcode.mtoon.com.cn";

//存储空间
public static String PQIMGS = "imgs";
public static String PQQRCODE = "qrcode";
public static String PQUPLOADIMG = "uploadimg";
public static String PQOQRCODE = "oqrcode";

//溯源二维码接口
public static String OQRCODEAPI = "http://culture.mtoon.com.cn/app/getOutOriginsInfo?taskId=";*/

   //测试环境

   //外链默认域名
   public static String QIMGS = "http://oyd88541v.bkt.clouddn.com";
   public static String QQRCODE = "http://oyd88541v.bkt.clouddn.com";
   public static String QUPLOADIMG = "http://oyd88541v.bkt.clouddn.com";
   public static String QOQRCODE = "http://oyd88541v.bkt.clouddn.com";

//存储空间
   public static String PQIMGS = "test";
   public static String PQQRCODE = "test";
   public static String PQUPLOADIMG = "test";
   public static String PQOQRCODE = "test";

//溯源二维码接口
   public static String OQRCODEAPI = "http://192.168.0.10:8080/argcom/app/scannerOutOriginsInfo?taskId=";

   //成员类型
   public static int MANAGER = 1;   // 管理员
   public static int TECHNICIAN = 2;    //技术人员
   public static int COMMON = 3;    //普通成员

   public static String MANAGERSTR = "管理员";
   public static String TECHNICIANSTR = "技术人员";
   public static String COMMONSTR = "普通成员";

   public static class PIG {
      //猪性别
      public static String PIG_SEX_MALE = "0";//公猪
      public static String PIG_SEX_FEMALE = "1";//母猪
      public static String PIG_SEX_PIGLET_MALE = "2";//公仔猪
      public static String PIG_SEX_PIGLET_FEMALE = "3";//母仔猪

      //猪状态
      public static String PIG_STATE_RESERVE = "1";//后备 (公/母)
      public static String PIG_STATE_PREGNANT = "2";//怀孕
      public static String PIG_STATE_CHILDBIRTH = "3";//分娩
      public static String PIG_STATE_RETURN = "4";//返情 (待配种)
      public static String PIG_STATE_ABORTION = "5";//流产 (待配种)
      public static String PIG_STATE_EMPTY = "6";//空胎/未怀孕 (待配种)
      public static String PIG_STATE_MALE = "7";//公猪 (待配种)
      public static String PIG_STATE_WEANING = "8";//断奶 (待配种)

      //猪事件
      public static String PIG_EVENT_IN = "1";//入场 (公/母)
      public static String PIG_EVENT_BREEDING = "2";//配种 (公/母)
      public static String PIG_EVENT_CHILDBIRTH = "3";//分娩 (母)
      public static String PIG_EVENT_TEST = "4";//孕检 (母)
      public static String PIG_EVENT_MINING = "5";//采精 (公)

      //来源类型
      public static String PIG_SOURCE_IN = "1";//内场
      public static String PIG_SOURCE_OUT = "2";//外场
   }
   
   public static class GOODS {
      public static String GOODS_PIG_ALL = "0";//全部
      public static String GOODS_PIG_PIG = "1";//种猪
      public static String GOODS_PIG_PORKER = "2";//肉猪
      
      public static String GOODS_STAGE_PREGNANT = "0";//怀孕料
      public static String GOODS_STAGE_LACTATION = "1";//哺乳料
      public static String GOODS_STAGE_RESERVE = "2";//后备料
      public static String GOODS_STAGE_NONPREGNANCY = "3";//空怀料
      public static String GOODS_STAGE_BOAR = "4";//公猪料
      
      public static String GOODS_TYPE_FEED = "0";//饲料
      public static String GOODS_TYPE_VETERINARY = "1";//兽药
      public static String GOODS_TYPE_VACCINE = "2";//疫苗
      public static String GOODS_TYPE_SEMEN = "3";//猪只精液
   }
}
