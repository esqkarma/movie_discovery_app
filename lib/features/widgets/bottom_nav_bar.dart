import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NetflixBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onTap;

  const NetflixBottomNavBar({
    super.key,
    required this.selectedIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(top: BorderSide(color: Color(0xff222222))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(
            iconPath: 'assets/static_icons/home.svg',
            label: 'Home',
            index: 0,
          ),

          _item(
            iconPath: 'assets/static_icons/search.svg',
            label: 'Search',
            index: 1,
          ),

          _item(
            iconPath: 'assets/static_icons/videos.svg',
            label: 'Coming Soon',
            index: 2,
          ),

          _item(
            iconPath: 'assets/static_icons/download.svg',
            label: 'Downloads',
            index: 3,
          ),

          _item(
            iconPath: 'assets/static_icons/hamburger-menu.svg',
            label: 'More',
            index: 4,
          ),
        ],
      ),
    );
  }

  Widget _item({
    required String iconPath,
    required String label,
    required int index,
  }) {
    final isSelected = selectedIndex == index;

    return InkWell(
      onTap: () => onTap?.call(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              isSelected ? Colors.white : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
