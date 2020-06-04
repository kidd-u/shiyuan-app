import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class qiniuUtil {
  factory qiniuUtil() => _getInstance();

  static qiniuUtil get instance => _getInstance();
  static qiniuUtil _instance;
  String token;

  qiniuUtil._internal() {}

  static qiniuUtil _getInstance() {
    if (_instance == null) {
      _instance = new qiniuUtil._internal();
    }
    return _instance;
  }

  void getToken() async {
    Map res = await HttpUtil().get('/qiniu/token');
    token = res['token'];
  }
}

class SelectImage extends StatefulWidget {
  const SelectImage({Key key, this.src, this.width = 100, this.heidht = 100, this.margin}) : super(key: key);
  final String src;
  final double width;
  final double heidht;
  final EdgeInsets margin;

  @override
  State<StatefulWidget> createState() {
    return new SelectImageState();
  }
}

class SelectImageState extends State<SelectImage> {
  final _picker = ImagePicker();
  File _file;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Future<void> selectImages() async {
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    _file = File(image.path);
    print(_file.path);
  }

  Future<void> selectCamera() async {
    PickedFile image = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      _file = File(image.path);
    });
    print(_file.path);
  }

  Widget layout(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: widget.margin,
        width: widget.width,
        height: widget.heidht,
        color: Color(0xFFF3F5F8),
        child: widget.src == null
            ? Image.file(
                _file,
                width: widget.width,
                height: widget.heidht,
                fit: BoxFit.cover,
              )
            : Image.network(
                widget.src,
                width: widget.width,
                height: widget.heidht,
                fit: BoxFit.cover,
              ),
      ),
      onTap: () async {
        var index = await DialogUtil.dialogSheet(['相册', '拍照']);
        if (index == 0) {
          selectImages();
        } else {
          selectCamera();
        }
      },
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
