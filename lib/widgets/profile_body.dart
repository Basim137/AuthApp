import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:prac_27/core/Functions/get_data.dart';
import 'package:prac_27/core/Functions/scaffold_message.dart';
import 'package:prac_27/core/Functions/select_image.dart';
import 'package:prac_27/core/api/constants.dart';
import 'package:prac_27/cubits/Auth/auth_cubit.dart';
import 'package:prac_27/cubits/Auth/states.dart';
import 'package:prac_27/cubits/picture/picture_cubit.dart';
import 'package:prac_27/cubits/picture/picture_state.dart';
import 'package:prac_27/screens/login.dart';
import 'package:prac_27/widgets/load_button.dart';
import 'package:prac_27/widgets/custom_field.dart';
import 'package:prac_27/widgets/custom_image.dart';
import 'package:prac_27/widgets/custom_text.dart';
import 'package:prac_27/widgets/title_widget.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.017),

        TitledWidget(
          title: 'اسم المستخدم',
          widget: CustomField(
            control: BlocProvider.of<AuthCubit>(context).usernameUM,
          ),
        ),
        TitledWidget(
          title: 'البريد الالكتروني',
          widget: CustomField(
            control: BlocProvider.of<AuthCubit>(context).emailUM,
          ),
        ),

        ////////////////////////////photo/////////////
        BlocProvider(
          create: (context) => PicCubit(NotSelectedPicture()),
          child: TitledWidget(
            title: 'الصورة الشخصية',
            widget: BlocConsumer<PicCubit, Picture>(
              listener: (context, state) {
                if (state is FailureUploadPicture) {
                  scaffoldMessage(
                    context,
                    message: 'يجب ان لاتتجاوز الصورة المعطيات',
                  );
                } else if (state is SuccessPicture) {
                  BlocProvider.of<AuthCubit>(context).imageUm.value =
                      state.imageDownloadedImg;
                } else if (state is PictureSelected) {
                  BlocProvider.of<AuthCubit>(context).imageUm.value =
                      state.path;
                }
              },

              builder: (contextt, state) {
                final box = Hive.box(AppKeys.infoHive);
                if (box.get(AppKeys.image) == '' ||
                    box.get(AppKeys.image) == null) {
                  BlocProvider.of<PicCubit>(contextt).dowloadImage(
                    path: BlocProvider.of<AuthCubit>(context).networkImg,
                  );
                }
                return CustomImage(
                  onTap: () {
                    selectFromGalleryOrCamera(
                      context,
                      gallery: () async {
                        await BlocProvider.of<PicCubit>(
                          contextt,
                        ).selectGalleryImage();
                        Navigator.pop(context);
                      },
                      camera: () async {
                        await BlocProvider.of<PicCubit>(
                          contextt,
                        ).selectCameraImage();
                        Navigator.pop(context);
                      },
                    );
                  },
                  value: BlocProvider.of<AuthCubit>(context).imageUm,
                );
              },
            ),
          ),
        ),
        ////////////////////////////////
        TitledWidget(
          title: 'كلمة المرور القديمة',
          widget: CustomField(
            obscureText: true,
            control: BlocProvider.of<AuthCubit>(context).oldPassword,
          ),
        ),
        TitledWidget(
          title: 'كلمة المرور الجديدة',
          widget: CustomField(
            obscureText: true,
            control: BlocProvider.of<AuthCubit>(context).newPassword,
          ),
        ),
        TitledWidget(
          title: 'تأكيد كلمة المرور الجديدة',
          widget: CustomField(
            obscureText: true,
            control: BlocProvider.of<AuthCubit>(context).newConfirmPassword,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.036),
        /////////////////////////////////////stateful part/////////////////
        BlocConsumer<AuthCubit, InitialState>(
          builder: (context, state) {
            if (state is LoadingUpdate) {
              return LoadindButton(isLoading: true);
            } else {
              return Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 50),
                child: LoadindButton(
                  text: "حفظ التغيرات",
                  onTap: () async {
                    await BlocProvider.of<AuthCubit>(context).updateInfo();
                  },
                ),
              );
            }
          },
          listener: (context, state) async {
            if (state is SuccessUpdate) {
              BlocProvider.of<AuthCubit>(context).oldPassword.clear();
              BlocProvider.of<AuthCubit>(context).newPassword.clear();
              BlocProvider.of<AuthCubit>(context).newConfirmPassword.clear();
              await getData(context, state.data);
              scaffoldMessage(context, message: state.data.message);
            } else if (state is FailureUpdate) {
              scaffoldMessage(
                context,
                message: state.error.errorModel.errorMassege,
              );
            }
          },
        ),
        const SizedBox(height: 4),
        ///////////////////////////////////////////
        ///////////////////////other stateful part //////////////////////////
        BlocConsumer<AuthCubit, InitialState>(
          listener: (context, state) async {
            if (state is SuccessLogout) {
              scaffoldMessage(context, message: state.data.message);

              ///////////////////new
              BlocProvider.of<AuthCubit>(context).imageUm.value = '';
              ////////////////////////
              final box = Hive.box(AppKeys.infoHive);
              await box.put(AppKeys.islogined, false);
              await box.put(AppKeys.networkImage, '');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            } else if (state is FailureLogout) {
              scaffoldMessage(
                context,
                message: state.error.errorModel.errorMassege,
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingLogout) {
              return SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(
                  strokeAlign: 3,
                  color: const Color.fromARGB(255, 16, 139, 129),
                ),
              );
            } else {
              return CustomButtonTExt(
                onTap: () async {
                  await BlocProvider.of<AuthCubit>(context).logOut();
                },
                text: "تسجيل الخروج",
              );
            }
          },
        ),
        //////////////////////////////////////////////////////////////
      ],
    );
  }
}
