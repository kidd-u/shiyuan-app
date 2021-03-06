import 'dart:ffi';

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
    this.showCounterText = true,
    this.maxLengthEnforced = true,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.enabled = true,
    this.textAlign = TextAlign.left,
    this.contentPadding,
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
  final bool showCounterText; //右下角统计字符串
  final bool maxLengthEnforced; //超出不可编辑
  final ValueChanged<String> onChanged; //文本改变事件
  final VoidCallback onEditingComplete; //点击完成
  final ValueChanged<String> onSubmitted; //点击完成
  final bool enabled; //禁用，false为禁用
  final TextAlign textAlign; //文字对齐
  final EdgeInsets contentPadding; //用于输入框对齐错误，谨慎使用

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
        textAlign: textAlign,
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
        enableInteractiveSelection: enabled,
        onTap: () {
          if (!enabled) {
            FocusScope.of(context).requestFocus(new FocusNode());
          }  
        },
//        enabled: enabled,
        style: TextStyle(fontSize: 28 * ScaleWidth, color: Colors.black),
        decoration: InputDecoration(
          counterText: showCounterText?null:'',
          contentPadding: contentPadding,
          hintText: placeholder,
          hintStyle: TextStyle(fontSize: 28 * ScaleWidth, color: Color.fromRGBO(149, 147, 151, 1)),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
        ),
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
    this.enabled = false,
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
  final bool enabled;

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
            if (!enabled) {
              onPressed();
              if (onPressedByTag is Function) {
                onPressedByTag(tag);
              }
            }
          },
          child: child),
    );
  }
}

/**
 * Button 纯文字按钮，TextButton在1.2.0被新组件占用，先用TextBtn代替
 * */
class TextBtn extends StatelessWidget {
  const TextBtn(
    this.data, {
    Key key,
    this.color,
    this.decoration,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.onPressed,
    this.onPressedByTag,
    this.child,
    this.textColor = Colors.black,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.tag,
    this.enabled = false,
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
  final String data; //文本
  final Widget child;
  final Color textColor; //按钮文字颜色
  final double fontSize; //字号
  final FontWeight fontWeight; //粗细
  final double tag; //tag按钮标识
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: color,
        decoration: decoration,
        margin: margin,
        padding: padding,
        width: width,
        height: height,
        child: Center(
          child: child == null
              ? Text(
                  data,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                  ),
                )
              : child,
        ),
      ),
      onTap: () {
        onPressed();
        if (onPressedByTag != null) {
          onPressedByTag(tag);
        }
      },
    );
  }
}

/**
 * Label文本标签
 * */
class Label extends StatelessWidget {
  const Label(
    this.data, {
    Key key,
    this.color,
    this.decoration,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.width,
    this.height,
    this.textColor = Colors.black,
    this.textBackGround,
    this.fontSize,
    this.fontWeight = FontWeight.w400,
    this.maxLines = 1,
    this.textAlign = TextAlign.left,
    this.textDecoration = TextDecoration.none,
    this.decorationStyle,
    this.onClick,
    this.enabled = false,
    this.lineHeight = 1.2,
  }) : super(key: key);
  final Color color; //底色
  final Decoration decoration; // 背景装饰
  final EdgeInsets margin; //外边距
  final EdgeInsets padding; //内边距
  final double width; //容器的宽度
  final double height; //容器的高度

  final String data; //文本
  final Color textColor; //文字颜色
  final Color textBackGround; //文字底色
  final double fontSize; //字号
  final FontWeight fontWeight; //粗细
  final int maxLines; //行数
  final TextAlign textAlign; //对齐
  final TextDecoration textDecoration; //下换线位置
  final TextDecorationStyle decorationStyle;
  final Function onClick;
  final bool enabled;
  final double lineHeight; //行高

  @override
  Widget build(BuildContext context) {
    Widget view = Container(
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
        style: TextStyle(
          backgroundColor: textBackGround,
          fontSize: fontSize,
          height: lineHeight,
          fontWeight: fontWeight,
          color: textColor,
          decoration: textDecoration,
          decorationStyle: decorationStyle,
        ),
      ),
    );
    if (!enabled && onClick is Function) {
      return GestureDetector(
        child: view,
        onTap: () {
          onClick();
        },
      );
    }
    return view;
  }
}
/**
 * Label文本标签
 * */
class CenterLabel extends StatelessWidget {
  const CenterLabel(
      this.data, {
        Key key,
        this.color,
        this.decoration,
        this.margin = EdgeInsets.zero,
        this.padding = EdgeInsets.zero,
        this.width,
        this.height,
        this.textColor = Colors.black,
        this.textBackGround,
        this.fontSize,
        this.fontWeight = FontWeight.w400,
        this.maxLines = 1,
        this.textAlign = TextAlign.center,
        this.textDecoration = TextDecoration.none,
        this.decorationStyle,
        this.onClick,
        this.enabled = false,
        this.lineHeight = 1.2,
      }) : super(key: key);
  final Color color; //底色
  final Decoration decoration; // 背景装饰
  final EdgeInsets margin; //外边距
  final EdgeInsets padding; //内边距
  final double width; //容器的宽度
  final double height; //容器的高度
  
  final String data; //文本
  final Color textColor; //文字颜色
  final Color textBackGround; //文字底色
  final double fontSize; //字号
  final FontWeight fontWeight; //粗细
  final int maxLines; //行数
  final TextAlign textAlign; //对齐
  final TextDecoration textDecoration; //下换线位置
  final TextDecorationStyle decorationStyle;
  final Function onClick;
  final bool enabled;
  final double lineHeight; //行高
  
  @override
  Widget build(BuildContext context) {
    Widget view = Container(
      color: color,
      decoration: decoration,
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      child: Center(
        child: Text(
          data,
          overflow: TextOverflow.ellipsis,
          maxLines: maxLines,
          textAlign: textAlign,
          style: TextStyle(
            backgroundColor: textBackGround,
            fontSize: fontSize,
            height: lineHeight,
            fontWeight: fontWeight,
            color: textColor,
            decoration: textDecoration,
            decorationStyle: decorationStyle,
          ),
        ),
      ),
    );
    if (!enabled && onClick is Function) {
      return GestureDetector(
        child: view,
        onTap: () {
          onClick();
        },
      );
    }
    return view;
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
    this.onClick,
    this.enabled = false,
    this.borderRadius_Img = 0,
  }) : super(key: key);
  final Color color; //底色
  final Decoration decoration; // 背景装饰
  final EdgeInsets margin; //外边距
  final EdgeInsets padding; //内边距
  final double width; //容器的宽度
  final double height; //容器的高度

  final String src; //图片路径
  final BoxFit fit; //填充模式，fill填充变形，cover比例裁剪，contain自适应大小
  final Function onClick;
  final bool enabled;
  final double borderRadius_Img; //图片圆角，和背景圆角不同

  @override
  Widget build(BuildContext context) {
    Widget view = Container(
      color: color,
      decoration: decoration,
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius_Img)),
        child: Image(
          image: AssetImage(src),
          width: width,
          height: height,
          fit: fit,
        ),
      ),
    );
    if (!enabled && onClick is Function) {
      return GestureDetector(
        child: view,
        onTap: () {
          onClick();
        },
      );
    }
    return view;
  }
}

/**
 * MainTitleLabel,30px
 * */
class MainTitleLabel extends StatelessWidget {
  const MainTitleLabel(
    this.data, {
    Key key,
    this.color,
    this.decoration,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.fontWeight = FontWeight.w400,
    this.textColor = MainTitleColor,
    this.maxLines = 1,
    this.textAlign = TextAlign.left,
    this.onClick,
    this.enabled = false,
    this.lineHeight,
  }) : super(key: key);
  final Color color; //底色
  final Decoration decoration; // 背景装饰
  final EdgeInsets margin; //外边距
  final EdgeInsets padding; //内边距
  final double width; //容器的宽度
  final double height; //容器的高度

  final String data; //文本
  final FontWeight fontWeight; //粗细
  final Color textColor; //文字颜色
  final int maxLines; //行数
  final TextAlign textAlign; //对齐
  final Function onClick;
  final bool enabled;
  final double lineHeight; //行高

  @override
  Widget build(BuildContext context) {
    Widget view = Container(
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
        style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: 30 * ScaleWidth,
          height: lineHeight != null ? lineHeight : null,
          color: textColor,
          fontWeight: fontWeight,
//          backgroundColor: Colors.cyan
        ),
      ),
    );
    if (!enabled && onClick is Function) {
      return GestureDetector(
        child: view,
        onTap: () {
          onClick();
        },
      );
    }
    return view;
  }
}

/**
 * MainTextLabel,28px
 * */
class MainTextLabel extends StatelessWidget {
  const MainTextLabel(
    this.data, {
    Key key,
    this.color,
    this.decoration,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.fontWeight = FontWeight.w400,
    this.textColor = MainTitleColor,
    this.maxLines = 1,
    this.textAlign = TextAlign.left,
    this.onClick,
    this.enabled = false,
    this.lineHeight,
  }) : super(key: key);
  final Color color; //底色
  final Decoration decoration; // 背景装饰
  final EdgeInsets margin; //外边距
  final EdgeInsets padding; //内边距
  final double width; //容器的宽度
  final double height; //容器的高度

  final String data; //文本
  final FontWeight fontWeight; //粗细
  final Color textColor; //文字颜色
  final int maxLines; //行数
  final TextAlign textAlign; //对齐
  final Function onClick;
  final bool enabled;
  final double lineHeight; //行高

  @override
  Widget build(BuildContext context) {
    Widget view = Container(
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
        style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: 28 * ScaleWidth,
          height: lineHeight != null ? lineHeight : null,
          color: textColor,
          fontWeight: fontWeight,
        ),
      ),
    );
    if (!enabled && onClick is Function) {
      return GestureDetector(
        child: view,
        onTap: () {
          onClick();
        },
      );
    }
    return view;
  }
}

/**
 * SubTextLabel,24px
 * */
class SubTextLabel extends StatelessWidget {
  const SubTextLabel(
    this.data, {
    Key key,
    this.color,
    this.decoration,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.fontWeight = FontWeight.w400,
    this.textColor = MainTitleColor,
    this.maxLines = 1,
    this.textAlign = TextAlign.left,
    this.onClick,
    this.enabled = false,
    this.lineHeight,
  }) : super(key: key);
  final Color color; //底色
  final Decoration decoration; // 背景装饰
  final EdgeInsets margin; //外边距
  final EdgeInsets padding; //内边距
  final double width; //容器的宽度
  final double height; //容器的高度

  final String data; //文本
  final FontWeight fontWeight; //粗细
  final Color textColor; //文字颜色
  final int maxLines; //行数
  final TextAlign textAlign; //对齐
  final Function onClick;
  final bool enabled;
  final double lineHeight; //行高

  @override
  Widget build(BuildContext context) {
    Widget view = Container(
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
        style: TextStyle(
          fontSize: 24 * ScaleWidth,
          height: lineHeight != null ? lineHeight : null,
          color: textColor,
          fontWeight: fontWeight,
        ),
      ),
    );
    if (!enabled && onClick is Function) {
      return GestureDetector(
        child: view,
        onTap: () {
          onClick();
        },
      );
    }
    return view;
  }
}

/**
 * SmallTextLabel,20px
 * */
class SmallTextLabel extends StatelessWidget {
  const SmallTextLabel(
    this.data, {
    Key key,
    this.color,
    this.decoration,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.width,
    this.height,
    this.textColor = MainTitleColor,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
    this.onClick,
    this.enabled = false,
    this.lineHeight,
  }) : super(key: key);
  final Color color; //底色
  final Decoration decoration; // 背景装饰
  final EdgeInsets margin; //外边距
  final EdgeInsets padding; //内边距
  final double width; //容器的宽度
  final double height; //容器的高度

  final String data; //文本
  final Color textColor; //文字颜色
  final int maxLines; //行数
  final TextAlign textAlign; //对齐
  final Function onClick;
  final bool enabled;
  final double lineHeight; //行高

  @override
  Widget build(BuildContext context) {
    Widget view = Container(
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
        style: TextStyle(
          fontSize: 20 * ScaleWidth,
          height: lineHeight != null ? lineHeight : null,
          color: textColor,
        ),
      ),
    );
    if (!enabled && onClick is Function) {
      return GestureDetector(
        child: view,
        onTap: () {
          onClick();
        },
      );
    }
    return view;
  }
}

/**
 * LineView
 * */
class LineView extends StatelessWidget {
  const LineView({Key key, this.margin = EdgeInsets.zero}) : super(key: key);
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: margin,
      color: LineColor,
      height: 0.5,
    );
  }
}

/**
 * AppBar
 * */
Widget buildAppBar(BuildContext context, String title, {bool showPop = true, List<Widget> actions}) {
  return new AppBar(
    leading: showPop
        ? new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Color.fromRGBO(163, 171, 242, 1)),
            onPressed: () => PageUtil.pop(),
          )
        : null,
    automaticallyImplyLeading: showPop,
    title: Text(
      title,
      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.light,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromRGBO(37, 49, 191, 1), Color.fromRGBO(18, 113, 224, 1)],
        ),
      ),
    ),
    actions: actions,
  );
}

Widget navBar(window, title) {
  return new Container(
    color: Colors.transparent,
    height: MediaQueryData.fromWindow(window).padding.top + kToolbarHeight,
    child: Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        ImageView(
          src: 'imgs/nav/back.png',
          margin: EdgeInsets.only(left: 15, bottom: 20),
        ),
        GestureDetector(
          child: Container(
            color: Colors.transparent,
            width: 30,
            height: 30,
            margin: EdgeInsets.only(left: 15, bottom: 16),
          ),
          onTap: () => PageUtil.pop(),
        ),
        Container(
          height: 20,
          margin: EdgeInsets.only(bottom: 20),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget rightChoose() {
  return ImageView(
    src: 'imgs/mine/right_icon.png',
    width: 12 * ScaleWidth,
    height: 23 * ScaleWidth,
    margin: EdgeInsets.only(right: 30 * ScaleWidth),
  );
}
