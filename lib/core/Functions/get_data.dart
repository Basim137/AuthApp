import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:prac_27/core/api/constants.dart';
import 'package:prac_27/cubits/Auth/auth_cubit.dart';
import 'package:prac_27/models/data_models.dart';

getData(BuildContext context, ProfileModel data) async {
  ////////////////////give data to cubit for show
  BlocProvider.of<AuthCubit>(context).emailUM.text = data.email;
  BlocProvider.of<AuthCubit>(context).usernameUM.text = data.username;
  BlocProvider.of<AuthCubit>(context).networkImg = data.image;
  ///////////////////////// storing data
  final box = Hive.box(AppKeys.infoHive);
  await box.put(AppKeys.email, data.email);
  await box.put(AppKeys.username, data.username);
  await box.put(AppKeys.networkImage, data.image);
  await box.put(AppKeys.isCompletedInfo, true);

  /////////////////
  ///
  ///
}
