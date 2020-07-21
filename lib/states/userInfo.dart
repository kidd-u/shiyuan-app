import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/WorkChooseStore.dart';
import 'package:shiyuan/states/default.dart';
import '../routes/login/model/user.dart';
import '../routes/login/model/UserInfo.dart';
import 'dart:convert' as Convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiyuan/common/UIKit/SelectImage.dart';
import 'dart:async';

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
  static UserInfoModel userInfo;

  UserToken token() {
    return _token;
  }
  void cleanUserInfo()async{
    Completer completer = new Completer();
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('token');
      HttpUtil().setHeader();
      completer.complete(true);
    }).catchError((err){
      completer.complete(false);
    });
    return completer.future;
  }
  void setToken(token) async {
    Completer completer = new Completer();
    _token = UserToken.fromJson(token);
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("token", Convert.jsonEncode(_token.toJson())); //存Sring
      HttpUtil().setHeader();
      completer.complete(true);
    }).catchError((err){
      completer.complete(false);
    }); //存一遍本地
    return completer.future;
  }

  getUserInfo() async {
    Completer completer = new Completer();
    SharedPreferences.getInstance().then((prefs) {
      String info = prefs.getString("token");
      print('==========本地缓存===========');
      print(info);
      if (info != null) {
        Map<String, dynamic> userInfo = Convert.jsonDecode(info);
        String jwt = String.fromCharCodes(Convert.base64Decode(userInfo['jwt']));
        print(jwt);
        userInfo['jwt'] = jwt;
        _token = UserToken.fromJson(userInfo);
      }
      completer.complete(true);
    }).catchError((err){
      completer.complete(false);
    });
    return completer.future;
  }
  getCache()async{
    await qiniuUtil().getToken();//初始化七牛token
    await WorkChooseStoreUtil().getAllData();//初始化人员选择
  }
}
