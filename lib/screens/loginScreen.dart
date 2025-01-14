import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outing_project/components/colors.dart';
import 'package:outing_project/components/variables.dart';
import 'package:outing_project/widgets/button.dart';
import 'package:outing_project/widgets/input_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    double fontTitle = screenWidth * 0.06;
    double fontButton = screenWidth * 0.05;
    double fontInputText = screenWidth * 0.05;
    double iconSize = screenWidth * 0.05;
    double fontVersion = screenWidth * 0.03;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              color: Colors.blue[100],
              height: screenHeight / 4,
              child: Center(
                child: Image(
                  image: AssetImage('assets/images/quadel.png'),
                  width: screenWidth / 1.3,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'ระบบลงทะเบียนร่วมงานบริษัท',
                style: TextStyle(
                  fontSize: fontTitle,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            //username
            SizedBox(
              height: screenHeight / 15,
              width: screenWidth / 1.2,
              child: InputField(
                readOnly: false,
                controller: username,
                focusNode: usernameFocus,
                textInputAction: TextInputAction.next,
                label: 'ชื่อผู้ใช้งาน',
                fontText: fontInputText,
                obscureText: false,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius:iconSize,
                    backgroundColor: Colors.teal[200],
                    child: Icon(
                      Icons.person,
                      size: iconSize,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight / 20,),
            //password
            SizedBox(
              height: screenHeight / 15,
              width: screenWidth / 1.2,
              child: InputField(
                  readOnly: false,
                  controller: password,
                  focusNode: passwordFocus,
                  textInputAction: TextInputAction.done,
                  label: 'รหัสผ่าน',
                  fontText: fontInputText,
                  obscureText: isObscured,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: iconSize,
                    backgroundColor: Colors.teal[200],
                    child: Icon(
                      Icons.lock,
                      size: iconSize,
                      color: Colors.white,
                    ),
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isObscured ? Icons.visibility : Icons.visibility_off,
                    size: 25,
                    color: Colors.teal.shade100,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscured = !isObscured;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: screenHeight / 20,),
            //button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidget(
                  height: screenHeight / 13,
                  width: screenWidth / 2.5,
                  text: 'เข้าสู่ระบบ',
                  colorText: textButton,
                  colorButton: saveButton,
                  fontTextSize: fontButton,
                  onPressed: () {
                    Get.toNamed('/home');
                  },
                ),
                ButtonWidget(
                  height: screenHeight / 13,
                  width: screenWidth / 2.5,
                  text: 'เคลียร์',
                  colorText: textButton,
                  colorButton: cancelButton,
                  fontTextSize: fontButton,
                  onPressed: () {
                    username.clear();
                    password.clear();
                  },
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  version,
                  style: TextStyle(
                    fontSize: fontVersion
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
