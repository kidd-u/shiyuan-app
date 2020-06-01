import 'package:connectivity/connectivity.dart';

class NetWorkUtils {
  static final NetWorkUtils instance = NetWorkUtils._internal();

  factory NetWorkUtils.getInstance() {
    return instance;
  }

  NetWorkUtils._internal();

  Future<bool> isNetworkUseable() async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
