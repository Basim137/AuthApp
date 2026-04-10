import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:prac_27/core/api/constants.dart';
import 'package:prac_27/core/api/dio_consumer.dart';
import 'package:prac_27/cubits/Auth/auth_cubit.dart';
import 'package:prac_27/cubits/Auth/states.dart';
import 'package:prac_27/screens/login.dart';
import 'package:prac_27/screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final box = await Hive.openBox(AppKeys.infoHive);

  if (!box.containsKey(AppKeys.islogined)) {
    await box.put(AppKeys.islogined, false);
  }
  if (!box.containsKey(AppKeys.isCompletedInfo)) {
    await box.put(AppKeys.isCompletedInfo, false);
  }
  if (!box.containsKey(AppKeys.image)) {
    await box.put(AppKeys.image, '');
  }

  if ((!box.get(AppKeys.islogined)) && (box.get(AppKeys.isCompletedInfo))) {
    await box.put(AppKeys.isCompletedInfo, false);
  }

  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthCubit(InitialState(), dioconsumer: DioConsumer(dio: Dio())),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Almarai',
          scaffoldBackgroundColor: const Color.fromARGB(255, 247, 246, 244),
        ),
        debugShowCheckedModeBanner: false,

        home: Hive.box(AppKeys.infoHive).get(AppKeys.islogined)
            ? ProfileScreen()
            : LoginPage(),
      ),
    );
  }
}
