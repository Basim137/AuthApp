import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prac_27/core/api/constants.dart';
import 'package:prac_27/core/api/dio_consumer.dart';
import 'package:prac_27/core/errors/expection.dart';
import 'package:prac_27/cubits/Auth/states.dart';
import 'package:prac_27/models/data_models.dart';

class AuthCubit extends Cubit<InitialState> {
  final DioConsumer dioconsumer;
  XFile? image;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  ValueNotifier<String> imageUm = ValueNotifier('');
  String networkImg = '';
  TextEditingController usernameUM = TextEditingController();
  TextEditingController emailUM = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newConfirmPassword = TextEditingController();
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPass = TextEditingController();

  AuthCubit(super.initialState, {required this.dioconsumer});
  Future register() async {
    try {
      emit(LoadingRegister());
      final dataa = await dioconsumer.post(
        dataFormOrJson: true,
        registerLink,
        data: {
          AppKeys.email: email.text,
          AppKeys.username: username.text,
          AppKeys.password: password.text,
          AppKeys.confirmPassword: confirmpassword.text,
          AppKeys.image: image != null
              ? await MultipartFile.fromFile(
                  image!.path,
                  filename: image!.path.split('/').last,
                )
              : null,
        },
      );
      emit(SuccessRegister(data: RegisterModel.fromJson(dataa)));
    } on RequestExpection catch (err) {
      emit(FailureRegister(error: err));
    }
  }

  Future login() async {
    try {
      emit(LoadingLogin());
      final dataa = await dioconsumer.post(
        dataFormOrJson: true,
        loginLink,
        data: {
          AppKeys.email: loginEmail.text,
          AppKeys.password: loginPass.text,
        },
      );

      emit(SuccessLogin(data: LoginModel.fromJson(dataa)));
    } on RequestExpection catch (err) {
      emit(FailureLogin(error: err));
    }
  }

  Future logOut() async {
    try {
      emit(LoadingLogout());

      final String token = await Hive.box(AppKeys.infoHive).get(AppKeys.token);

      final dataa = await dioconsumer.delete(
        logoutLink,
        header: {AppKeys.authorization: 'Bearer $token'},
      );
      await Hive.box(AppKeys.infoHive).put(AppKeys.token, null);
      emit(SuccessLogout(data: DataModel.fromJson(dataa)));
    } on RequestExpection catch (err) {
      emit(FailureLogout(error: err));
    }
  }

  Future otp({required String email, required int otp}) async {
    try {
      emit(LoadingOtp());
      final dataa = await dioconsumer.get(
        dataFormOrJson: false,
        otpLink,
        queryParameter: {AppKeys.email: email, AppKeys.otp: otp},
      );
      emit(SuccessOtp(data: DataModel.fromJson(dataa)));
    } on RequestExpection catch (err) {
      emit(FailureOtp(error: err));
    }
  }

  Future updateInfo() async {
    try {
      emit(LoadingUpdate());
      final String token = await Hive.box(AppKeys.infoHive).get(AppKeys.token);
      final dataa = await dioconsumer.post(
        header: {AppKeys.authorization: 'Bearer $token'},
        dataFormOrJson: true,
        updateLink,
        data: {
          AppKeys.email: emailUM.text,
          AppKeys.username: usernameUM.text,
          AppKeys.image: imageUm.value.isNotEmpty
              ? await MultipartFile.fromFile(
                  imageUm.value,
                  filename: imageUm.value.split('/').last,
                )
              : null,

          AppKeys.password: oldPassword.text,
          AppKeys.newPassword: newPassword.text,
          AppKeys.newConfirmPassword: newConfirmPassword.text,
          AppKeys.method: 'PUT',
        },
      );
      emit(SuccessUpdate(data: ProfileModel.fromJson(dataa)));
    } on RequestExpection catch (err) {
      emit(FailureUpdate(error: err));
    }
  }

  Future getInfo() async {
    final box = Hive.box(AppKeys.infoHive);

    if (box.get(AppKeys.islogined) && box.get(AppKeys.isCompletedInfo)) {
      emit(StorageGetInfo());
      return;
    }

    try {
      emit(LoadingGetInfo());
      final String? token = await Hive.box(AppKeys.infoHive).get(AppKeys.token);
      final dataa = await dioconsumer.get(
        dataFormOrJson: false,
        infoLink,
        header: {AppKeys.authorization: 'Bearer $token'},
      );

      emit(SuccessGetInfo(data: ProfileModel.fromJson(dataa)));
    } on RequestExpection catch (err) {
      emit(FailureGetInfo(error: err));
    }
  }
}
