import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:shiyuan/common/UIKit/UIKit.dart';

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

  static showToast(String msg) {
    BotToast.showText(
      text: msg,
      align: Alignment.center,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      contentPadding: EdgeInsets.only(left: 24, right: 24, top: 7, bottom: 7),
      contentColor: Color.fromRGBO(140, 140, 140, 1),
    );
  }

  static toastSuccess(String msg) {
    showToast(msg ?? '操作成功');
  }

  static toastError(BuildContext context, String msg) {
    showToast(msg ?? '操作失败');
  }

  static Future dialogConfim(String content, {Function onConfirm, String title, Function onCancel}) async {
    Completer completer = new Completer();
    BotToast.showWidget(toastBuilder: (cancelFunc) {
      return Container(
        color: Colors.black38,
        child: Center(
          child: Container(
            child: CupertinoAlertDialog(
              title: Text(title == null ? '温馨提示' : title),
              content: Text(content == null ? '无' : content),
              actions: <Widget>[
                FlatButton(
                  child: Text('取消', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    if (onCancel != null) {
                      onCancel();
                    }
                    cancelFunc();
                    completer.completeError('点击了取消');
//                    throw '点击了取消';
                  },
                ),
                FlatButton(
                  child: Text('确定'),
                  onPressed: () {
                    if (onConfirm != null) {
                      onConfirm();
                    }
                    cancelFunc();
                    completer.complete(true);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
    return completer.future;
  }
  static Future<bool> dialogAlert(String content, {String title}) async {
    BotToast.showWidget(toastBuilder: (cancelFunc) {
      return Container(
        color: Colors.black38,
        child: Center(
          child: Container(
            child: CupertinoAlertDialog(
            title: Label(title == null ? '提示' : title,textAlign: TextAlign.center,margin: EdgeInsets.only(bottom: 8),),
              content: Text(content == null ? '无' : content),
              actions: <Widget>[
                FlatButton(
                  child: Text('确定'),
                  onPressed: () {
                    cancelFunc();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
  static Future<bool> dialogSheet(String content, {Function onConfirm, String title, Function onCancel}) async {
    BotToast.showWidget(toastBuilder: (cancelFunc) {
      return Container(
        color: Colors.black38,
        child: Center(
          child: Container(
            child: CupertinoAlertDialog(
              title: Text(title == null ? '温馨提示' : title),
              content: Text(content == null ? '无' : content),
              actions: <Widget>[
                FlatButton(
                  child: Text('取消', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    if (onCancel != null) {
                      onCancel();
                    }
                    cancelFunc();
                  },
                ),
                FlatButton(
                  child: Text('确定'),
                  onPressed: () {
                    if (onConfirm != null) {
                      onConfirm();
                    }
                    cancelFunc();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
