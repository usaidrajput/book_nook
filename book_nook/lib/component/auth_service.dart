import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    _user.value = _auth.currentUser;
    _auth.authStateChanges().listen((User? user) {
      _user.value = user;
    });
  }

  bool isValidEmail(String email) {
    // Add email validation logic
    return RegExp(r'^[a-zA-Z][a-zA-Z0-9._%+-]*@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }

  bool isValidPhone(String phone) {
    return phone.length == 11 && RegExp(r'^[0-9]+$').hasMatch(phone);
  }

  bool isValidPassword(String password) {
    return password.length >= 8 &&
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)').hasMatch(password);
  }

  Future<String?> signUp({
    required String email,
    required String password,
    required String role,
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    try {
      // Create user in Firebase Auth
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store additional user data in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'role': role,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return null;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code} - ${e.message}');
      switch (e.code) {
        case 'network-request-failed':
          return 'Network error. Please check your internet connection.';
        case 'email-already-in-use':
          return 'Email already in use';
        case 'weak-password':
          return 'Password is too weak';
        default:
          return 'Authentication error: ${e.message}';
      }
    } catch (e) {
      print('General error: $e');
      return 'An unexpected error occurred. Please try again.';
    }
  }

  Future<String?> signIn({
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      // Add delay to ensure Firebase is ready
      await Future.delayed(Duration(milliseconds: 500));

      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        // Verify user role here if needed
        return null; // Success
      }
      return 'Login failed';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'No user found with this email';
        case 'wrong-password':
          return 'Wrong password';
        case 'network-request-failed':
          return 'Network error. Please check your connection';
        default:
          return e.message ?? 'An error occurred';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<Map<String, dynamic>?> getCurrentUserData() async {
    try {
      if (_auth.currentUser == null) {
        print("No user is currently logged in");
        return null;
      }

      // Get the current user's document from Firestore
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();

      if (!userDoc.exists) {
        print("User document not found");
        return null;
      }

      // Convert the document data to Map
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      print("Fetched user data: $userData"); // Debug print

      return userData;
    } catch (e) {
      print("Error in getCurrentUserData: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    // Clear any stored user data
    // If using Firebase Auth:
    await _auth.signOut();
    // Clear any local storage if needed
  }
}
