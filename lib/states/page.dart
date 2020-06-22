import './default.dart';

class PageUtil {
  /** 普通跳转 */
//  1、请实现
//  QrCodePage({
//    Key key,
//    @required this.text,  // 接收一个text参数
//  }) : super(key: key);
//  final String text;
//  2、page 注册时接受参数
//  'qrcode': (BuildContext context) => new QrCodePage(text:ModalRoute.of(context).settings.arguments),
  static push(String page, {Object arguments}) {
    print('***************************');
    print('push to ' + page);
    print('***************************');
    return DefaultUtil.navKey.currentState.pushNamed(page, arguments: arguments);
  }

  /** 返回，可携带返回值 */
  static pop<T extends Object>([T result]) {
    DefaultUtil.navKey.currentState.pop(result);
  }

  /** 跳转并销毁所有页面 */
  static pushAndRemoveAll(String page, {Object arguments}) {
    DefaultUtil.navKey.currentState.pushNamedAndRemoveUntil(page, (route) => false, arguments: arguments);
  }

  /** 跳转并销毁当前页面 */
  static pushAndReplace(String page, {Object arguments}) {
    print(page);
    DefaultUtil.navKey.currentState.pushReplacementNamed(page, arguments: arguments);
  }
}
