import 'package:flutter/material.dart';
import 'package:fooderlich/screens/screens.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class SplashScreen extends StatefulWidget {
  // SplashScreen MaterialPage Helper
  static MaterialPage page() {
    return MaterialPage(
      name: FooderlichPages.splashPath,
      key: ValueKey(FooderlichPages.splashPath),
      child: const SplashScreen(),
    );
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize App
    Provider.of<AppstateManager>(context, listen: false).inizializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              height: 200,
              image: AssetImage('assets/fooderlich_assets/rw_logo.png'),
            ),
            const Text('Initializing...'),
          ],
        ),
      ),
    );
  }
}
