import 'package:dio/dio.dart';
import 'package:networks_app/model/request_vs_response/request_model.dart';
import 'package:networks_app/model/request_vs_response/response_model.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';
class DioNetworkService { 
  Dio? _dio;

 static final _instance=DioNetworkService._private();// oxirida yoziladi
 factory DioNetworkService()=>_instance;// oxirgi qismida yoziladi
  DioNetworkService._private(){

    try {
      _dio=Dio(
        BaseOptions(
          baseUrl: _Urls.base,
          connectTimeout: 15000,
          receiveTimeout: 5000,
          sendTimeout: 15000,
        )
      )
      ..interceptors.add(_appHeaderInterceptor!);
      debugPrint('INITED DIO SRC');
    } catch (e) {
   
    log(e.toString()); 
    }
  }

  Future<ResponseModel?>addPost(RequestBodyModel body)async{
    try {
      var response=await _dio!.post<Map<String,dynamic>>(_Urls.addPost,
      data: body.toJson());
      if (response.statusCode==200||response.statusCode==201) {
        debugPrint(response.data.toString());
        return ResponseModel.fromJson(response.data!);
      }
    } catch (e) {
      log(e.toString());
    }
    return ResponseModel.fromJson({});
  }

  AppHeaderInterceptor? get _appHeaderInterceptor=>AppHeaderInterceptor();
    AppHeaderInterceptor? get _appTokenInterceptor=> AppHeaderInterceptor();
  }
  class AppHeaderInterceptor extends Interceptor {  
    void onRequest(RequestOptions options,RequestInterceptorHandler handler){
      options.data.addAll({'userId':'5'});
      super.onRequest(options, handler);
    }
  }

  class AppTokenInterceptor extends Interceptor {  
    void onRequest(RequestOptions options,RequestInterceptorHandler handler){
      options.headers['token']='xcxcxcxc';
      super.onRequest(options, handler);
    }
  }

class _Urls {
  static const base= 'https://dummyjson.com';
  static const addPost='/posts/add';
}