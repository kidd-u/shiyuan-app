import 'package:flutter/material.dart';
import '../../states/default.dart';

/**
 * InputView输入框
 * */
class InputView extends StatelessWidget {
  const InputView({
    Key key,
    this.color,
    this.decoration,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.controller,
    this.focusNode,
    this.placeholder,
    this.keyboardType,
    this.enterAction,
    this.autofocus = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.maxLengthEnforced = true,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.enabled,
  }) : super(key: key);

  final Color color; //底色
  final Decoration decoration; // 背景装饰
  final EdgeInsets margin; //外边距
  final EdgeInsets padding; //内边距
  final double width; //容器的宽度
  final double height; //容器的高度

  final TextEditingController controller; //编辑框的控制器
  final FocusNode focusNode; //焦点
  final String placeholder; //默认提示文字
  final TextInputType keyboardType; //键盘类型
  final TextInputAction enterAction; //键盘回车键类型
  final bool autofocus; //自动获取焦点
  final bool obscureText; //密文形式
  final int maxLines; //行数
  final int maxLength; //限制字数
  final bool maxLengthEnforced; //超出不可编辑
  final ValueChanged<String> onChanged; //文本改变事件
  final VoidCallback onEditingComplete; //点击完成
  final ValueChanged<String> onSubmitted; //点击完成
  final bool enabled; //禁用，false为禁用

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      decoration: decoration,
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction: enterAction,
        autofocus: autofocus,
        obscureText: obscureText,
        maxLines: maxLines,
        maxLength: maxLength,
        maxLengthEnforced: maxLengthEnforced,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
        enabled: enabled,
        style: TextStyle(fontSize: 28 * ScaleWidth),
        decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(fontSize: 28 * ScaleWidth, color: Color.fromRGBO(149, 147, 151, 1)),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))),
      ),
    );
  }
}

/**
 * Button按钮
 * */
class Button extends StatelessWidget {
  const Button({
    Key key,
    this.color,
    this.decoration,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.onPressed,
    this.onPressedByTag,
    this.textColor,
    this.child = const Text('Button'),
    this.tag,
  }) : super(key: key);

  final Color color; //底色
  final Decoration decoration; // 背景装饰
  final EdgeInsets margin; //外边距
  final EdgeInsets padding; //内边距
  final double width; //容器的宽度
  final double height; //容器的高度

  @required
  final VoidCallback onPressed; //按钮点击回调
  final Function onPressedByTag;
  final Color textColor; //按钮文字颜色
  final Widget child;
  final double tag; //tag按钮标识

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      decoration: decoration,
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      child: FlatButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          color: Colors.transparent,
          onPressed: () {
            onPressed();
            onPressedByTag(tag);
          },
          child: child),
    );
  }
}

/**
 * Label文本变迁
 * */
class Label extends StatelessWidget {
  const Label(
    this.data, {
    Key key,
    this.color,
    this.decoration,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.textColor,
    this.fontSize,
    this.maxLines = 1,
    this.textAlign = TextAlign.left,
  }) : super(key: key);
  final Color color; //底色
  final Decoration decoration; // 背景装饰
  final EdgeInsets margin; //外边距
  final EdgeInsets padding; //内边距
  final double width; //容器的宽度
  final double height; //容器的高度

  final String data; //文本
  final Color textColor; //文字颜色
  final double fontSize; //字号
  final int maxLines; //行数
  final TextAlign textAlign; //对齐

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      decoration: decoration,
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      child: Text(
        data,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines,
        textAlign: textAlign,
        style: TextStyle(fontSize: fontSize, color: textColor),
      ),
    );
  }
}
/**
 * ImageView本地图片
 * */
class ImageView extends StatelessWidget {
  const ImageView({
    Key key,
    this.color,
    this.decoration,
    this.margin,
    this.padding,
    this.width,
    this.height,
    @required this.src,
    this.fit = BoxFit.cover,
  }) : super(key: key);
  final Color color; //底色
  final Decoration decoration; // 背景装饰
  final EdgeInsets margin; //外边距
  final EdgeInsets padding; //内边距
  final double width; //容器的宽度
  final double height; //容器的高度

  final String src; //图片路径
  final BoxFit fit;//填充模式，fill填充变形，cover比例裁剪，contain自适应大小

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      decoration: decoration,
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      child: Image(
        image: AssetImage(src),
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }
}
