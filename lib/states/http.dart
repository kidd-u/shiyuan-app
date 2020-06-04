import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import './network_utils.dart';
import 'package:shiyuan/states/default.dart';

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
    print('初始化');
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

  get(url, {queryParameters, options}) async {
    Response response;
    bool networkReachable = await NetWorkUtils.instance.isNetworkUseable();
    if (!networkReachable) {
      response = new Response(statusCode: 1, statusMessage: "网络加载失败，请检查网络");
      return networkErrorTransform(response);
    } else {
      try {
        response = await dio.get(
          url,
          queryParameters: queryParameters,
        );
        return networkSuccess(url, response);
      } on DioError catch (error) {
        return networkError(url, error);
      }
    }
  }

  post(url, {queryParameters, Function onSuccess, Function onError}) async {
    Response response;
    bool networkReachable = await NetWorkUtils.instance.isNetworkUseable();
    if (!networkReachable) {
      response = new Response(statusCode: 1, statusMessage: "网络加载失败，请检查网络");
      return networkErrorTransform(response);
    } else {
      try {
        response = await dio.post(
          url,
          data: queryParameters,
        );
        return networkSuccess(url, response);
      } on DioError catch (error) {
        return networkError(url, error);
      }
    }
  }

  put(url, {queryParameters, options}) async {
    Response response;
    bool networkReachable = await NetWorkUtils.instance.isNetworkUseable();
    if (!networkReachable) {
      response = new Response(statusCode: 1, statusMessage: "网络加载失败，请检查网络");
      return networkErrorTransform(response);
    } else {
      try {
        response = await dio.put(
          url,
          queryParameters: queryParameters,
        );
        return networkSuccess(url, response);
      } on DioError catch (error) {
        return networkError(url, error);
      }
    }
  }

  delete(url, {queryParameters, options}) async {
    Response response;
    bool networkReachable = await NetWorkUtils.instance.isNetworkUseable();
    if (!networkReachable) {
      response = new Response(statusCode: 1, statusMessage: "网络加载失败，请检查网络");
      return networkErrorTransform(response);
    } else {
      try {
        response = await dio.delete(
          url,
          data: queryParameters,
        );
        return networkSuccess(url, response);
      } on DioError catch (error) {
        return networkError(url, error);
      }
    }
  }

  networkSuccess(String url, Response response) {
    print('=======================success $url=======================');
    print(response);
    print('=======================success $url=======================');
    if (response.data['code'] != 0) {
      response = new Response(statusCode: 1, statusMessage: response.data['err']);
      return networkErrorTransform(response);
    }
    return response.data['data'];
  }

  networkError(String url, DioError error) {
    Response response;
    print('=======================error $url=======================');
    print('$error');
    print('=======================error $url=======================');
    if (error.type == DioErrorType.CONNECT_TIMEOUT) {
      response = new Response(statusCode: NetworkError.NETWORK_TIMEOUT, statusMessage: "网络加载超时，请检查网络");
    } else {
      response = new Response(statusCode: 1, statusMessage: error.message);
    }
    return networkErrorTransform(response);
  }

  networkErrorTransform(Response response) {
    print("networkErrorTransform === $response");
    DialogUtil.dialogAlert(response.statusMessage);
    throw '错误';
    return null;
  }
}
