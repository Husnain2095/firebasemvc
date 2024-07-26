import 'package:cartexample/User/User_Screen/fetch_screen.dart';
import 'package:cartexample/firebase_options.dart';
import 'package:cartexample/User/User_Screen/login_screen.dart';
import 'package:cartexample/Product/Product_Screen/product_add.dart';
import 'package:cartexample/Product/Product_Screen/product_fetch.dart';
import 'package:cartexample/User/User_Screen/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

