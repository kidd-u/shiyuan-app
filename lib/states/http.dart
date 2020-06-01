import 'dart:async';
import 'package:dio/dio.dart';
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
  TokenInterceptor tokenInterceptor;

  HttpUtil._internal() {
    // 初始化
    options = new BaseOptions(
      baseUrl: 'http://47.105.133.198/safecoop/api',
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,
      receiveTimeout: 5000,
      headers: {},

//      contentType: ContentType.parse("multipart/form-data;boundary=----WebKitFormBoundaryyrV7KO0BoCBuDbTL"),
//      contentType: ContentType.parse('application/x-www-form-urlencoded'),
    );
    tokenInterceptor = new TokenInterceptor();
    dio = new Dio(options);
//    dio.transformer = new FlutterTransformer();
    dio.interceptors.add(tokenInterceptor);
  }

  static HttpUtil _getInstance() {
    if (_instance == null) {
      _instance = new HttpUtil._internal();
    }
    return _instance;
  }

  addToken(token) {
    tokenInterceptor.token = token;
  }

  get(url, {queryParameters, options}) async {
    Response response;
    bool networkReachable = await NetWorkUtils.instance.isNetworkUseable();
    if (!networkReachable) {
      response = new Response(statusCode: 1, statusMessage: "网络加载失败，请检查网络");
      DialogUtil.alertDialog('网络加载失败，请检查网络');
      return networkErrorTransform(response);
    } else {
      try {
        response = await dio.get(
          url,
          queryParameters: queryParameters,
        );
      } on DioError catch (error) {
        print('=======================error=======================');
        print('$error');
        print('=======================error=======================');
        if (error.type == DioErrorType.CONNECT_TIMEOUT) {
          response = new Response(statusCode: NetworkError.NETWORK_TIMEOUT, statusMessage: "网络加载超时，请检查网络");
        } else {
          response = new Response(statusCode: 1, statusMessage: error.message);
        }
        print("-----error code==" + response.statusCode.toString());
        return networkErrorTransform(response);
      }
      if (response.data['code'] != 0) {
        DialogUtil.alertDialog(response.data['error']);
      }
      return Future.value(response.data['data']);
    }
  }

  put(url, {queryParameters, options}) async {
    Response response;
    bool networkReachable = await NetWorkUtils.instance.isNetworkUseable();
    if (!networkReachable) {
      response = new Response(statusCode: 1, statusMessage: "网络加载失败，请检查网络");
      DialogUtil.alertDialog('网络加载失败，请检查网络');
      return networkErrorTransform(response);
    } else {
      try {
        response = await dio.put(
          url,
          queryParameters: queryParameters,
        );
      } on DioError catch (error) {
        print('=======================error=======================');
        print('$error');
        print('=======================error=======================');
        if (error.type == DioErrorType.CONNECT_TIMEOUT) {
          response = new Response(statusCode: NetworkError.NETWORK_TIMEOUT, statusMessage: "网络加载超时，请检查网络");
        } else {
          response = new Response(statusCode: 1, statusMessage: error.message);
        }
        print("-----error code==" + response.statusCode.toString());
        return networkErrorTransform(response);
      }
      if (response.data['code'] != 0) {
        DialogUtil.alertDialog(response.data['error']);
      }
      return Future.value(response.data['data']);
    }
  }

  post(url, {queryParameters, options}) async {
    Response response;
    bool networkReachable = await NetWorkUtils.instance.isNetworkUseable();
    if (!networkReachable) {
      response = new Response(statusCode: 1, statusMessage: "网络加载失败，请检查网络");
      DialogUtil.alertDialog('网络加载失败，请检查网络');
      return networkErrorTransform(response);
    } else {
      dio.post(
        url,
        data: queryParameters,
      ).then((Response res) {
        response = res;
        if (response.data['code'] != 0) {
          DialogUtil.alertDialog(response.data['error']);
        }
        return Future.value(response.data['data']);
      }).catchError((DioError error){
        print('=======================error=======================');
        print('$error');
        print('=======================error=======================');
        if (error.type == DioErrorType.CONNECT_TIMEOUT) {
          response = new Response(statusCode: NetworkError.NETWORK_TIMEOUT, statusMessage: "网络加载超时，请检查网络");
        } else {
          response = new Response(statusCode: 1, statusMessage: error.message);
        }
        print("-----error code==" + response.statusCode.toString());
        return networkErrorTransform(response);
      });
//      try {
//        response = await dio.post(
//          url,
//          data: queryParameters,
//        );
//      } on DioError catch (error) {
//        print('=======================error=======================');
//        print('$error');
//        print('=======================error=======================');
//        if (error.type == DioErrorType.CONNECT_TIMEOUT) {
//          response = new Response(statusCode: NetworkError.NETWORK_TIMEOUT, statusMessage: "网络加载超时，请检查网络");
//        } else {
//          response = new Response(statusCode: 1, statusMessage: error.message);
//        }
//        print("-----error code==" + response.statusCode.toString());
//        return networkErrorTransform(response);
//      }
//      if (response.data['code'] != 0) {
//        DialogUtil.alertDialog(response.data['error']);
//      }
//      return Future.value(response.data['data']);
    }
  }

  delete(url, {queryParameters, options}) async {
    Response response;
    bool networkReachable = await NetWorkUtils.instance.isNetworkUseable();
    if (!networkReachable) {
      response = new Response(statusCode: 1, statusMessage: "网络加载失败，请检查网络");
      DialogUtil.alertDialog('网络加载失败，请检查网络');
      return networkErrorTransform(response);
    } else {
      try {
        response = await dio.delete(
          url,
          data: queryParameters,
        );
      } on DioError catch (error) {
        print('=======================error=======================');
        print('$error');
        print('=======================error=======================');
        if (error.type == DioErrorType.CONNECT_TIMEOUT) {
          response = new Response(statusCode: NetworkError.NETWORK_TIMEOUT, statusMessage: "网络加载超时，请检查网络");
        } else {
          response = new Response(statusCode: 1, statusMessage: error.message);
        }
        print("-----error code==" + response.statusCode.toString());
        return networkErrorTransform(response);
      }
      if (response.data['code'] != 0) {
        DialogUtil.alertDialog(response.data['error']);
      }
      return Future.value(response.data['data']);
    }
  }

  networkErrorTransform(Response response) {
    print("networkErrorTransform === $response");
    return Future.error(NetworkError(response.statusCode, response.statusMessage));
  }
}
