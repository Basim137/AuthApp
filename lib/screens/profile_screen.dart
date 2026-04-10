import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prac_27/core/Functions/get_data.dart';
import 'package:prac_27/core/Functions/scaffold_message.dart';
import 'package:prac_27/core/api/constants.dart';
import 'package:prac_27/cubits/Auth/auth_cubit.dart';
import 'package:prac_27/cubits/Auth/states.dart';
import 'package:prac_27/widgets/custom_appbar.dart';
import 'package:prac_27/widgets/profile_body.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<AuthCubit>(context).getInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 20, 179, 165),
              const Color.fromARGB(255, 8, 75, 70),
            ],
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.018),
            Expanded(child: CustomAppBar()),

            Container(
              height: MediaQuery.of(context).size.height - 85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  ////////////////////////////stateful part ///////////
                  child: BlocConsumer<AuthCubit, InitialState>(
                    listener: (context, state) async {
                      if (state is FailureGetInfo) {
                        scaffoldMessage(
                          context,
                          message: state.error.errorModel.errorMassege,
                        );
                      } else if (state is SuccessGetInfo) {
                        await getData(context, state.data);
                      } else if (state is StorageGetInfo) {
                        final box = Hive.box(AppKeys.infoHive);

                        BlocProvider.of<AuthCubit>(context).emailUM.text = box
                            .get(AppKeys.email);
                        BlocProvider.of<AuthCubit>(context).usernameUM.text =
                            box.get(AppKeys.username);
                        BlocProvider.of<AuthCubit>(context).imageUm.value = box
                            .get(AppKeys.image);
                      }
                    },
                    builder: (context, state) {
                      if (state is LoadingGetInfo) {
                        return Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 4,
                            ),
                            CircularProgressIndicator(
                              color: const Color.fromARGB(255, 20, 179, 165),
                            ),
                          ],
                        );
                      } else {
                        return ProfileBody();
                      }
                    },
                  ),

                  ////////////////////////////////////////////////////
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
