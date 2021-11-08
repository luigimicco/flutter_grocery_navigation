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

        // Add Home
        if (appStateManager.isOnBoardingComplete)
          Home.page(appStateManager.getSelectedTab),

        // Create new item
        if (groceryManager.isCreatingNewItem)
          GroceryItemScreen.page(
            onCreate: (item) {
              groceryManager.addItem(item);
            },
            onUpdate: (item, index) {
              // no update
            },
          ),

        // Select GroceryItemScreen
        if (groceryManager.selectedIndex != -1)
          GroceryItemScreen.page(
            item: groceryManager.selectedGroceryItem,
            index: groceryManager.selectedIndex,
            onCreate: (_) {
              // no create
            },
            onUpdate: (item, index) {
              groceryManager.updateItem(item, index);
            },
          ),

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

    // Handle Onboarding and splash
    if (route.settings.name == FooderlichPages.onboardingPath) {
      appStateManager.logout();
    }

    // Handle state when user closes grocery item screen
    if (route.settings.name == FooderlichPages.groceryItemDetails) {
      groceryManager.groceryItemTapped(-1);
    }

    // TODO: Handle state when user closes profile screen
    // TODO: Handle state when user closes WebView screen
    // 6
    return true;
  }

  // 10
  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
