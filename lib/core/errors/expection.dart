import 'package:dio/dio.dart';

import 'package:prac_27/core/errors/error_models.dart';

class RequestExpection implements Exception {
  final int? statusCode;
  final ErrorModel errorModel;
  RequestExpection({required this.errorModel, this.statusCode});
}

errorFunction(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      throw RequestExpection(
        errorModel: ErrorModel(errorMassege: 'connection timeout'),
      );
    case DioExceptionType.sendTimeout:
      throw RequestExpection(
        errorModel: ErrorModel(errorMassege: 'send timeout'),
      );
    case DioExceptionType.receiveTimeout:
      throw RequestExpection(
        errorModel: ErrorModel(errorMassege: 'receive timeout'),
      );
    case DioExceptionType.badCertificate:
      throw RequestExpection(
        errorModel: ErrorModel(errorMassege: 'badCertificate'),
      );
    case DioExceptionType.badResponse:
      switch (error.response!.statusCode) {
        case 404:
          throw RequestExpection(
            statusCode: error.response!.statusCode,
            errorModel: ErrorModel.fromJson(error.response!.data),
          );
        case 422:
          throw RequestExpection(
            statusCode: error.response!.statusCode,
            errorModel: ErrorModel.fromJson(error.response!.data),
          );
        case 400:
          throw RequestExpection(
            statusCode: error.response!.statusCode,
            errorModel: ErrorModel.fromJson(error.response!.data),
          );

        case 401:
          throw RequestExpection(
            statusCode: error.response!.statusCode,
            errorModel: ErrorModel.fromJson(error.response!.data),
          );

        default:
          throw RequestExpection(
            statusCode: error.response!.statusCode,
            errorModel: ErrorModel.fromJson(error.response!.data),
          );
      }

    case DioExceptionType.cancel:
      throw RequestExpection(errorModel: ErrorModel(errorMassege: 'cancel'));
    case DioExceptionType.connectionError:
      throw RequestExpection(
        errorModel: ErrorModel(errorMassege: 'Connection Error'),
      );
    case DioExceptionType.unknown:
      throw RequestExpection(errorModel: ErrorModel(errorMassege: 'Unknown'));
  }
}
