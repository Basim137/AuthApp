import 'package:prac_27/models/data_models.dart';
import 'package:prac_27/core/errors/expection.dart';

class InitialState {}

////////////////////////////////REGISTER
class FailureRegister extends InitialState {
  final RequestExpection error;

  FailureRegister({required this.error});
}

class LoadingRegister extends InitialState {}

class SuccessRegister extends InitialState {
  final RegisterModel data;

  SuccessRegister({required this.data});
}
///////////////////////////////

//---------------------------------------------------------

///////////////////////////OTP
class LoadingOtp extends InitialState {}

class FailureOtp extends InitialState {
  final RequestExpection error;

  FailureOtp({required this.error});
}

class SuccessOtp extends InitialState {
  final DataModel data;

  SuccessOtp({required this.data});
}
////////////////////////////////

//-----------------------------------------------------------

////////////////Login
class SuccessLogin extends InitialState {
  final LoginModel data;

  SuccessLogin({required this.data});
}

class FailureLogin extends InitialState {
  final RequestExpection error;

  FailureLogin({required this.error});
}

class LoadingLogin extends InitialState {}
//////////////////////

//-----------------------------------------------------------

////////////////Logout
class SuccessLogout extends InitialState {
  final DataModel data;

  SuccessLogout({required this.data});
}

class FailureLogout extends InitialState {
  final RequestExpection error;

  FailureLogout({required this.error});
}

class LoadingLogout extends InitialState {}
//////////////////////

//-----------------------------------------------------------

////////////////Update//////////////
class SuccessUpdate extends InitialState {
  final ProfileModel data;

  SuccessUpdate({required this.data});
}

class FailureUpdate extends InitialState {
  final RequestExpection error;

  FailureUpdate({required this.error});
}

class LoadingUpdate extends InitialState {}
//////////////////////

//-----------------------------------------------------------

////////////////GET DETAILS//////////////
class SuccessGetInfo extends InitialState {
  final ProfileModel data;

  SuccessGetInfo({required this.data});
}

class FailureGetInfo extends InitialState {
  final RequestExpection error;

  FailureGetInfo({required this.error});
}

class LoadingGetInfo extends InitialState {}

class StorageGetInfo extends InitialState {}
//////////////////////