import 'package:flutter/material.dart';

class OutingScreen extends StatefulWidget {
  const OutingScreen({super.key});

  @override
  State<OutingScreen> createState() => _OutingScreenState();
}

class _OutingScreenState extends State<OutingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Text("OUTING SCREEN", style: TextStyle(fontSize: 60),),
      ),
    );
  }
}
