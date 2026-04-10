import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prac_27/core/Functions/scaffold_message.dart';
import 'package:prac_27/core/Functions/select_image.dart';
import 'package:prac_27/core/api/constants.dart';
import 'package:prac_27/cubits/Auth/auth_cubit.dart';
import 'package:prac_27/cubits/Auth/states.dart';
import 'package:prac_27/cubits/picture/picture_cubit.dart';
import 'package:prac_27/cubits/picture/picture_state.dart';
import 'package:prac_27/screens/otp_screen.dart';
import 'package:prac_27/widgets/load_button.dart';
import 'package:prac_27/widgets/custom_field.dart';
import 'package:prac_27/widgets/custom_image.dart';
import 'package:prac_27/widgets/query_pic.dart';
import 'package:prac_27/widgets/query_text.dart';
import 'package:prac_27/widgets/title_text.dart';
import 'package:prac_27/widgets/title_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PicCubit(Picture()),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                Image(
                  height: MediaQuery.of(context).size.height * 0.075,
                  image: AssetImage(basePhoto),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TitleText(text: 'انشاء حساب جديد'),
                const SizedBox(height: 12),
                ///////////////////////image Selection//////////
                TitledWidget(
                  title: 'الصورة الشخصية',
                  widget: BlocConsumer<PicCubit, Picture>(
                    listener: (context, state) {
                      if (state is FailureUploadPicture) {
                        scaffoldMessage(
                          context,
                          message:
                              'يجب ان لاتتجاوز الصورة الحجم المعطي وان تتبع الامتداد',
                        );
                      }
                    },

                    builder: (contextt, state) {
                      if (state is PictureSelected) {
                        BlocProvider.of<AuthCubit>(context).image =
                            BlocProvider.of<PicCubit>(contextt).image;
                        return CustomImage(
                          value: ValueNotifier(state.path),
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
                        );
                      } else {
                        BlocProvider.of<AuthCubit>(contextt).image = null;
                        return QueryPhoto(
                          onTap: () async {
                            /////////////select from gallery or camera
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
                            ////////////////////////////////
                          },
                        );
                      }
                    },
                  ),
                ),

                /////////////////////////////////////////////////////
                TitledWidget(
                  title: 'اسم المستخدم',
                  widget: CustomField(
                    control: BlocProvider.of<AuthCubit>(context).username,
                  ),
                ),
                TitledWidget(
                  title: 'البريد الالكتروني',
                  widget: CustomField(
                    control: BlocProvider.of<AuthCubit>(context).email,
                  ),
                ),
                TitledWidget(
                  title: "كلمة المرور",
                  widget: CustomField(
                    obscureText: true,

                    control: BlocProvider.of<AuthCubit>(context).password,
                  ),
                ),
                TitledWidget(
                  title: "تأكيد كلمة المرور",
                  widget: CustomField(
                    obscureText: true,

                    control: BlocProvider.of<AuthCubit>(
                      context,
                    ).confirmpassword,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.043),

                //////////////////stateful part
                BlocConsumer<AuthCubit, InitialState>(
                  builder: (context, state) {
                    if (state is LoadingRegister) {
                      return LoadindButton(isLoading: true);
                    } else {
                      return LoadindButton(
                        text: 'انشاء حساب جديد',
                        onTap: () async {
                          await BlocProvider.of<AuthCubit>(context).register();
                        },
                      );
                    }
                  },
                  listener: (context, state) {
                    if (state is SuccessRegister) {
                      scaffoldMessage(context, message: state.data.message);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return OtpScreen(email: state.data.email);
                          },
                        ),
                      );
                    } else if (state is FailureRegister) {
                      scaffoldMessage(
                        context,
                        message: state.error.errorModel.errorMassege,
                      );
                    }
                  },
                ),
                //////////////////////////////////////////////
                const SizedBox(height: 6),

                QueryText(
                  ansText: 'تسجيل الدخول ',
                  quetionText: 'لديك حساب؟',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
