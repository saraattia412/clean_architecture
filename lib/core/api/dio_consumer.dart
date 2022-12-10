import 'dart:convert';
import 'dart:io';
import 'package:clean_architecture/core/api/api_consumer.dart';
import 'package:clean_architecture/core/api/app_intercepters.dart';
import 'package:clean_architecture/core/api/end_points.dart';
import 'package:clean_architecture/core/api/status_code.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:clean_architecture/injection_container.dart' as di;
import 'package:flutter/foundation.dart';
import '../error/exceptions.dart';


class DioConsumer implements ApiConsumer{
  final Dio client ;


  //start constructor :
  DioConsumer({required this.client}){
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
  };
    client.options
    ..baseUrl=EndPoints.baseUrl
    ..responseType = ResponseType.plain
    ..followRedirects = false
    ..validateStatus =(status){
      return status! < StatusCode.internalServerError;
    };

    client.interceptors.add(di.sl<AppInterceptors>());
    if (kDebugMode) {
      client.interceptors.add(di.sl<LogInterceptor>());
    }
  }//end constructor .

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try{
      final response = await client.get(
        path,
        queryParameters: queryParameters,
      );
      return handelResponseAsJson(response);
    } on DioError catch(error){
      handelDioError(error);
    }
  }

  @override
  Future post(String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
  }) async {
    try{
      final response = await client.post(
        path,
        queryParameters: queryParameters,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
      );
      return handelResponseAsJson(response);
    } on DioError catch(error){
      handelDioError(error);
    }
  }

  @override
  Future put(String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    try{
      final response = await client.put(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return handelResponseAsJson(response);
    } on DioError catch(error){
      handelDioError(error);
    }
  }


  dynamic handelResponseAsJson(Response<dynamic> response){
    final responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }

  dynamic handelDioError(DioError dioError){
    switch(dioError.type){

      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw const FetchDataException();
      case DioErrorType.response:
        switch(dioError.response?.statusCode){
          case StatusCode.badRequest:
            throw const BadRequestException();
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw const UnauthorizedException();
          case StatusCode.notFound:
            throw const NotFoundException();
          case StatusCode.internalServerError:
            throw const InternalServerErrorException();
          case StatusCode.confilct:
            throw const ConflictException();
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw const NoInternetConnectionException();

   }
  }

}