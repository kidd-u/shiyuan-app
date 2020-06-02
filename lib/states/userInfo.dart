import 'package:flutter/material.dart';
import '../routes/login/model/user.dart';
import 'dart:convert' as Convert;
import 'package:shared_preferences/shared_preferences.dart';

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

  UserModel _info;

  UserModel info() {
    return _info;
  }
  void cleanUserInfo()async{
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('userInfo');
  }
  void setInfo(info) async {
    print('缓存信息111');
    _info = UserModel.fromJson(info);
    print('缓存信息');
    print(_info.toJson());
    var prefs = await SharedPreferences.getInstance(); //存一遍本地
    prefs.setString("userInfo", Convert.jsonEncode(_info.toJson())); //存Sring
    print('=====info111');
    print(UserInfo().info().jwt);
  }

  getUserInfo() async {
    var prefs = await SharedPreferences.getInstance();
    String info = prefs.getString("userInfo");
    print('==========本地缓存===========');
    print(info);
    if (info != null) {
      Map<String, dynamic> userInfo = Convert.jsonDecode(info);
      print('==========本地缓存 解析===========');
      print(userInfo);
      String jwt = String.fromCharCodes(Convert.base64Decode(userInfo['jwt']));
      print(jwt);
      userInfo['jwt'] = jwt;
      _info = UserModel.fromJson(userInfo);
    }
  }
}
