import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:qrcode/qrcode.dart';

class QrCodePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new QrCodeState();
  }
}

class QrCodeState extends State<QrCodePage> with TickerProviderStateMixin{
  QRCaptureController _captureController = QRCaptureController();
  Animation<Alignment> _animation;
  AnimationController _animationController;

  bool _isTorchOn = false;
  void initState() {
    super.initState();
    _captureController.onCapture((data) {
      print('onCapture----$data');
      _captureController.pause();
      PageUtil.pop(data);
    });
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation =
    AlignmentTween(begin: Alignment.topCenter, end: Alignment.bottomCenter)
        .animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '扫码'),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            child: QRCaptureView(
              controller: _captureController,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 76),
            child: AspectRatio(
              aspectRatio: 275 / 275,
              child: Container(
                width: 275,
                height: 275,
//                color: Colors.yellow,
                child: Stack(
                  alignment: _animation.value,
                  children: <Widget>[
                    Image.asset('imgs/nav/xian.png')
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 56),
            child: AspectRatio(
              aspectRatio: 275 / 275,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Image.asset('imgs/nav/sao.png')
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildToolBar(),
          )
        ],
      ),
    );
  }
  Widget _buildToolBar() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            _captureController.pause();
          },
          child: Text('暂停'),
        ),
        FlatButton(
          onPressed: () {
            if (_isTorchOn) {
              _captureController.torchMode = CaptureTorchMode.off;
            } else {
              _captureController.torchMode = CaptureTorchMode.on;
            }
            _isTorchOn = !_isTorchOn;
          },
          child: Text('手电筒'),
        ),
        FlatButton(
          onPressed: () {
            _captureController.resume();
          },
          child: Text('恢复'),
        ),
      ],
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
    _animationController.dispose();
    super.dispose();
  }
}
