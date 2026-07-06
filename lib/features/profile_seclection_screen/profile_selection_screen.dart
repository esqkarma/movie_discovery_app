import 'package:flutter/material.dart';
import 'package:task_cinema_app/features/home/presentation/pages/IndexScreen.dart';

import '../../core/constants/profiles.dart';

class ProfileSelectionPage extends StatelessWidget {
  const ProfileSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            const SizedBox(height: 10),

            /// Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Spacer(),
                  Image.asset('assets/logo.png', height: 60),
                  const Spacer(),
                  const Icon(Icons.edit, color: Colors.white, size: 22),
                ],
              ),
            ),

            const SizedBox(height: 70),

            /// Profiles Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: profiles.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 25,
                  crossAxisSpacing: 25,
                  childAspectRatio: .9,
                ),
                itemBuilder: (context, index) {
                  final profile = profiles[index];

                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (ctx) => IndexScreen()),
                            (route) => false,
                          );
                        },
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                              image: AssetImage(profile['image']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        profile['name']!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 50),

            /// Add Profile
            Column(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.black, size: 35),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Add Profile',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
