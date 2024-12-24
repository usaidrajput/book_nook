import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_screen/component/Signup.dart';
import 'package:fyp_screen/component/home_screen.dart';
// import './navigation_bar.dart';
import 'package:get/get.dart';
import '../component/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Ensure this file exists and the Signup widget is implemented correctly.

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = Get.put(AuthService());
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _selectedBookType; // For selected value
  bool _isDropdownVisible = false; // Controls visibility of the dropdown list
  final List<String> _bookTypes = ["Buyer", "Seller"]; // Dropdown options
  int _loginAttempts = 0;
  DateTime? _lockoutTime;
  static const int MAX_LOGIN_ATTEMPTS = 5;
  static const int LOCKOUT_DURATION_MINUTES = 15;

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    if (_lockoutTime != null && DateTime.now().isBefore(_lockoutTime!)) {
      final remainingMinutes =
          _lockoutTime!.difference(DateTime.now()).inMinutes;
      Get.snackbar(
        'Account Locked',
        'Too many failed attempts. Please try again after $remainingMinutes minutes.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
      return;
    }

    if (_selectedBookType == null) {
      Get.snackbar(
        'Error',
        'Please select an account type',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Try to sign in with Firebase
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // If successful, proceed with role-based login
      final error = await _authService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        role: _selectedBookType!.toLowerCase(),
      );

      if (error == null) {
        _loginAttempts = 0;
        Get.offAll(() => Home_Screen());
      }
    } on FirebaseAuthException catch (e) {
      _loginAttempts++;

      if (_loginAttempts >= MAX_LOGIN_ATTEMPTS) {
        _lockoutTime =
            DateTime.now().add(Duration(minutes: LOCKOUT_DURATION_MINUTES));
        Get.snackbar(
          'Account Locked',
          'Too many failed attempts. Please try again after $LOCKOUT_DURATION_MINUTES minutes.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
        return;
      }

      // Specific error messages for different cases
      if (e.code == 'user-not-found') {
        Get.snackbar(
          'Error',
          'This email is not registered. Please create an account.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          'Error',
          'Password does not match this email.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      } else if (e.code == 'invalid-email') {
        Get.snackbar(
          'Error',
          'Please enter a valid email address.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          'Error',
          'Login failed. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleForgotPassword() async {
    if (_emailController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email address first',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text,
      );
      Get.snackbar(
        'Success',
        'A password reset link has been sent to your email.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send reset email. Please check your email address.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 56.0,
            left: 24.0,
            right: 24.0,
            bottom: 24.0,
          ),
          child: Column(
            children: [
              Column(
                children: [
                  const Image(
                    height: 130,
                    image: AssetImage("images/booknook.png"),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    "Welcome Back!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Sign in to continue",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.envelope),
                        labelText: "E-Mail",
                      ),
                      validator: _emailValidator,
                    ),
                    const SizedBox(height: 16.0),
                    // Dropdown styled as a TextFormField
                    Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.centerStart,
                          children: [
                            if (_selectedBookType == null &&
                                !_isDropdownVisible)
                              const Padding(
                                padding: EdgeInsets.only(left: 50.0),
                                child: Text(
                                  "Choose Account Type",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isDropdownVisible = !_isDropdownVisible;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 12.0,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.store,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 12.0),
                                    Expanded(
                                      child: Text(
                                        _selectedBookType ?? "",
                                        style: TextStyle(
                                          color: _selectedBookType == null
                                              ? Colors.grey
                                              : Colors.black,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (_isDropdownVisible)
                          Column(
                            children: _bookTypes
                                .map(
                                  (type) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedBookType = type;
                                        _isDropdownVisible = false;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12.0,
                                        horizontal: 16.0,
                                      ),
                                      color: Colors.transparent,
                                      child: Text(
                                        type,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.lock),
                        labelText: "Password",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: true, onChanged: (value) {}),
                            const Text("Remember Me"),
                          ],
                        ),
                        TextButton(
                          onPressed: _handleForgotPassword,
                          child: const Text("Forgot Password"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text("Sign In"),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Get.to(() => const Signup()),
                        child: const Text("Create Account"),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Text("OR"),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Divider(
                      thickness: 1.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      // Add Google login logic here
                    },
                    icon:
                        const Icon(FontAwesomeIcons.google, color: Colors.red),
                    iconSize: 36.0,
                  ),
                  IconButton(
                    onPressed: () {
                      // Add Facebook login logic here
                    },
                    icon: const Icon(FontAwesomeIcons.facebook,
                        color: Colors.blue),
                    iconSize: 36.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
