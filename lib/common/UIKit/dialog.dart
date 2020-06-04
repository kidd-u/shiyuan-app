import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:shiyuan/common/UIKit/UIKit.dart';
import 'package:shiyuan/states/default.dart';

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
              title: Label(
                title == null ? '提示' : title,
                textAlign: TextAlign.center,
                margin: EdgeInsets.only(bottom: 8),
              ),
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

  static Future dialogSheet(List<String> actions, {String title = '提示'}) async {
    Completer completer = new Completer();
    BotToast.showWidget(toastBuilder: (cancelFunc) {
      List<Widget> actionItems = [];
      for (int i = 0; i < actions.length; i++) {
        String element = actions[i];
        Widget item = GestureDetector(
          onTap: (){
            completer.complete(i);
            cancelFunc();
          },
          child: Container(
            width: 700 * ScaleWidth,
            height: 45.0,
            //边框设置
            decoration: new BoxDecoration(
                border: new Border(bottom: BorderSide(color: LineColor,width: 0.5))
            ),
            child: Center(
                child: Text(
              element,
              style: TextStyle(decoration: TextDecoration.none, color: MainTitleColor, fontSize: 15, fontWeight: FontWeight.w400),
            )),
          ),
        );
        actionItems.add(item);
      }
      return Container(
        width: ScreenWidth,
        color: Colors.black38,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: Container(
                  width: 700 * ScaleWidth,
                  height: 45.0 * (actions.length + 1),
                  color: Colors.white,
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 700 * ScaleWidth,
                        height: 45.0,
                        //边框设置
                        decoration: new BoxDecoration(
                            border: new Border(bottom: BorderSide(color: LineColor,width: 0.5))
                        ),
                        child: Center(
                            child: Text(
                              title,
                              style: TextStyle(decoration: TextDecoration.none, color: MainTitleColor, fontSize: 15, fontWeight: FontWeight.w400),
                            )),
                      ),
                      ...actionItems,
                    ],
                  )),
            ),
            Button(
              width: 700 * ScaleWidth,
              height: 45,
              margin: EdgeInsets.only(bottom: 10, top: 15),
              //边框设置
              decoration: new BoxDecoration(
                //背景
                color: Colors.white,
                //设置四周圆角 角度
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Text(
                '取消',
                style: TextStyle(color: WarningColor, fontSize: 15, fontWeight: FontWeight.w400),
              ),
              onPressed: () {
                cancelFunc();
                completer.completeError('点击了取消');
              },
            ),
          ],
        ),
      );
    });
    return completer.future;
  }
}
