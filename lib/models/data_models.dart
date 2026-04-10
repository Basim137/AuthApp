import 'package:prac_27/core/api/constants.dart';

class DataModel {
  final String message;
  final String status;

  DataModel({required this.message, required this.status});
  factory DataModel.fromJson(Map<String, dynamic> jsonData) {
    return DataModel(
      message: jsonData[AppKeys.message],
      status: jsonData[AppKeys.status],
    );
  }
}

/////////////////////////////////////////////
class RegisterModel extends DataModel {
  final String image;
  final String username;
  final String email;
  final int otp;

  RegisterModel({
    required this.image,
    required this.username,
    required this.email,
    required this.otp,
    required super.message,
    required super.status,
  });
  factory RegisterModel.fromJson(Map<String, dynamic> jsonData) {
    return RegisterModel(
      image: jsonData[AppKeys.data][AppKeys.image],
      username: jsonData[AppKeys.data][AppKeys.username],
      otp: jsonData[AppKeys.data][AppKeys.otp],
      email: jsonData[AppKeys.data][AppKeys.email],
      message: jsonData[AppKeys.message],
      status: jsonData[AppKeys.status],
    );
  }
}

/////////////////////////////////////////////
class LoginModel extends DataModel {
  final String token;
  final String username;
  final String email;

  LoginModel({
    required this.token,
    required this.username,
    required this.email,
    required super.message,
    required super.status,
  });
  factory LoginModel.fromJson(Map<String, dynamic> jsonData) {
    return LoginModel(
      token: jsonData[AppKeys.data][AppKeys.token],
      username: jsonData[AppKeys.data][AppKeys.username],
      email: jsonData[AppKeys.data][AppKeys.email],

      message: jsonData[AppKeys.message],
      status: jsonData[AppKeys.status],
    );
  }
}

///////////////////////////////////////////////////
class ProfileModel extends DataModel {
  final String image;
  final int id;
  final String username;
  final String email;

  ProfileModel({
    required this.image,
    required this.username,
    required this.email,

    required this.id,
    required super.message,
    required super.status,
  });
  factory ProfileModel.fromJson(Map<String, dynamic> jsonData) {
    return ProfileModel(
      id: jsonData[AppKeys.data][AppKeys.id],
      image: jsonData[AppKeys.data][AppKeys.image],
      username: jsonData[AppKeys.data][AppKeys.username],
      email: jsonData[AppKeys.data][AppKeys.email],

      message: jsonData[AppKeys.message] ?? '',
      status: jsonData[AppKeys.status],
    );
  }
}
