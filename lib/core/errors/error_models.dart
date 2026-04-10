import 'package:prac_27/core/api/constants.dart';

class ErrorModel {
  final String errorMassege;

  ErrorModel({required this.errorMassege});

  factory ErrorModel.fromJson(Map<dynamic, dynamic> error) {
    return ErrorModel(errorMassege: error[AppKeys.message]);
  }
}
