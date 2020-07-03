import 'package:flutter/material.dart';
import 'package:shiyuan/common/UIKit/SelectImage.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';
import 'dart:ui';
import '../../view/SignBoard.dart';

class SignOnePage extends StatefulWidget {
  const SignOnePage({
    Key key,
    this.procId,
  }) : super(key: key);
  final String procId;

  @override
  State<StatefulWidget> createState() {
    return new SignOneState();
  }
}

GlobalKey<SignBoardState> signBoardKey = GlobalKey(debugLabel: 'signBoard');

class SignOneState extends State<SignOnePage> {
  List _dataArray = [];
  bool _isTapSign = true;

  void initState() {
    super.initState();
    loadDetail();
  }

  void loadDetail() async {
    var res = await HttpUtil.get('/process/offline/summary/' + widget.procId);
    setState(() {
      _dataArray = res['summary'];
      _isTapSign = res['signMethod'] == 'QECODE';
    });
  }

  void sign() async {
    await DialogUtil.dialogConfim('确认提交签到?');
    String src='';
    if (!_isTapSign) {
      String path = signBoardKey.currentState.getImagePath();
      src = await qiniuUtil.uploadAvatar(path);
    }
    print(src);
    var res = await HttpUtil.put(
      '/process/offline/sign/' + widget.procId,
      params: {
        'signDigit': {'type': 'IMAGE', 'src': src},
      },
    );
    await DialogUtil.dialogSignSuccess();
    PageUtil.pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: new ListView(
              padding: EdgeInsets.only(bottom: 40),
              physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
              children: <Widget>[
                ImageView(
                  src: 'imgs/home/xianxia/signtop.png',
                  width: ScreenWidth,
                  height: 500 * ScaleWidth,
                ),
                ..._dataArray
                    .map((e) => WorkSelect(
                          title: e['name'],
                          value: e['label'],
                        ))
                    .toList(),
                ...getBottom(),
              ],
            ),
          ),
          navBar(window, '签到'),
        ],
      ),
    );
  }

  List<Widget> getBottom() {
    return _isTapSign ? signOneBottom() : signTwoBottom();
  }

  List<Widget> signOneBottom() {
    return [
      Container(
        margin: EdgeInsets.only(top: 120 * ScaleWidth),
        child: Center(
          child: TextButton(
            '点击签到',
            width: 462 * ScaleWidth,
            height: 98 * ScaleWidth,
            fontSize: 28 * ScaleWidth,
            textColor: Colors.white,
            decoration: new BoxDecoration(
              color: MainDarkBlueColor,
              borderRadius: BorderRadius.all(Radius.circular(49 * ScaleWidth)),
            ),
            onPressed: () {
              sign();
            },
          ),
        ),
      ),
    ];
  }

  List<Widget> signTwoBottom() {
    return [
      WorkSelect(title: '电子签名:', value: '', showBottomLine: false),
      Container(
        height: 226 * ScaleWidth,
        margin: EdgeInsets.only(top: 30 * ScaleWidth),
        child: Center(
          child: Stack(
            children: <Widget>[
              ImageView(
                src: 'imgs/home/xianxia/sign.png',
                width: 562 * ScaleWidth,
                height: 226 * ScaleWidth,
                fit: BoxFit.fill,
              ),
              SignBoard(key: signBoardKey),
            ],
          ),
        ),
      ),
      signBtn(),
    ];
  }

  Widget signBtn() {
    return Container(
      margin: EdgeInsets.only(top: 30 * ScaleWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          WorkButtonCancel(
            title: '清除',
            onClick: () {
              signBoardKey.currentState.clear();
            },
          ),
          WorkButtonDone(
            title: '完成',
            margin: EdgeInsets.only(left: 56 * ScaleWidth),
            onClick: () async {
              signBoardKey.currentState.save();
              sign();
            },
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
