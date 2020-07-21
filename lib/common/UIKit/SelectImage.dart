import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';

class qiniuUtil {
  factory qiniuUtil() => _getInstance();

  static qiniuUtil get instance => _getInstance();
  static qiniuUtil _instance;
  String token;
  String cdn;

  qiniuUtil._internal() {}

  static qiniuUtil _getInstance() {
    if (_instance == null) {
      _instance = new qiniuUtil._internal();
    }
    return _instance;
  }

  void getToken() async {
    Completer completer=new Completer();
    HttpUtil.get('/qiniu/token').then((res) {
      token = res['token'];
      cdn = res['cdn'];
      completer.complete(true);
    });
    return completer.future;
  }

  static Future uploadAvatar(String path) async {
    Completer completer = new Completer();
    Dio dio = new Dio();
    PickedFile file = PickedFile(path);
    var bytes = await file.readAsBytes();
    String timer = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    List ary = file.path.split('.');
    FormData data = new FormData.fromMap({
      'token': qiniuUtil().token,
      'file': MultipartFile.fromBytes(bytes),
      'key': timer + '.' + ary.last,
    });
    Options options = new Options(contentType: 'multipart/form-data');
    dio.post('http://upload.qiniup.com', data: data, options: options).then((res) {
      String src = qiniuUtil().cdn + '/' + res.data['key'];
      completer.complete(src);
    }).catchError((err) {
      completer.completeError(err);
      print(err.toString());
    });
    return completer.future;
  }
}

class SelectImage extends StatefulWidget {
  SelectImage({
    Key key,
    this.src,
    this.width = 100,
    this.heidht = 100,
    this.margin,
    this.enabled = true,
    this.onChange,
  }) : super(key: key);
  String src;
  double width;
  double heidht;
  EdgeInsets margin;
  final bool enabled; //禁用，false为禁用
  final Function onChange;

  @override
  State<StatefulWidget> createState() {
    return new SelectImageState();
  }
}

class SelectImageState extends State<SelectImage> {
  final _picker = ImagePicker();
  PickedFile _file;
  String _src;
  bool _isUploading = false;
  bool _uploadFailed = false;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  void onTapSelect() async {
    var index = await DialogUtil.dialogSheet(['相册', '拍照']);
    if (index == 0) {
      selectImages();
    } else {
      selectCamera();
    }
  }

  Future<void> selectImages() async {
    try {
      PickedFile image = await _picker.getImage(source: ImageSource.gallery);
      print(image);
      setState(() {
        _file = image;
      });
      print(_file.path);
      uploadAvatar();
    } catch (err) {
      DialogUtil.toastError('获取图片失败，请重新选择');
    }
  }

  Future<void> selectCamera() async {
    try {
      PickedFile image = await _picker.getImage(source: ImageSource.camera);
      setState(() {
        _file = image;
      });
      print(_file.path);
      uploadAvatar();
    } catch (err) {
      DialogUtil.toastError('获取图片失败，请重新选择');
    }
  }

  void uploadAvatar() async {
    setState(() {
      _isUploading = true;
      _uploadFailed = false;
    });
    Dio dio = new Dio();
    var bytes = await _file.readAsBytes();
    String timer = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    List ary = _file.path.split('.');
    FormData data = new FormData.fromMap({
      'token': qiniuUtil().token,
      'file': MultipartFile.fromBytes(bytes),
      'key': timer + '.' + ary.last,
    });
    Options options = new Options(contentType: 'multipart/form-data');
    dio.post('http://upload.qiniup.com', data: data, options: options).then((res) {
      print('上传成功');
      print(res);
      setState(() {
        widget.src = qiniuUtil().cdn + '/' + res.data['key'];
        print(widget.src);
        _isUploading = false;
        _uploadFailed = false;
        widget.onChange(widget.src);
      });
    }).catchError((err) {
      setState(() {
        _isUploading = false;
        _uploadFailed = true;
        _file = null;
      });
      print(err.toString());
    });
  }

  Widget layout(BuildContext context) {
    Widget view;
    if (widget.src != null && widget.src != '') {
      view = CachedNetworkImage(
        imageUrl: widget.src,
        width: widget.width,
        height: widget.heidht,
        placeholder: (context, url) =>
            Container(
              color: BackgroundColor,
              child: Center(
                child: Label(
                  '加载中...',
                  fontSize: 18 * ScaleWidth,
                  textColor: Color(0xFFBEBEBE),
                ),
              ),
            ),
        errorWidget: (context, url, error) => Image.asset("imgs/nav/error.png"),
        fit: BoxFit.cover,
      );
    } else if (_file != null) {
      view = view = placehold_uploading();
    } else if (widget.enabled) {
//      view = placehold();
      if (_uploadFailed) {
        view = placehold_uploadFail();
      } else {
        view = placehold();
      }
    }
    return GestureDetector(
      child: Container(
        margin: widget.margin,
        width: widget.width,
        height: widget.heidht,
        color: Color(0xFFF3F5F8),
        child: view,
      ),
      onTap: () {
        if (!widget.enabled) {
          PageUtil.push('PhotoViewSimpleScreen', arguments: widget.src);
          return;
        };
        onTapSelect();
      },
    );
  }

  Widget placehold() {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        ImageView(
          src: 'imgs/home/yinhuanfaqi/add2.png',
          width: 34 * ScaleWidth,
          height: 34 * ScaleWidth,
          margin: EdgeInsets.only(top: 41 * ScaleWidth),
        ),
        Label(
          '添加附件',
          fontSize: 18 * ScaleWidth,
          textColor: Color(0xFFBEBEBE),
          margin: EdgeInsets.only(top: 95 * ScaleWidth),
        ),
      ],
    );
  }

  Widget placehold_uploading() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Image.file(
          File(_file.path),
          width: widget.width,
          height: widget.heidht,
          fit: BoxFit.cover,
        ),
        Container(
          width: widget.width,
          height: widget.heidht,
          color: Color.fromRGBO(0, 0, 0, 0.3),
        ),
        Label(
          '上传中...',
          fontSize: 18 * ScaleWidth,
          textColor: Color(0xFFBEBEBE),
        ),
      ],
    );
  }

  Widget placehold_uploadFail() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Label(
          '上传失败!',
          fontSize: 18 * ScaleWidth,
          textColor: Color(0xFFBEBEBE),
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
    super.dispose();
  }
}
