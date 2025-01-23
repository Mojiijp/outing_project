import 'package:flutter/material.dart';
import 'package:outing_project/components/colors.dart';

class NightPartyScreen extends StatefulWidget {
  const NightPartyScreen({super.key});

  @override
  State<NightPartyScreen> createState() => _NightPartyScreenState();
}

class _NightPartyScreenState extends State<NightPartyScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    double fontAppbar = screenWidth * 0.05;
    double fontTitle = screenWidth * 0.04;
    double fontSubTitle = screenWidth * 0.035;
    double fontDropdown = screenWidth * 0.03;
    double fontInputText = screenWidth * 0.03;
    double fontData = screenWidth * 0.025;

    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: backgroundAppbar,
          title: Text(
            "ลงทะเบียนเข้าร่วมงานกลางคืน",
            style:
            TextStyle(fontSize: fontAppbar, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
