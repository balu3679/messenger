import 'package:flutter/material.dart';
import 'package:messenger/service/navigation.dart';
import 'package:provider/provider.dart';

class HomeWraper extends StatefulWidget {
  const HomeWraper({super.key});

  @override
  State<HomeWraper> createState() => _HomeWraperState();
}

class _HomeWraperState extends State<HomeWraper> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Navigation>(
      builder: (context, value, child) {
        return Scaffold(
          body: value.screensist[value.selectedindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: value.selectedindex,
            onTap: (index) => value.switchscreen(index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.contact_page_outlined),
                activeIcon: Icon(Icons.contact_page),
                label: 'Contact',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline),
                activeIcon: Icon(Icons.chat_bubble),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Account',
              ),
            ],
          ),
        );
      },
    );
  }
}
