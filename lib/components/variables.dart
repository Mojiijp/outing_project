import 'package:flutter/cupertino.dart';

String version = 'Version 1.2.0';
String txtBarcode = '';

TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController employeeCode = TextEditingController();
TextEditingController name = TextEditingController();
TextEditingController car = TextEditingController();
TextEditingController barcode = TextEditingController();

FocusNode usernameFocus = FocusNode();
FocusNode passwordFocus = FocusNode();
FocusNode employeeCodeFocus = FocusNode();
FocusNode nameFocus = FocusNode();
FocusNode carFocus = FocusNode();
FocusNode barcodeFocus = FocusNode();

bool isObscured = true;
bool isVisibleTalingChan = true;
bool isVisibleBangLen = true;
bool isVisibleCar = true;
bool isVisibleRound = false;