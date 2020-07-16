import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:shiyuan/common/UIKit/UIKit.dart';
import 'package:shiyuan/states/default.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

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
  static hiddenKeyboard(){
    FocusScope.of(DefaultUtil.navKey.currentState.context).requestFocus(FocusNode());
  }
  /** 加载中 */
  static showLoading() {
    BotToast.showLoading();
  }
  /** 取消所有加载中 */
  static hiddenLoading() {
    BotToast.closeAllLoading();
  }

  static showToast(String msg) {
    Completer completer = new Completer();
    BotToast.showText(
        text: msg,
        align: Alignment.center,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        contentPadding: EdgeInsets.only(left: 24, right: 24, top: 7, bottom: 7),
        contentColor: Color.fromRGBO(140, 140, 140, 1),
        onClose: () {
          completer.complete(true);
        });
    return completer.future;
  }
  /** 成功提示悬浮 */
  static toastSuccess(String msg) {
    return showToast(msg ?? '操作成功');
  }
  /** 失败提示悬浮 */
  static toastError(String msg) {
    return showToast(msg ?? '操作失败');
  }
  /** confim操作提示 */
  static Future dialogConfim(String content, {String title}) async {
    hiddenKeyboard();
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
                  child: Text('取消', style: TextStyle(color: Colors.black,fontSize: 30*ScaleWidth)),
                  onPressed: () {
                    cancelFunc();
                    completer.completeError('点击了取消');
                    hiddenKeyboard();
//                    throw '点击了取消';
                  },
                ),
                FlatButton(
                  child: Text('确定',style: TextStyle(color: MainDarkBlueColor,fontSize: 30*ScaleWidth),),
                  onPressed: () {
                    cancelFunc();
                    completer.complete(true);
                    hiddenKeyboard();
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
  /** alert无返回值提示 */
  static Future<bool> dialogAlert(String content, {String title}) async {
    hiddenKeyboard();
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
                  child: Text('确定',style: TextStyle(color: MainDarkBlueColor,fontSize: 30*ScaleWidth),),
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
  /** sheet底部弹框 */
  static Future dialogSheet(List<String> actions, {String title = '提示'}) async {
    hiddenKeyboard();
    Completer completer = new Completer();
    BotToast.showWidget(toastBuilder: (cancelFunc) {
      List<Widget> actionItems = [];
      for (int i = 0; i < actions.length; i++) {
        String element = actions[i];
        Widget item = GestureDetector(
          onTap: () {
            completer.complete(i);
            cancelFunc();
            hiddenKeyboard();
          },
          child: Container(
            width: 700 * ScaleWidth,
            height: 45.0,
            //边框设置
            decoration: new BoxDecoration(border: new Border(bottom: BorderSide(color: LineColor, width: 0.5))),
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
                        decoration: new BoxDecoration(border: new Border(bottom: BorderSide(color: LineColor, width: 0.5))),
                        child: Center(
                            child: Text(
                          title,
                          style: TextStyle(decoration: TextDecoration.none, color: MainTitleColor, fontSize: 15, fontWeight: FontWeight.bold),
                        )),
                      ),
                      ...actionItems,
                    ],
                  )),
            ),
            Button(
              width: 700 * ScaleWidth,
              height: 45,
              margin: EdgeInsets.only(bottom: 15, top: 15),
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
                hiddenKeyboard();
              },
            ),
          ],
        ),
      );
    });
    return completer.future;
  }
  /** 选择日期 */
  static Future showTimePicker(BuildContext context,{String normalTime,DateTime maxDateTime}) async {
    hiddenKeyboard();
    Completer completer = new Completer();
    var _dateTime = normalTime == null?DateTime.now():DateTime.parse(normalTime);

    DatePicker.showDatePicker(
        context,
        pickerTheme: DateTimePickerTheme(
          showTitle: true,
          confirm: Text('确定',style:TextStyle(color:MainBlueColor)),
          cancel: Text('取消',style: TextStyle(color: Colors.black)),
          itemTextStyle: TextStyle(color: Colors.black),
        ),
        minDateTime: DateTime.now(),
        maxDateTime: maxDateTime,
//        maxDateTime: DateTime.now().add(Duration(days: 7)),
        initialDateTime: _dateTime,
        // dateFormat: "yyyy-MMMM-dd", //只包含年、月、日
//        dateFormat: 'yyyy年M月d日  EEE,H时:m分',
        dateFormat: 'yyyy  MMMM  dd',
        pickerMode: DateTimePickerMode.date,
        locale: DateTimePickerLocale.zh_cn,
        onCancel: (){
          debugPrint("onCancel");
        },
        onConfirm: (dateTime,List<int> index){
          _dateTime=dateTime;
          completer.complete(_dateTime);
          hiddenKeyboard();
        }
    );
    return completer.future;
  }

  /** 签到成功 */
  static Future dialogSignSuccess() async {
    Completer completer = new Completer();
    BotToast.showWidget(toastBuilder: (cancelFunc) {
      return Container(
        color: Colors.black38,
        child: Center(
          child: Container(
            width: 625 * ScaleWidth,
            height: 688 * ScaleWidth,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                ImageView(
                  src: 'imgs/home/xianxia/signsuccess.png',
                  width: 625 * ScaleWidth,
                  height: 688 * ScaleWidth,
                ),
                Label(
                  '签到成功!',
                  margin: EdgeInsets.only(top: 325 * ScaleWidth),
                  fontSize: 56 * ScaleWidth,
                  fontWeight: FontWeight.bold,
                  textColor: MainBlueColor,
                ),
                TextButton(
                  '确定',
                  textColor: Colors.white,
                  width: 386 * ScaleWidth,
                  height: 88 * ScaleWidth,
                  margin: EdgeInsets.only(top: 500 * ScaleWidth),
                  decoration: new BoxDecoration(
                    color: Color(0xFF3160D1),
                    borderRadius: BorderRadius.all(Radius.circular(44 * ScaleWidth)),
                  ),
                  onPressed: () {
                    cancelFunc();
                    completer.complete(true);
                  },
                )
              ],
            ),
          ),
        ),
      );
    });
    return completer.future;
  }

  /** 开始检查 */
  static Future dialogBeganCheck() async {
    Completer completer = new Completer();
    BotToast.showWidget(toastBuilder: (cancelFunc) {
      return Container(
        color: Colors.black38,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20 * ScaleWidth),
            child: Container(
              width: 606 * ScaleWidth,
              height: 474 * ScaleWidth,
              color: Colors.white,
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  ImageView(
                    src: 'imgs/normal/jiancha.png',
                    width: 133 * ScaleWidth,
                    height: 130 * ScaleWidth,
                    margin: EdgeInsets.only(top: 63 * ScaleWidth),
                  ),
                  Label(
                    '是否确定开始本次检查',
                    fontWeight: FontWeight.bold,
                    fontSize: 36 * ScaleWidth,
                    textColor: Color(0xFF62CCA2),
                    margin: EdgeInsets.only(top: 270 * ScaleWidth),
                  ),
                  Positioned(
                    bottom: 93 * ScaleWidth,
                    left: 0,
                    right: 0,
                    height: 0.5,
                    child: Container(
                      color: LineColor,
                      height: 0.5,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 93 * ScaleWidth,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextButton(
                            '取消',
                            fontSize: 30*ScaleWidth,
                            textColor: Colors.black,
                            onPressed: (){
                              completer.completeError(false);
                              cancelFunc();
                            },
                          ),
                        ),
                        Container(
                          color: LineColor,
                          width: 0.5,
                        ),
                        Expanded(
                          child: TextButton(
                            '确定',
                            fontSize: 30*ScaleWidth,
                            textColor: MainDarkBlueColor,
                            onPressed: (){
                              completer.complete(true);
                              cancelFunc();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
    return completer.future;
  }
  /** 开始考试 */
  static Future dialogBeganTest() async {
    Completer completer = new Completer();
    BotToast.showWidget(toastBuilder: (cancelFunc) {
      return Container(
        color: Colors.black38,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20 * ScaleWidth),
            child: Container(
              width: 606 * ScaleWidth,
              height: 474 * ScaleWidth,
              color: Colors.white,
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  ImageView(
                    src: 'imgs/normal/kaoshi.png',
                    width: 160 * ScaleWidth,
                    height: 141 * ScaleWidth,
                    margin: EdgeInsets.only(top: 51 * ScaleWidth),
                  ),
                  Label(
                    '是否确定开始考试',
                    fontWeight: FontWeight.bold,
                    fontSize: 36 * ScaleWidth,
                    textColor: Color(0xFF62CCA2),
                    margin: EdgeInsets.only(top: 270 * ScaleWidth),
                  ),
                  Positioned(
                    bottom: 93 * ScaleWidth,
                    left: 0,
                    right: 0,
                    height: 0.5,
                    child: Container(
                      color: LineColor,
                      height: 0.5,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 93 * ScaleWidth,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextButton(
                            '取消',
                            fontSize: 30*ScaleWidth,
                            textColor: Colors.black,
                            onPressed: (){
                              completer.completeError(false);
                              cancelFunc();
                            },
                          ),
                        ),
                        Container(
                          color: LineColor,
                          width: 0.5,
                        ),
                        Expanded(
                          child: TextButton(
                            '确定',
                            fontSize: 30*ScaleWidth,
                            textColor: MainDarkBlueColor,
                            onPressed: (){
                              completer.complete(true);
                              cancelFunc();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
    return completer.future;
  }
  /** 完成培训 */
  static Future dialogEndTraining() async {
    Completer completer = new Completer();
    BotToast.showWidget(toastBuilder: (cancelFunc) {
      return Container(
        color: Colors.black38,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20 * ScaleWidth),
            child: Container(
              width: 606 * ScaleWidth,
              height: 474 * ScaleWidth,
              color: Colors.white,
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  ImageView(
                    src: 'imgs/normal/wanchengpeixun.png',
                    width: 184 * ScaleWidth,
                    height: 137 * ScaleWidth,
                    margin: EdgeInsets.only(top: 51 * ScaleWidth),
                  ),
                  Label(
                    '是否确定完成培训',
                    fontWeight: FontWeight.bold,
                    fontSize: 36 * ScaleWidth,
                    textColor: Color(0xFF62CCA2),
                    margin: EdgeInsets.only(top: 270 * ScaleWidth),
                  ),
                  Positioned(
                    bottom: 93 * ScaleWidth,
                    left: 0,
                    right: 0,
                    height: 0.5,
                    child: Container(
                      color: LineColor,
                      height: 0.5,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 93 * ScaleWidth,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextButton(
                            '取消',
                            fontSize: 30*ScaleWidth,
                            textColor: Colors.black,
                            onPressed: (){
                              completer.completeError(false);
                              cancelFunc();
                            },
                          ),
                        ),
                        Container(
                          color: LineColor,
                          width: 0.5,
                        ),
                        Expanded(
                          child: TextButton(
                            '确定',
                            fontSize: 30*ScaleWidth,
                            textColor: MainDarkBlueColor,
                            onPressed: (){
                              completer.complete(true);
                              cancelFunc();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
    return completer.future;
  }
  /** 离开培训 */
  static Future dialogLeaveTraining() async {
    Completer completer = new Completer();
    BotToast.showWidget(toastBuilder: (cancelFunc) {
      return Container(
        color: Colors.black38,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20 * ScaleWidth),
            child: Container(
              width: 606 * ScaleWidth,
              height: 510 * ScaleWidth,
              color: Colors.white,
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  ImageView(
                    src: 'imgs/normal/tanhao.png',
                    width: 114 * ScaleWidth,
                    height: 100 * ScaleWidth,
                    margin: EdgeInsets.only(top: 61 * ScaleWidth),
                  ),
                  Label(
                    '是否确定离开培训界面',
                    fontWeight: FontWeight.bold,
                    fontSize: 36 * ScaleWidth,
                    textColor: ErrorColor,
                    margin: EdgeInsets.only(top: 239 * ScaleWidth),
                  ),
                  Label(
                    '培训尚未结束\n现在离开已培训内容无效',
                    fontWeight: FontWeight.w400,
                    fontSize: 30 * ScaleWidth,
                    textColor: Colors.black,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    margin: EdgeInsets.only(top: 300 * ScaleWidth),
                  ),
                  Positioned(
                    bottom: 93 * ScaleWidth,
                    left: 0,
                    right: 0,
                    height: 0.5,
                    child: Container(
                      color: LineColor,
                      height: 0.5,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 93 * ScaleWidth,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextButton(
                            '取消',
                            fontSize: 30*ScaleWidth,
                            textColor: Colors.black,
                            onPressed: (){
                              completer.completeError(false);
                              cancelFunc();
                            },
                          ),
                        ),
                        Container(
                          color: LineColor,
                          width: 0.5,
                        ),
                        Expanded(
                          child: TextButton(
                            '确定',
                            fontSize: 30*ScaleWidth,
                            textColor: MainDarkBlueColor,
                            onPressed: (){
                              completer.complete(true);
                              cancelFunc();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
    return completer.future;
  }
  /** 重新培训 */
  static Future dialogAgainTraining() async {
    Completer completer = new Completer();
    BotToast.showWidget(toastBuilder: (cancelFunc) {
      return Container(
        color: Colors.black38,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20 * ScaleWidth),
            child: Container(
              width: 606 * ScaleWidth,
              height: 474 * ScaleWidth,
              color: Colors.white,
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  ImageView(
                    src: 'imgs/normal/chongixnpeixun.png',
                    width: 194 * ScaleWidth,
                    height: 175 * ScaleWidth,
                    margin: EdgeInsets.only(top: 51 * ScaleWidth),
                  ),
                  Label(
                    '是否确定重新培训？',
                    fontWeight: FontWeight.w400,
                    fontSize: 30 * ScaleWidth,
                    textColor: Colors.black,
                    textAlign: TextAlign.center,
                    margin: EdgeInsets.only(top: 270 * ScaleWidth),
                  ),
                  Positioned(
                    bottom: 93 * ScaleWidth,
                    left: 0,
                    right: 0,
                    height: 0.5,
                    child: Container(
                      color: LineColor,
                      height: 0.5,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 93 * ScaleWidth,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextButton(
                            '取消',
                            fontSize: 30*ScaleWidth,
                            textColor: Colors.black,
                            onPressed: (){
                              completer.completeError(false);
                              cancelFunc();
                            },
                          ),
                        ),
                        Container(
                          color: LineColor,
                          width: 0.5,
                        ),
                        Expanded(
                          child: TextButton(
                            '确定',
                            fontSize: 30*ScaleWidth,
                            textColor: MainDarkBlueColor,
                            onPressed: (){
                              completer.complete(true);
                              cancelFunc();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
    return completer.future;
  }
  /** 培训已办结，开始考试 */
  static Future dialogTrainingDone() async {
    Completer completer = new Completer();
    BotToast.showWidget(toastBuilder: (cancelFunc) {
      return Container(
        color: Colors.black38,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20 * ScaleWidth),
            child: Container(
              width: 606 * ScaleWidth,
              height: 474 * ScaleWidth,
              color: Colors.white,
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  ImageView(
                    src: 'imgs/normal/peixunyiwancheng.png',
                    width: 256 * ScaleWidth,
                    height: 145 * ScaleWidth,
                    margin: EdgeInsets.only(top: 51 * ScaleWidth),
                  ),
                  Label(
                    '培训已办结',
                    fontWeight: FontWeight.bold,
                    fontSize: 36 * ScaleWidth,
                    textColor: Color(0xFF62CCA2),
                    textAlign: TextAlign.center,
                    margin: EdgeInsets.only(top: 239 * ScaleWidth),
                  ),
                  Label(
                    '是否确定开始考试?',
                    fontWeight: FontWeight.w400,
                    fontSize: 30 * ScaleWidth,
                    textColor: Colors.black,
                    textAlign: TextAlign.center,
                    margin: EdgeInsets.only(top: 300 * ScaleWidth),
                  ),
                  Positioned(
                    bottom: 93 * ScaleWidth,
                    left: 0,
                    right: 0,
                    height: 0.5,
                    child: Container(
                      color: LineColor,
                      height: 0.5,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 93 * ScaleWidth,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextButton(
                            '取消',
                            fontSize: 30*ScaleWidth,
                            textColor: Colors.black,
                            onPressed: (){
                              completer.completeError(false);
                              cancelFunc();
                            },
                          ),
                        ),
                        Container(
                          color: LineColor,
                          width: 0.5,
                        ),
                        Expanded(
                          child: TextButton(
                            '确定',
                            fontSize: 30*ScaleWidth,
                            textColor: MainDarkBlueColor,
                            onPressed: (){
                              completer.complete(true);
                              cancelFunc();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
    return completer.future;
  }

}
