

import 'package:filmboxd/pages/auth_page.dart';
import 'package:filmboxd/pages/edit_profile_page.dart';
import 'package:filmboxd/pages/home_page.dart';
import 'package:filmboxd/pages/movie_details_screen.dart';
import 'package:filmboxd/pages/profile_page.dart';
import 'package:filmboxd/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(720, 1400),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: RootPage(),
        );
      },
    );
  }
}