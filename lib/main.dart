import 'package:ecommerce2/components/home.dart';
import 'package:ecommerce2/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:ecommerce2/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: kIsWeb
          ? DefaultFirebaseOptions.web
          : DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint(
        'Firebase initialization failed (${kIsWeb ? 'web' : 'native'}): $e');
    // Continue running the app so UI renders; auth/db will require proper config on web.
  }
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const SplashScreen(),
    routes: {
      '/onboarding': (context) =>
          const SplashScreen(), // Placeholder for onboarding
    },
  ));
}
