import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shiyuan/states/default.dart';
import '../view/SignBoard.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

class SignBoardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SignBoardPageState();
  }
}

class SignBoardPageState extends State<SignBoardPage> {
  SignBoardController controller = new SignBoardController();

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  Widget build(BuildContext context) {
    Widget btn = Button(
      child: Text(
        '完成',
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
    return new Scaffold(
      backgroundColor: BackgroundColor,
//      appBar: buildAppBar(context, '文档教育', actions: [btn]),
      body: Container(
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[

              Positioned(
                child: SignBoard(
                  controller: controller,
                  width: ScreenHeight,
                  height: ScreenWidth,
                ),
              ),
              Positioned(
                top: 15 * ScaleWidth,
                left: 15 * ScaleWidth,
                width: 272 * ScaleWidth,
                height: 80 * ScaleWidth,
                child: WorkButtonCancel(
                  title: '返回',
                  onClick: () {
                    PageUtil.pop();
                  },
                ),
              ),
              Positioned(
                top: 15 * ScaleWidth,
//                left: 15 * ScaleWidth,
                width: 272 * ScaleWidth,
                height: 80 * ScaleWidth,
                child: WorkButtonCancel(
                  title: '清除',
                  onClick: () {
                    controller.clear();
                  },
                ),
              ),
              Positioned(
                top: 15 * ScaleWidth,
                right: 15 * ScaleWidth,
                width: 272 * ScaleWidth,
                height: 80 * ScaleWidth,
                child: WorkButtonDone(
                  title: '完成',
                  margin: EdgeInsets.only(left: 56 * ScaleWidth),
                  onClick: () async {
                    await controller.save();
                    String path=controller.getImagePath();
                    print(path);
                    PageUtil.pop(path);
                  },
                ),
              ),
            ],
          )),
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }
}
