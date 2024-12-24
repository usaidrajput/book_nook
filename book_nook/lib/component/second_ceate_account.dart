import 'package:flutter/material.dart';
import 'package:fyp_screen/component/Signup.dart';
import './login_page.dart';

class SecondCeateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 0, 230),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Align(
              alignment: Alignment
                  .topCenter, // Align it to the top center or as desired
              child: Container(
                height: 250, // Desired height for the image
                width: 250, // Desired width for the image
                child: Image.asset(
                  "images/booknook.png", // Ensure this path is correct
                  fit: BoxFit.cover, // Adjust the fit as needed
                ),
              ),
            ),
            // Welcome Text
            const SizedBox(height: 50),
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Scrolling Text
            const SizedBox(height: 5),
            Container(
              width: 200,
              child: const Text(
                'Buy and selling without limits',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 25),

            // White Button with increased width
            Container(
              width: 300, // Set the width here
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Signup()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color.fromARGB(255, 12, 0, 230),
                  padding: const EdgeInsets.symmetric(
                      vertical: 15), // Adjust padding as needed
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Create Account'),
              ),
            ),

            const SizedBox(height: 25),

            // Border Button with increased width
            Container(
              width: 300, // Set the width here
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  padding: const EdgeInsets.symmetric(
                      vertical: 15), // Adjust padding as needed
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
