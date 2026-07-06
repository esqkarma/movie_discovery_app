import 'package:flutter/material.dart';
import 'package:task_cinema_app/features/coming_soon_screen/presentation/pages/comingSoonScreen.dart';
import 'package:task_cinema_app/features/download_screen/downloadScreen.dart';
import 'package:task_cinema_app/features/home/presentation/pages/homePage.dart';
import 'package:task_cinema_app/features/more_screen/more_screen.dart';
import 'package:task_cinema_app/features/search_screen/presentation/pages/search_screen.dart';
import 'package:task_cinema_app/features/widgets/bottom_nav_bar.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomePage(),
    SearchScreen(),
    ComingSoonScreen(),
    DownloadScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: pages[currentIndex],
      bottomNavigationBar: NetflixBottomNavBar(
        selectedIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
