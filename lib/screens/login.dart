import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:prac_27/core/Functions/scaffold_message.dart';
import 'package:prac_27/core/api/constants.dart';
import 'package:prac_27/cubits/Auth/auth_cubit.dart';
import 'package:prac_27/cubits/Auth/states.dart';
import 'package:prac_27/screens/profile_screen.dart';
import 'package:prac_27/screens/register_screen.dart';
import 'package:prac_27/widgets/load_button.dart';
import 'package:prac_27/widgets/custom_field.dart';
import 'package:prac_27/widgets/query_text.dart';
import 'package:prac_27/widgets/remember_me.dart';
import 'package:prac_27/widgets/title_text.dart';
import 'package:prac_27/widgets/title_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Image(
                height: MediaQuery.of(context).size.height * 0.075,
                image: AssetImage(basePhoto),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.027),
              TitleText(text: "تسجيل الدخول"),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              TitledWidget(
                title: 'البريد الالكتروني',
                widget: CustomField(
                  control: BlocProvider.of<AuthCubit>(context).loginEmail,
                ),
              ),
              TitledWidget(
                title: "كلمة المرور",
                widget: CustomField(
                  obscureText: true,
                  control: BlocProvider.of<AuthCubit>(context).loginPass,
                ),
              ),
              RememberMe(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.045),
              //////////////////////stateful part//////////////////
              BlocConsumer<AuthCubit, InitialState>(
                builder: (context, state) {
                  if (state is LoadingLogin) {
                    return LoadindButton(isLoading: true);
                  } else {
                    return LoadindButton(
                      text: "تسجيل الدخول",
                      onTap: () async {
                        final box = Hive.box(AppKeys.infoHive);

                        await box.put(AppKeys.image, '');

                        await BlocProvider.of<AuthCubit>(context).login();
                      },
                    );
                  }
                },
                listener: (context, state) async {
                  if (state is SuccessLogin) {
                    scaffoldMessage(context, message: state.data.message);

                    final box = Hive.box(AppKeys.infoHive);
                    await box.put(AppKeys.token, state.data.token);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  } else if (state is FailureLogin) {
                    scaffoldMessage(
                      context,
                      message: state.error.errorModel.errorMassege,
                    );
                  }
                },
              ),

              ////////////////////////////////////////////////////
              const SizedBox(height: 6),

              QueryText(
                ansText: "انشاء حساب جديد ",
                quetionText: 'ليس لديك حساب؟',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
