import 'dart:io';

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
  String _path;

  void initState() {
    super.initState();
    loadDetail();
  }

  void loadDetail() async {
    var res = await HttpUtil.get('/process/offline/summary/${widget.procId}');
    setState(() {
      _dataArray = res['summary'];
      _isTapSign = res['signMethod'] == 'QECODE';
    });
  }

  void sign() async {
    await DialogUtil.dialogConfim('确认提交签到?');
    String src = '';
    if (!_isTapSign) {
//      String path = signBoardKey.currentState.getImagePath();
      src = await qiniuUtil.uploadAvatar(_path);
    }
    print(src);
    var res = await HttpUtil.put(
      '/process/offline/sign/${widget.procId}',
      params: {
        'signDigit': {'type': 'IMAGE', 'src': src},
      },
    );
    await DialogUtil.dialogSignSuccess();
    PageUtil.pop(true);
  }

  void signBoard() async {
    var res = await PageUtil.push('signBoard');
    setState(() {
      if (res != null) {
        _path = res;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '签到'),
      body: new ListView(
        padding: EdgeInsets.only(bottom: 40),
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          ..._dataArray
              .map((e) => WorkSelect(
                    title: e['name'],
                    value: e['label'],
                  ))
              .toList(),
          ..._path == null ? signTwoBottom() : signImage(),
          ...signOneBottom(),
        ],
      ),
    );
  }

  List<Widget> signOneBottom() {
    return [
      Container(
        margin: EdgeInsets.only(top: 120 * ScaleWidth),
        child: Center(
          child: TextBtn(
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
      WorkEmpty(
        leftActions: [MainTitleLabel('签名')],
        rightActions: [
          MainTextLabel(
            '点击签名',
            textColor: MainDarkBlueColor,
            onClick: (){
              signBoard();
            },
          )
        ],
        showTopLine: false,
      )
    ];
  }

  List<Widget> signImage() {
    return [
      WorkEmpty(
        leftActions: [MainTitleLabel('电子签名')],
        rightActions: [
          MainTextLabel(
            '点击重签',
            textColor: MainDarkBlueColor,
            onClick: (){
              signBoard();
            },
          )
        ],
        showTopLine: false,
      ),
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
              Image.file(
                File(_path),
                width: 562 * ScaleWidth,
                height: 226 * ScaleWidth,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
//      signBtn(),
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
