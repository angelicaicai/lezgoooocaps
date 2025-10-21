// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:justifind_capstone_2_final/auth/sign_up_screen.dart';
import 'package:justifind_capstone_2_final/firebase_options.dart';

import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/about_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/admin/admin_login_screen.dart';
import 'screens/admin/admin_dashboard.dart';
import 'screens/profile_screen.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const JustiFindApp());
}

class JustiFindApp extends StatelessWidget {
  const JustiFindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Justi-Find',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      initialRoute: '/splash', // Changed from '/signin' to '/splash'
      routes: {
        '/splash': (context) => const SplashScreen(), // Add splash screen route
        '/about': (context) => const AboutScreen(),
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/admin-login': (context) => const AdminLoginScreen(),
        '/admin-dashboard': (context) => const AdminDashboard(),
        '/profile': (context) => const ProfileScreen(),
        '/search': (context) => const SearchScreen(),
      },
    );
  }
}
