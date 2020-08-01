package com.hkx.util;

import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;

import java.util.Random;

public class AliyunUtil {

    //注：有备注无需修改的位置请勿改动。
    public static SendSmsResponse testSendPhoneMsg(String signName,String templateCode,String phoneNumbers,String code) throws ClientException {
        //设置超时时间-可自行调整
        System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
        System.setProperty("sun.net.client.defaultReadTimeout", "10000");
        //初始化ascClient需要的几个参数
        final String product = "Dysmsapi";//短信API产品名称（短信产品名固定，无需修改）
        final String domain = "dysmsapi.aliyuncs.com";//短信API产品域名（接口地址固定，无需修改）
        //替换成你的AK
        final String accessKeyId = "LTAI4FcJ5WXHXYEE5765ibDL";//你的accessKeyId,参考本文档步骤2
        final String accessKeySecret ="oDbpsp9myl5nELdiYV7cFEbjVNaEDY";//你的accessKeySecret，参考本文档步骤2
        //初始化ascClient,暂时不支持多region（请勿修改）
        IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", accessKeyId,
                accessKeySecret);
        DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", product, domain);
        IAcsClient acsClient = new DefaultAcsClient(profile);
        //组装请求对象
        SendSmsRequest request = new SendSmsRequest();
        //使用post提交
        request.setMethod(MethodType.POST);
        //必填:待发送手机号。支持以逗号分隔的形式进行批量调用，批量上限为1000个手机号码,批量调用相对于单条调用及时性稍有延迟,验证码类型的短信推荐使用单条调用的方式；发送国际/港澳台消息时，接收号码格式为国际区号+号码，如“85200000000”

        request.setPhoneNumbers(phoneNumbers);
        //必填:短信签名-可在短信控制台中找到
        request.setSignName(signName);
        //必填:短信模板-可在短信控制台中找到，发送国际/港澳台消息时，请使用国际/港澳台短信模版
        request.setTemplateCode(templateCode);//"SMS_183767036"
        //可选:模板中的变量替换JSON串,如模板内容为"亲爱的${name},您的验证码为${code}"时,此处的值为
        //友情提示:如果JSON中需要带换行符,请参照标准的JSON协议对换行符的要求,比如短信内容中包含\r\n的情况在JSON中需要表示成\\r\\n,否则会导致JSON在服务端解析失败
        //"{\"name\":\"Tom\", \"code\":\"123\"}"
        request.setTemplateParam("{\"code\":\""+code+"\"}");
        //可选-上行短信扩展码(扩展码字段控制在7位或以下，无特殊需求用户请忽略此字段)
        //request.setSmsUpExtendCode("90997");
        //可选:outId为提供给业务方扩展字段,最终在短信回执消息中将此值带回给调用者
        request.setOutId("yourOutId");
        //请求失败这里会抛ClientException异常
        SendSmsResponse sendSmsResponse = acsClient.getAcsResponse(request);
        if(sendSmsResponse.getCode() != null && sendSmsResponse.getCode().equals("OK")) {
        //请求成功
        }
        return sendSmsResponse;
    }

    //发送验证码,并且存储验证码
    public static String getSendPhoneCode(String phoneNumbers,String code) {

        String signName="kaixuanApp";//签名
        String templateCode="SMS_184110545";  //模板id

        //调用发送验证码方法
       try {
            //响应对象
            SendSmsResponse sendSmsResponse = testSendPhoneMsg(signName,templateCode,phoneNumbers,code);
            //响应Code
            String codeMsg = sendSmsResponse.getCode();
            String message=null;
           System.out.println(codeMsg);
            if(codeMsg.equals("OK")){
                message="发送成功";
            }else if (codeMsg.equals("isv.AMOUNT_NOT_ENOUGH")){
                message="账户余额不足";
            }else if(codeMsg.equals(("isv.MOBILE_NUMBER_ILLEGAL"))){
                message = "手机号码数不正确";
            }
            return message;
        } catch (ClientException e) {
            e.printStackTrace();
            throw new RuntimeException("出现异常，发送失败");
        }
    }


    //生成随机数
    public static  String getRandom(int n){
        char[] code =  "0123456789".toCharArray();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < n; i++) {
            sb.append(code[new Random().nextInt(code.length)]);
        }
        return sb.toString();
    }

    //测试
    public static void main(String[] args)  {
        String phoneNumbers="173314590";  //接收短信手机号
        //随机6位随机验证码
        String random = getRandom(6);
        System.out.println(random);
        String message = null;
        message = getSendPhoneCode(phoneNumbers, random);
        System.out.println(message);
    }

}
