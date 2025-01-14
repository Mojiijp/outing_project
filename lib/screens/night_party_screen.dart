import 'package:flutter/material.dart';

class NightPartyScreen extends StatefulWidget {
  const NightPartyScreen({super.key});

  @override
  State<NightPartyScreen> createState() => _NightPartyScreenState();
}

class _NightPartyScreenState extends State<NightPartyScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Text("NIGHT PARTY SCREEN", style: TextStyle(fontSize: 60),),
      ),
    );
  }
}
