import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:async';

import '../config/http_headers.dart';
import '../config/service_url.dart';
import 'package:encryption_tool/encryption_tool.dart';
import 'dart:convert' as convert;


Future showRequest (url,{formData}) async{
  try{
    print('开始获取数据');
    BaseOptions options = new BaseOptions(
      responseType: ResponseType.plain,
    );
    Response response;
    Dio dio = new Dio(options);
    dio.options.headers = httpHeaders;
//    dio.options.contentType = ContentType.parse('application/json');
    if(formData == null){
      String allUrl = servicePath[url];
      response = await dio.post(allUrl);
      String responseStr = response.data.toString();
      String aesKey = 'devKey1234567890';
      String aesIV  = 'stagePayMall0000';
      String aesDeStr = await EncryptionTool.aesDecrypt(responseStr, aesKey, aesIV);
      print(aesDeStr);
      Map<String, dynamic> user = convert.jsonDecode(aesDeStr);
      print('111111111');
      print(user);
    }else{
      String originText = convert.jsonEncode(formData);
      String aesKey = 'devKey1234567890';
      String aesIV  = 'stagePayMall0000';
      String aesEncryptTxt = await EncryptionTool.aesEncrypt(originText, aesKey,aesIV);
      response = await dio.post(servicePath[url],data: aesEncryptTxt);
//      print('--->$response');
    }
    if(response.statusCode == 200){
      String aesKey = 'devKey1234567890';
      String aesIV  = 'stagePayMall0000';
      String aesDeStr = await EncryptionTool.aesDecrypt(response.data, aesKey, aesIV);
      Map<String, dynamic> user = convert.jsonDecode(aesDeStr);
      final resonseBoby = user['body'];
      print('==BobyBack===>${resonseBoby}');
      return resonseBoby;
    }else{
      throw Exception('后端接口出现异常');
    }
  }catch(e){
    return print('Error--->$e');
  }
}




//class aesToStringData
//{
//
//  static Future<String>toPassString({formData}) async {
//    String originText = convert.jsonEncode(formData);
//    String aesKey = 'devKey1234567890';
//    String aesIV  = 'stagePayMall0000';
//    String aesEncryptTxt = await EncryptionTool.aesEncrypt(originText, aesKey,aesIV);
//    return aesEncryptTxt;
//  }
//
//}



//static Future<String>aesEncrypt(String originText,String aesKey,String awsIV) async{
//var params = {'originText':originText,'aesKey':aesKey,'aesIV':awsIV};
//String encryptText = await _channel.invokeMethod('aesEncrypt',params);
//return encryptText;
//}



