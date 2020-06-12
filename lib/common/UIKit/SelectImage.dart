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
  String cdn;

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
    cdn = res['cdn'];
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
  }) : super(key: key);
  String src;
  double width;
  double heidht;
  EdgeInsets margin;
  final bool enabled; //禁用，false为禁用

  @override
  State<StatefulWidget> createState() {
    return new SelectImageState();
  }
}

class SelectImageState extends State<SelectImage> {
  final _picker = ImagePicker();
  PickedFile _file;
  String _src;
  bool isUploading, uploadFailed;

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
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _file = image;
    });
    print(_file.path);
    uploadAvatar();
  }

  Future<void> selectCamera() async {
    PickedFile image = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      _file = image;
    });
    print(_file.path);
    uploadAvatar();
  }

  void uploadAvatar() async {
    setState(() {
      isUploading = true;
      uploadFailed = false;
    });
    Dio dio = new Dio();
    var bytes = await _file.readAsBytes();
    String timer = DateTime.now().millisecondsSinceEpoch.toString();
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
        isUploading = false;
      });
    }).catchError((err) {
      setState(() {
        uploadFailed = true;
      });
      print(err.toString());
    });
  }

  Widget layout(BuildContext context) {
    Widget view;
    if (widget.src != null) {
      view = Image.network(
        widget.src,
        width: widget.width,
        height: widget.heidht,
        fit: BoxFit.cover,
      );
    } else if (_file != null) {
      view = Image.file(
        File(_file.path),
        width: widget.width,
        height: widget.heidht,
        fit: BoxFit.cover,
      );
    } else if (widget.enabled) {
      view = placehold(context);
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
        if (!widget.enabled) return;
        onTapSelect();
      },
    );
  }

  Widget placehold(BuildContext context) {
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
