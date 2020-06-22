import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import './network_utils.dart';
import 'package:shiyuan/states/default.dart';
import './LogUtil.dart';

class TokenInterceptor extends Interceptor {
  String token;

  @override
  onRequest(RequestOptions options) {
    if (token != null) {
      options.queryParameters["session_uuid"] = token;
    }
  }

  @override
  onError(DioError err) {}

  @override
  onResponse(Response response) {}
}

class NetworkError {
  int errorCode;
  String errorMessage;
  static const NETWORK_TIMEOUT = 100;

  NetworkError(this.errorCode, this.errorMessage);
}

class HttpUtil {
  // 工厂模式
  factory HttpUtil() => _getInstance();

  static HttpUtil get instance => _getInstance();
  static HttpUtil _instance;
  Dio dio;
  BaseOptions options;

  static HttpUtil _getInstance() {
    if (_instance == null) {
      _instance = new HttpUtil._internal();
    }
    return _instance;
  }

  HttpUtil._internal() {
    LogUtil.d('初始化');
    // 初始化
    options = new BaseOptions(
      baseUrl: 'http://47.105.133.198/safecoop/api',
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 30 * 1000,
      receiveTimeout: 30 * 1000,
      headers: {
        'Source': 'APP',
        'Authorization': UserInfo().token() != null ? UserInfo().token().jwt : '',
      },

//      contentType: ContentType.parse("multipart/form-data;boundary=----WebKitFormBoundaryyrV7KO0BoCBuDbTL"),
//      contentType: ContentType.parse('application/x-www-form-urlencoded'),
    );
    dio = new Dio(options);
    dio.transformer = new FlutterTransformer();
  }

  setHeader() {
    dio.options.headers = {
      'Source': 'APP',
      'Authorization': UserInfo().token() != null ? UserInfo().token().jwt : '',
    };
  }

  static Future get(url, {params}) async {
    Completer completer = new Completer();
    Response response;
    bool networkReachable = await NetWorkUtils.instance.isNetworkUseable();
    if (!networkReachable) {
      response = new Response(statusCode: 1, statusMessage: "网络加载失败，请检查网络");
      networkErrorTransform(response, completer);
    } else {
      try {
        response = await HttpUtil().dio.get(
              url,
              queryParameters: params,
            );
        networkSuccess(url, response, completer);
      } on DioError catch (error) {
        networkError(url, error, completer);
      }
    }
    return completer.future;
  }

  static Future post(url, {params}) async {
    Completer completer = new Completer();
    Response response;
    bool networkReachable = await NetWorkUtils.instance.isNetworkUseable();
    if (!networkReachable) {
      response = new Response(statusCode: 1, statusMessage: "网络加载失败，请检查网络");
      networkErrorTransform(response, completer);
    } else {
      try {
        response = await HttpUtil().dio.post(
              url,
              data: params,
            );
        networkSuccess(url, response, completer);
      } on DioError catch (error) {
        networkError(url, error, completer);
      }
    }
    return completer.future;
  }

  static put(url, {params}) async {
    Completer completer = new Completer();
    Response response;
    bool networkReachable = await NetWorkUtils.instance.isNetworkUseable();
    if (!networkReachable) {
      response = new Response(statusCode: 1, statusMessage: "网络加载失败，请检查网络");
      networkErrorTransform(response, completer);
    } else {
      try {
        response = await HttpUtil().dio.put(
              url,
              queryParameters: params,
            );
        networkSuccess(url, response, completer);
      } on DioError catch (error) {
        networkError(url, error, completer);
      }
    }
    return completer.future;
  }

  static delete(url, {params}) async {
    Completer completer = new Completer();
    Response response;
    bool networkReachable = await NetWorkUtils.instance.isNetworkUseable();
    if (!networkReachable) {
      response = new Response(statusCode: 1, statusMessage: "网络加载失败，请检查网络");
      networkErrorTransform(response, completer);
    } else {
      try {
        response = await HttpUtil().dio.delete(
              url,
              queryParameters: params,
            );
        networkSuccess(url, response, completer);
      } on DioError catch (error) {
        networkError(url, error, completer);
      }
    }
    return completer.future;
  }

  static networkSuccess(String url, Response response, Completer completer) {
    LogUtil.d('=======================success $url=======================');
    LogUtil.d(response.toString());
    LogUtil.d('=======================success $url=======================');
    if (response.data['code'] != 0) {
      LogUtil.d('服务器返回错误');
      response = new Response(statusCode: 1, statusMessage: response.data['err']);
      networkErrorTransform(response, completer);
    } else {
      LogUtil.d('获取到数据');
      completer.complete(response.data['data']);
    }
  }

  static networkError(String url, DioError error, Completer completer) {
    Response response;
    LogUtil.d('=======================error $url=======================');
    LogUtil.d('$error');
    LogUtil.d('=======================error $url=======================');
    if (error.type == DioErrorType.CONNECT_TIMEOUT) {
      response = new Response(statusCode: NetworkError.NETWORK_TIMEOUT, statusMessage: "网络加载超时，请检查网络");
    } else {
      response = new Response(statusCode: 1, statusMessage: error.message);
    }
    networkErrorTransform(response, completer);
  }

  static networkErrorTransform(Response response, Completer completer) {
    LogUtil.d("networkErrorTransform === $response");
    DialogUtil.dialogAlert(response.statusMessage);
    completer.completeError(response);
  }
}
