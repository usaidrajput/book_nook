import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import './second_ceate_account.dart';

class UserScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the SecondCreateAccount screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecondCeateAccount()),
        );
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 12, 0, 230),
        body: Center(
          child: Image.asset(
            "images/logo1.png",
            height: 400,
            width: 400,
          ).animate().fadeIn(duration: 5.seconds).scale(delay: 500.ms),
        ),
      ),
    );
  }
}
