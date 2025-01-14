import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outing_project/screens/loginScreen.dart';
import 'package:outing_project/src/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Outing Project',
      theme: ThemeData(
        fontFamily: 'Prompt',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      getPages: Routes.getPageRoutes(),
      initialRoute: "/login",
    );
  }
}