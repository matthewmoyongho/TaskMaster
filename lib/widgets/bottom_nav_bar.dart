import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);
  int currentIndex;
  void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.schedule_outlined), label: 'Pending Tasks'),
        BottomNavigationBarItem(
            icon: Icon(Icons.done), label: 'Completed Tasks'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite), label: 'Favourite Tasks'),
      ],
      onTap: onTap,
    );
  }
}
