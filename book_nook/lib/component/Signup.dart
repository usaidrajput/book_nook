import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_screen/component/home_screen.dart';
import 'package:get/get.dart';
import 'package:fyp_screen/component/auth_service.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final AuthService _authService = Get.find<AuthService>();
  bool _isPasswordVisible = false;
  bool _agreeToTerms = false;
  String? _selectedAccountType = 'Buyer';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let's Create an account",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 32.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Account Type Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedAccountType,
                      decoration: InputDecoration(
                        labelText: 'Choose Account Type',
                        prefixIcon: const Icon(FontAwesomeIcons.userDoctor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedAccountType = newValue;
                        });
                      },
                      items: <String>['Seller', 'Buyer']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              labelText: "First Name",
                              prefixIcon: const Icon(FontAwesomeIcons.user),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Please enter first name'
                                : null,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                              labelText: "Last Name",
                              prefixIcon: Icon(FontAwesomeIcons.user),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Please enter last name'
                                : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!_authService.isValidEmail(value)) {
                          return 'Email must start with a letter and include a number';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(FontAwesomeIcons.envelope),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (!_authService.isValidPhone(value)) {
                          return 'Phone number must be exactly 11 digits';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                        prefixIcon: Icon(FontAwesomeIcons.phone),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (!_authService.isValidPassword(value)) {
                          return 'Password must be 8+ chars with letters and numbers';
                        }
                        return null;
                      },
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(FontAwesomeIcons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: _agreeToTerms,
                            onChanged: (value) {
                              setState(() {
                                _agreeToTerms = value ?? false;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "I agree to ",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              TextSpan(
                                text: "Privacy Policy ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      decoration: TextDecoration.underline,
                                      color: const Color.fromARGB(
                                          255, 65, 33, 243),
                                    ),
                              ),
                              TextSpan(
                                text: "and ",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              TextSpan(
                                text: "Terms of Use",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      decoration: TextDecoration.underline,
                                      color: const Color.fromARGB(
                                          255, 65, 33, 243),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    // Sign Up Button with Blue Color and White Text
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Blue button color
                          elevation: 2, // Add slight elevation
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        onPressed: _handleSignup,
                        child: const Text(
                          "Create Account",
                          style: TextStyle(color: Colors.white), // White text
                        ),
                      ),
                    ),
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
                  // Google Icon with White Circle and Shadow
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // White circle background
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 8.0,
                          spreadRadius: 2.0,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Add Google login logic here
                      },
                      icon: const Icon(FontAwesomeIcons.google,
                          color: Colors.red),
                      iconSize: 36.0,
                    ),
                  ),
                  // Facebook Icon with White Circle and Shadow
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // White circle background
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 8.0,
                          spreadRadius: 2.0,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Add Facebook login logic here
                      },
                      icon: const Icon(FontAwesomeIcons.facebook,
                          color: Colors.blue),
                      iconSize: 36.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeToTerms) {
      Get.snackbar(
        'Error',
        'Please agree to the terms and conditions',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final error = await _authService.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        role: _selectedAccountType!.toLowerCase(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        phone: _phoneController.text.trim(),
      );

      Get.back(); // Close loading dialog

      if (error == null) {
        Get.snackbar(
          'Success',
          'Account created successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await Future.delayed(const Duration(seconds: 1));
        Get.offAll(() => Home_Screen());
      } else {
        Get.snackbar(
          'Error',
          error,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.back(); // Close loading dialog
      print('Signup error: $e');
      Get.snackbar(
        'Error',
        'Failed to create account. Please check your internet connection.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
