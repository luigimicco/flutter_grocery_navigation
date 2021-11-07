import 'dart:async';
import 'package:flutter/material.dart';

class FooderlichTab {
  static const int explore = 0;
  static const int recipes = 1;
  static const int toBuy = 2;
}

class AppstateManager extends ChangeNotifier {
  bool _inizialized = false;
  bool _loggedIn = false;
  bool _onboardingComplete = false;
  int _selectedTab = FooderlichTab.explore;

  bool get isInizialized => _inizialized;
  bool get isLoggedIn => _loggedIn;
  bool get isOnBoardingComplete => _onboardingComplete;
  int get getSelectedTab => _selectedTab;

  // initializeApp
  void inizializeApp() {
    Timer(
      const Duration(milliseconds: 2000),
      () {
        _inizialized = true;
        notifyListeners();
      },
    );
  }

  // login
  void login(String username, String password) {
    _loggedIn = true;
    notifyListeners();
  }

  // completeOnboarding
  void completeOnBoarding() {
    _onboardingComplete = true;
    notifyListeners();
  }

  // goToTab
  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  // goToRecipes
  void goToRecipes() {
    _selectedTab = FooderlichTab.recipes;
    notifyListeners();
  }

  // logout
  void logout() {
    _loggedIn = false;
    _onboardingComplete = false;
    _inizialized = false;
    _selectedTab = 0;

    inizializeApp();
    notifyListeners();
  }

  //
}
