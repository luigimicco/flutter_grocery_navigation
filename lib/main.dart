import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'fooderlich_theme.dart';
import 'models/models.dart';
import 'navigation/app_router.dart';

void main() {
  runApp(
    const Fooderlich(),
  );
}

class Fooderlich extends StatefulWidget {
  const Fooderlich({Key? key}) : super(key: key);

  @override
  _FooderlichState createState() => _FooderlichState();
}

class _FooderlichState extends State<Fooderlich> {
  final _groceryManager = GroceryManager();
  final _profileManager = ProfileManager();
  final _appstateManager = AppstateManager();

  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
        appStateManager: _appstateManager,
        groceryManager: _groceryManager,
        profileManager: _profileManager);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _groceryManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _profileManager,
        ),
        ChangeNotifierProvider(create: (context) => _appstateManager)
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = FooderlichTheme.dark();
          } else {
            theme = FooderlichTheme.light();
          }

          return MaterialApp(
            theme: theme,
            title: 'Fooderlich',
            home: Router(
              routerDelegate: _appRouter,
              // Add backButtonDispatcher
              backButtonDispatcher: RootBackButtonDispatcher(),
            ),
          );
        },
      ),
    );
  }
}
