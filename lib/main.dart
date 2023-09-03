import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maximagri/config/app_theme.dart';
import 'package:maximagri/utilities/user_authentication.dart';
import 'package:maximagri/config/app_dark_theme.dart';
import 'package:maximagri/config/routes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaximAgri());
}

class MaximAgri extends StatelessWidget {
  const MaximAgri({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maxim Agri - Customer Relationship Management System',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      darkTheme: appDarkTheme(),
      routes: customRoutes,
      home: const UserAuthentication(),
    );
  }
}
