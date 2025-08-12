import 'package:flutter/material.dart';
import 'package:messenger/screens/account_screen.dart';
import 'package:messenger/screens/contact_screen.dart';
import 'package:messenger/screens/home_screen.dart';

class Navigation extends ChangeNotifier {
  final List<Widget> _screensist = [ContactScreen(), HomeScreen(), AccountScreen()];
  int _selectedindex = 0;

  int get selectedindex => _selectedindex;
  List<Widget> get screensist => _screensist;

  void switchscreen(int index) {
    _selectedindex = index;
    notifyListeners();
  }
}
