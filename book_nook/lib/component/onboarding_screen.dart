import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import '../constant/constant.dart';
import '../component/second_ceate_account.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      // Main configuration
      finishButtonText: 'Get Started',
      skipTextButton: const Text(
        'Skip',
        style: TextStyle(
          color: customBlue,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      // trailing: const Text(
      //   'Login',
      //   style: TextStyle(
      //     color: customBlue,
      //     fontSize: 16,
      //     fontWeight: FontWeight.w600,
      //   ),
      // ),

      // Appearance
      controllerColor: customBlue,
      totalPage: 3,
      headerBackgroundColor: Colors.white,
      pageBackgroundColor: Colors.white,
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: customBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),

      // Content
      centerBackground: true,
      background: [
        Center(
          child: Image.asset(
            'images/pana.png',
            height: MediaQuery.of(context).size.height * 0.5,
          ),
        ),
        Center(
          child: Image.asset(
            'images/pana.png',
            height: MediaQuery.of(context).size.height * 0.5,
          ),
        ),
        Center(
          child: Image.asset(
            'images/third.png',
            height: MediaQuery.of(context).size.height * 0.5,
          ),
        ),
      ],

      // Speed settings
      speed: 1.8,

      // Page content
      pageBodies: [
        _buildPageContent(
          title1: 'Discover',
          title2: 'New Books',
          description:
              'Discover second-hand books at discounted prices for every subject and course',
          color1: Colors.black,
          color2: customBlue,
        ),
        _buildPageContent(
          title1: 'Learn About',
          title2: 'Quick Delivery',
          description: 'Get your Book delivered quickly and conveniently',
          color1: customBlue,
          color2: Colors.black,
        ),
        _buildPageContent(
          title1: 'Effortless',
          title2: 'Start Today!',
          description: 'Start your culinary journey with us today!',
          color1: Colors.black,
          color2: customBlue,
        ),
      ],

      // Navigation callbacks
      onFinish: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => SecondCeateAccount(),
          ),
        );
      },
    );
  }

  Widget _buildPageContent({
    required String title1,
    required String title2,
    required String description,
    required Color color1,
    required Color color2,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$title1 ',
                  style: TextStyle(
                    color: color1,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: title2,
                  style: TextStyle(
                    color: color2,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
                height: 1.5,
                letterSpacing: 1.2),
          ),
          const SizedBox(height: 80), // Space for the bottom controls
        ],
      ),
    );
  }
}
