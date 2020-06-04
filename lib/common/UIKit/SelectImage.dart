import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SelectImage extends StatefulWidget {
  const SelectImage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new SelectImageState();
  }
}

class SelectImageState extends State<SelectImage> {
  final _picker = ImagePicker();
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Future<void> selectImages() async {
//    DialogUtil.dialogSheet('content');
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    final File file = File(image.path);
    print(file.path);
  }

  Widget layout(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Text('选择图片'),
      ),
      onTap: () {
        selectImages();
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
