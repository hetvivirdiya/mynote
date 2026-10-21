
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1683F8);

    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFD),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFCFCFD),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Color(0xFF222222),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),

          // Profile information
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 48,
                  backgroundColor: Color(0xFFEDF6FF),
                  child: Icon(
                    Icons.person,
                    size: 55,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Hetvi virdiya',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'hetvivirdiya@gmail.com',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF777777),
                  ),
                ),
                const SizedBox(height: 18),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryColor,
                    side: const BorderSide(color: primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
          ),
    ]
    ),
    );
  }
}
