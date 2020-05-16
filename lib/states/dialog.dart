import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jhtoast/jhtoast.dart';
import 'default.dart';

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

  static toastText({String msg: '操作成功'}) {
    JhToast.showText(DefaultUtil.mainContext, msg: msg);
  }

  static toastSuccess({String msg: '操作成功'}) {
    JhToast.showSuccess(DefaultUtil.mainContext, msg: msg);
  }

  static toastError({String msg: '操作失败'}) {
    JhToast.showError(DefaultUtil.mainContext, msg: msg);
  }

  static Future<bool> alertConfim({title: '温馨提示', content: '无'}) async {
    return await showDialog(
        context: DefaultUtil.mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
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
