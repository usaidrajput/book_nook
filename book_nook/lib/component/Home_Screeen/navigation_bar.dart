import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './home_screen.dart'; // Ensure the HomeScreen is imported correctly

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) {
            controller.selectedIndex.value = index;
            print("Selected index: $index"); // Debug statement
          },
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.shop), label: 'Store'),
            NavigationDestination(
                icon: Icon(Icons.favorite), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() {
        print(
            "Displaying screen for index: ${controller.selectedIndex.value}"); // Debug statement
        return controller.screens[controller.selectedIndex.value];
      }),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  // Ensure the number of screens matches the destinations
  final screens = [
    const HomeScreen(), // Corrected the case to HomeScreen
    Container(color: Colors.green), // Store
    Container(color: Colors.blue), // Wishlist
    Container(color: Colors.yellow), // Profile
  ];
}
