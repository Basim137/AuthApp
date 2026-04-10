import 'package:dio/dio.dart';
import 'package:prac_27/core/api/interceotor.dart';
import 'package:prac_27/core/api/constants.dart';
import 'package:prac_27/core/errors/expection.dart';

class DioConsumer {
  final Dio dio;
  DioConsumer({required this.dio}) {
    dio.options.baseUrl = baseurl;

    dio.options.connectTimeout = Duration(seconds: 30);
    dio.options.sendTimeout = Duration(seconds: 30);
    dio.options.receiveTimeout = Duration(seconds: 30);
    dio.interceptors.add(
      LogInterceptor(request: true, responseBody: true, requestBody: true),
    );
    dio.interceptors.add(ApiInterceptor());
  }
  Future post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    bool dataFormOrJson = true,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      Response response = await dio.post(
        path,
        data: dataFormOrJson ? FormData.fromMap(data!) : data,
        queryParameters: queryParameter,
        options: Options(headers: header),
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (error) {
      errorFunction(error);
    }
  }

  Future put(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    bool dataFormOrJson = true,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      Response response = await dio.post(
        path,
        data: dataFormOrJson ? FormData.fromMap(data!) : data,
        queryParameters: queryParameter,
        options: Options(headers: header),
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (error) {
      errorFunction(error);
    }
  }

  Future patch(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    bool dataFormOrJson = true,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      Response response = await dio.post(
        path,
        data: dataFormOrJson ? FormData.fromMap(data!) : data,
        queryParameters: queryParameter,
        options: Options(headers: header),
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (error) {
      errorFunction(error);
    }
  }

  Future delete(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    bool dataFormOrJson = false,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      Response response = await dio.delete(
        path,
        data: dataFormOrJson ? FormData.fromMap(data!) : data,
        queryParameters: queryParameter,
        options: Options(headers: header),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (error) {
      errorFunction(error);
    }
  }

  Future get(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    bool dataFormOrJson = false,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      Response response = await dio.get(
        path,
        data: dataFormOrJson ? FormData.fromMap(data!) : data,
        queryParameters: queryParameter,
        options: Options(headers: header),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (error) {
      errorFunction(error);
    }
  }
}
