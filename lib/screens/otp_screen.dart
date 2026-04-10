import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prac_27/core/Functions/scaffold_message.dart';
import 'package:prac_27/core/api/constants.dart';
import 'package:prac_27/cubits/Auth/auth_cubit.dart';
import 'package:prac_27/cubits/Auth/states.dart';
import 'package:prac_27/screens/login.dart';
import 'package:prac_27/widgets/load_button.dart';

import 'package:prac_27/widgets/otp_field.dart';
import 'package:prac_27/widgets/query_text.dart';
import 'package:prac_27/widgets/title_text.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int? firstPosition;
  int? secondPosition;
  int? thirdPosition;
  int? fourthPosition;

  int otpNum = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image(
              height: MediaQuery.of(context).size.height * 0.075,
              image: AssetImage(basePhoto),
            ),
            const Spacer(),
            TitleText(text: 'رمز التحقق'),
            const SizedBox(height: 10),
            const Text(
              textAlign: TextAlign.center,
              'لاستكمال فتح حسابك ادخل رمز التحقق المرسل عبر البريد الالكتروني',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  OtpField(
                    onChanged: (p0) {
                      if (p0.isNotEmpty) {
                        if (int.tryParse(p0) != null) {
                          firstPosition = int.parse(p0);
                        }

                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                  OtpField(
                    onChanged: (p0) {
                      if (p0.isNotEmpty) {
                        if (int.tryParse(p0) != null) {
                          secondPosition = int.parse(p0);
                        }

                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                  OtpField(
                    onChanged: (p0) {
                      if (p0.isNotEmpty) {
                        if (int.tryParse(p0) != null) {
                          thirdPosition = int.parse(p0);
                        }

                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                  OtpField(
                    onChanged: (p0) {
                      if (p0.isNotEmpty) {
                        if (int.tryParse(p0) != null) {
                          fourthPosition = int.parse(p0);
                        }

                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 20),
                QueryText(
                  ansText: "اعادة الارسال ",
                  quetionText: 'لم يصلك رمز؟',
                  textFontSize: 12,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                Text(
                  '00:59 Sec',
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color.fromARGB(255, 100, 105, 108),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            /////////////////////////////stateful part /////////////////
            BlocConsumer<AuthCubit, InitialState>(
              listener: (context, state) {
                if (state is SuccessOtp) {
                  scaffoldMessage(context, message: state.data.message);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ),
                    (route) => false,
                  );
                } else if (state is FailureOtp) {
                  scaffoldMessage(
                    context,
                    message: state.error.errorModel.errorMassege,
                  );
                }
              },
              builder: (context, state) {
                if (state is LoadingOtp) {
                  return LoadindButton(isLoading: true);
                } else {
                  return LoadindButton(
                    text: "المتابعة",
                    onTap: () async {
                      if (firstPosition == null ||
                          secondPosition == null ||
                          thirdPosition == null ||
                          fourthPosition == null) {
                        scaffoldMessage(context, message: 'كود غير مكتمل');
                        return;
                      }
                      otpNum =
                          firstPosition! * 1000 +
                          secondPosition! * 100 +
                          thirdPosition! * 10 +
                          fourthPosition!;

                      await BlocProvider.of<AuthCubit>(
                        context,
                      ).otp(email: widget.email, otp: otpNum);
                    },
                  );
                }
              },
            ),
            ////////////////////////////////////////////
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
