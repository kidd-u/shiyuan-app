import './default.dart';

class PageUtil {
  /** 普通跳转 */
  static push(String page) {
    DefaultUtil.navKey.currentState.pushReplacementNamed(page);
  }
  /** 返回，可携带返回值 */
  static pop<T extends Object>([T result]){
    DefaultUtil.navKey.currentState.pop(result);
  }
  /** 跳转并销毁所有页面 */
  static pushAndRemoveAll(String page){
    DefaultUtil.navKey.currentState.pushNamedAndRemoveUntil(page, (route) => false);
  }
  /** 跳转并销毁当前页面 */
  static pushAndReplace(String page){
    DefaultUtil.navKey.currentState.pushReplacementNamed(page);
  }
}
