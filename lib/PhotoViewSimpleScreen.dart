import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shiyuan/states/default.dart';

class PhotoViewSimpleScreen extends StatelessWidget {
  const PhotoViewSimpleScreen({
    this.src = '', //图片
  });

  final String src;

  @override
  Widget build(BuildContext context) {
    print('=========');
    print(src);
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: PhotoView(
                imageProvider: NetworkImage(src),
                heroAttributes: PhotoViewHeroAttributes(tag: 'simple'),
                enableRotation: false,
              ),
            ),
            Positioned(
              //右上角关闭按钮
              right: 10,
              top: MediaQuery.of(context).padding.top,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  PageUtil.pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
