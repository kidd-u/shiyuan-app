import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jhtoast/jhtoast.dart';
import '../../states/default.dart';

class DialogUtil {
  // 工厂模式
  factory DialogUtil() => _getInstance();

  static DialogUtil get instance => _getInstance();
  static DialogUtil _instance;

  DialogUtil._internal() {
    // 初始化
  }

  static DialogUtil _getInstance() {
    if (_instance == null) {
      _instance = new DialogUtil._internal();
    }
    return _instance;
  }

  static toastText(BuildContext context, String msg) {
    JhToast.showText(context, msg: msg == null ? '操作成功' : msg);
  }

  static toastSuccess(BuildContext context, String msg) {
    JhToast.showSuccess(context, msg: msg == null ? '操作成功' : msg);
  }

  static toastError(BuildContext context, String msg) {
    JhToast.showError(context, msg: msg == null ? '操作失败' : msg);
  }

  static Future<bool> alertConfim(BuildContext context, String content, String title) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: Text(title == null ? '温馨提示' : title),
            content: Text(content == null ? '无' : content),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('取消', style: TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              CupertinoDialogAction(
                child: Text('确定'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        });
  }
}
