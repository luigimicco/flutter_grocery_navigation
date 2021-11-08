import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/screens.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final AppstateManager appStateManager;
  final GroceryManager groceryManager;
  final ProfileManager profileManager;

  AppRouter(
      {required this.appStateManager,
      required this.groceryManager,
      required this.profileManager})
      : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener((notifyListeners));
    groceryManager.addListener((notifyListeners));
    profileManager.addListener((notifyListeners));
  }

  @override
  void dispose() {
    appStateManager.removeListener((notifyListeners));
    groceryManager.removeListener((notifyListeners));
    profileManager.removeListener((notifyListeners));
    super.dispose();
  }

  // TODO: Dispose listeners
  @override
  Widget build(BuildContext context) {
    // 7
    return Navigator(
      // 8
      key: navigatorKey,
      onPopPage: _handlePopPage,
      // 9
      pages: [
        // Add SplashScreen
        if (!appStateManager.isInizialized) SplashScreen.page(),
        // Add LoginScreen
        if (appStateManager.isInizialized && !appStateManager.isLoggedIn)
          LoginScreen.page(),
        // Add OnboardingScreen
        if (appStateManager.isLoggedIn && !appStateManager.isOnBoardingComplete)
          OnboardingScreen.page(),

        // TODO: Add Home
        // TODO: Create new item
        // TODO: Select GroceryItemScreen
        // TODO: Add Profile Screen
        // TODO: Add WebView Screen
      ],
    );
  }

  // _handlePopPage
  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }

    // TODO: Handle Onboarding and splash
    // TODO: Handle state when user closes grocery item screen
    // TODO: Handle state when user closes profile screen
    // TODO: Handle state when user closes WebView screen
    // 6
    return true;
  }

  // 10
  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
