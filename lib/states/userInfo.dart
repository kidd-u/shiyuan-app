import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import '../routes/login/model/user.dart';
import 'dart:convert' as Convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiyuan/common/UIKit/SelectImage.dart';

class UserInfo {
  factory UserInfo() => _getInstance();

  static UserInfo get instance => _getInstance();
  static UserInfo _instance;

  UserInfo._internal() {}

  static UserInfo _getInstance() {
    if (_instance == null) {
      _instance = new UserInfo._internal();
    }
    return _instance;
  }

  UserToken _token;

  UserToken token() {
    return _token;
  }
  void cleanUserInfo()async{
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    HttpUtil().setHeader();
  }
  void setToken(token) async {
    _token = UserToken.fromJson(token);
    var prefs = await SharedPreferences.getInstance(); //存一遍本地
    prefs.setString("token", Convert.jsonEncode(_token.toJson())); //存Sring
    HttpUtil().setHeader();
  }

  getUserInfo() async {
    var prefs = await SharedPreferences.getInstance();
    String info = prefs.getString("token");
    print('==========本地缓存===========');
    print(info);
    if (info != null) {
      Map<String, dynamic> userInfo = Convert.jsonDecode(info);
      print('==========本地缓存 解析===========');
      print(userInfo);
      String jwt = String.fromCharCodes(Convert.base64Decode(userInfo['jwt']));
      print(jwt);
      userInfo['jwt'] = jwt;
      _token = UserToken.fromJson(userInfo);
      qiniuUtil().getToken();//初始化七牛token
    }
  }
}
