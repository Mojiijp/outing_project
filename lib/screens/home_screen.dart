import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:outing_project/components/colors.dart';
import 'package:outing_project/components/variables.dart';
import 'package:outing_project/widgets/button.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    username.clear();
    password.clear();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    double fontTitle = screenWidth * 0.05;
    double fontSubTitle = screenWidth * 0.04;
    double fontButton = screenWidth * 0.05;
    double fontTextGrid = screenWidth * 0.04;
    double iconSize = screenWidth * 0.05;
    double fontVersion = screenWidth * 0.03;
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: background,
          body: Column(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight / 9,
                color: Colors.pink[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "ระบบลงทะเบียนร่วมงานบริษัท",
                        style: TextStyle(
                          fontSize: fontTitle,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Text(
                        "ชื่อผู้ใช้งาน : ${username.text}",
                        style: TextStyle(
                          fontSize: fontSubTitle,
                          fontWeight: FontWeight.w700,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight / 30),
              SizedBox(
                width: screenWidth,
                height: screenHeight / 1.5,
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(15),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: screenHeight / 30,
                  crossAxisCount: 2,
                  children: <Widget>[
                    gridViewDetail(
                      screenHeight,
                      screenWidth,
                      'assets/images/register.png',
                      'ลงทะเบียน Outing Trip',
                      fontTextGrid,
                      () {
                        Get.toNamed('/outing');
                      }
                    ),
                    gridViewDetail(
                      screenHeight,
                      screenWidth,
                      'assets/images/bus.png',
                      'Check in ขึ้นรถ',
                      fontTextGrid,
                      () {
                        Get.toNamed('/check-in');
                      }
                    ),
                    gridViewDetail(
                      screenHeight,
                      screenWidth,
                      'assets/images/party.png',
                      'ลงทะเบียน Night party',
                      fontTextGrid,
                      () {
                        Get.toNamed('/night-party');
                      }
                    ),
                    gridViewDetail(
                      screenHeight,
                      screenWidth,
                      'assets/images/ship.png',
                      'check in ขึ้นเรือ',
                      fontTextGrid,
                      () {
                        Get.toNamed('/more');
                      }
                    ),
                  ],
                )
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: ButtonWidget(
                  height: screenHeight / 13,
                  width: screenWidth / 2,
                  text: 'ออกจากระบบ',
                  colorText: textButton,
                  colorButton: cancelButton,
                  fontTextSize: fontButton,
                  onPressed: () {
                    Get.toNamed('/login');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget gridViewDetail (double screenHeight, double screenWeight, String imagePath, String text, double fontText, Function()? onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFFBFECFF)
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: screenHeight / 8,
            width: screenWeight,
            child: Image(
              image: AssetImage(
                imagePath,
              ),
              fit: BoxFit.fitHeight,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize:  fontText,
              color: Color(0xFF000957)
            ),
            textAlign: TextAlign.center,
          ),
        ],
      )
    )
  );
}
