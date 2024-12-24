import 'package:flutter/material.dart';
import 'package:fyp_screen/component/onboarding_screen.dart';
import 'package:fyp_screen/component/home_screen.dart';
import 'package:get/get.dart';
// firebaes
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'component/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Obx(() {
        final authService = Get.put(AuthService());
        return authService.user != null ? Home_Screen() : OnboardingScreen();
      }),
    );
  }
}
