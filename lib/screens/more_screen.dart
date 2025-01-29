import 'package:flutter/material.dart';
import 'package:outing_project/components/colors.dart';
import 'package:outing_project/components/variables.dart';
import 'package:outing_project/src/model/employee.dart';
import 'package:outing_project/src/services/employee_service.dart';
import 'package:outing_project/widgets/button.dart';
import 'package:outing_project/widgets/search_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  List boat1 = [];
  List boat2 = [];

  List<Employee>? employeeData;

  String? selectedValue;
  String? searchedEmployeeCode;
  String carNo = '';

  int countOfRound = 1;

  // ฟังก์ชันเพื่อดึงค่าจาก SharedPreferences
  loadCountOfRound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      countOfRound = prefs.getInt('countOfRound') ?? 1;  // ถ้าไม่มีค่า จะใช้ค่าเริ่มต้นเป็น 1
    });
  }

  incrementCountOfRound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      countOfRound++;
    });
    await prefs.setInt('countOfRound', countOfRound); // เก็บค่าใหม่ลง SharedPreferences
  }

  void fetchEmployeeData() async {
    var data = await EmployeeService.getAllEmployee();

    setState(() {
      employeeData = data;

      switch (username.text) {
        case 'boat1':
          boat1 = data.where((employee) => employee.boat == 'JP4' || employee.boat == 'VIP').toList();
          break;

        case 'boat2':
          boat2 = data.where((employee) => employee.boat == 'JP5' || employee.boat == 'VIP').toList();
          break;

        default: print('Username does not match any boat');
      }
    });
  }

  void empNotRegisData() {
    setState(() {
      var filteredData = employeeData!.where((employee) {
        return employee.checkBoat == false;
      }).toList();

      switch (username.text) {
        case 'boat1':
          boat1 = filteredData.where((employee) => employee.boat == 'JP4' || employee.boat == 'VIP').toList();
          break;

        case 'boat2':
          boat2 = filteredData.where((employee) => employee.boat == 'JP5' || employee.boat == 'VIP').toList();
          break;

        default: boat1 = filteredData.where((employee) => employee.boat == 'JP4' || employee.boat == 'VIP').toList();
      }
    });
  }

  String getCarNoFromUsername(String username) {
    switch(username) {
      case 'boat1':
        return 'JP4';  // Example car number for 'boat1'
      case 'boat2':
        return 'JP5';
      default:
        return 'JP4'; // Return 'Unknown' if username doesn't match any case
    }
  }

  int getCheckIn() {
    if (employeeData == null) {
      return 0;
    }

    var filteredData = employeeData?.where((employee) {
      return employee.checkBoat == true;
    }).toList();

    switch (username.text) {
      case 'boat1':
        return filteredData!.where((register) => register.boat == 'JP4' || register.boat == 'VIP').length;
      case 'boat2':
        return filteredData!.where((register) => register.boat == 'JP5' || register.boat == 'VIP').length;
      default:
        return 0;  // Return 0 if the username doesn't match any car
    }
  }

  int getAllEmployeeInCar() {
    if (employeeData == null) {
      return 0;
    }
    switch (username.text) {
      case 'boat1':
        return employeeData!.where((register) => register.boat == 'JP4' || register.boat == 'VIP').length;
      case 'boat2':
        return employeeData!.where((register) => register.boat == 'JP5' || register.boat == 'VIP').length;
      default:
        return employeeData!.where((register) => register.boat == 'JP4' || register.boat == 'VIP').length; // Return 0 if the username doesn't match any car
    }
  }

  void searchEmployeeData() {
    setState(() {
      // กรองข้อมูลจากรหัสพนักงานที่กรอก
      var filteredData = employeeData!.where((employee) {
        return employee.code.contains(employeeCode.text) &&
            employee.barcode.contains(barcode.text);
      }).toList();

      switch (username.text) {
        case 'boat1':
          boat1 = filteredData.where((employee) => employee.boat == 'JP4'|| employee.boat == 'VIP').toList();
          break;

        case 'boat2':
          boat2 = filteredData.where((employee) => employee.boat == 'JP5'|| employee.boat == 'VIP').toList();
          break;
        default: print('Username does not match any car');
      }
      if (filteredData.isNotEmpty) {
        searchedEmployeeCode = filteredData[0].code;
      }
    });
  }

  void alertDialog (double screenHeight, double screenWidth, String text, double fontTitleSize, double fontButtonSize) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Dialog(
            elevation: 0,
            backgroundColor: buttonCamera,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: SizedBox(
              height: screenHeight / 3,
              width: screenWidth / 1.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: fontTitleSize
                    ),
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black
                        //RGB = (34, 148, 65)
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                          "ตกลง",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontButtonSize
                          )
                      )
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchEmployeeData();
    loadCountOfRound();
    employeeCode.clear();
    barcode.clear();
  }

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
    double fontTitleDialog = screenWidth * 0.06;
    double fontButtonDialog = screenWidth * 0.05;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: backgroundAppbar,
          title: Text(
            "ลงทะเบียนขึ้นเรือ",
            style:
            TextStyle(fontSize: fontAppbar, fontWeight: FontWeight.bold),
          ),
        ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "ค้นหาข้อมูล",
                      style: TextStyle(
                          fontSize: fontTitle, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: screenHeight / 5,
                      width: screenWidth / 1.05,
                      decoration: BoxDecoration(
                          color: Colors.pink[200],
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "เรือ",
                                        style: TextStyle(
                                            fontSize: fontSubTitle,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "*",
                                        style: TextStyle(
                                            fontSize: fontSubTitle,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight / 20,
                                    width: screenWidth / 5,
                                    child: SearchField(
                                      readOnly: true,
                                      controller: car,
                                      focusNode: carFocus,
                                      hintText: getCarNoFromUsername(username.text),
                                      textInputAction: TextInputAction.done,
                                      fontText: fontInputText,
                                      obscureText: false,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "รหัสพนักงาน",
                                    style: TextStyle(
                                        fontSize: fontSubTitle,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: screenHeight / 20,
                                    width: screenWidth / 2.4,
                                    child: SearchField(
                                      readOnly: false,
                                      controller: employeeCode,
                                      focusNode: employeeCodeFocus,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      fontText: fontInputText,
                                      obscureText: false,
                                      onChanged: (val) {
                                        searchEmployeeData();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '',
                                    style: TextStyle(fontSize: fontSubTitle),
                                  ),
                                  ButtonWidget(
                                    height: screenHeight / 20,
                                    width: screenWidth / 4.5,
                                    text: 'ค้นหา',
                                    colorText: Colors.white,
                                    colorButton: saveButton,
                                    fontTextSize: fontSubTitle,
                                    onPressed: () async {
                                      searchEmployeeData();
                                      employeeCode.clear();
                                      barcode.clear();
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "บาร์โค้ด",
                                    style: TextStyle(
                                        fontSize: fontSubTitle,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: screenHeight / 20,
                                    width: screenWidth / 1.93,
                                    child: SearchField(
                                      readOnly: false,
                                      controller: barcode,
                                      focusNode: barcodeFocus,
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.number,
                                      fontText: fontInputText,
                                      obscureText: false,
                                      onChanged: (val) {
                                        searchEmployeeData();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "",
                                    style: TextStyle(
                                        fontSize: fontSubTitle,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: buttonCamera,
                                    foregroundColor: buttonCamera,
                                    radius: 20,
                                    child: IconButton(
                                        onPressed: () async {
                                          String? res =
                                          await SimpleBarcodeScanner
                                              .scanBarcode(
                                            context,
                                            barcodeAppBar: const BarcodeAppBar(
                                              appBarTitle: 'Test',
                                              centerTitle: false,
                                              enableBackButton: true,
                                              backButtonIcon:
                                              Icon(Icons.arrow_back_ios),
                                            ),
                                            isShowFlashIcon: true,
                                            delayMillis: 500,
                                            cameraFace: CameraFace.back,
                                            scanFormat: ScanFormat.ALL_FORMATS,
                                          );
                                          setState(() {
                                            txtBarcode = res as String;
                                            print('barcode : $txtBarcode');
                                            if(employeeData!.where((employee) {
                                              return employee.barcode.contains(txtBarcode);
                                            }).toList().isNotEmpty) {
                                              barcode.text = txtBarcode;
                                              searchEmployeeData();
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                        "ไม่พบข้อมูล",
                                                        style: TextStyle(fontSize: fontInputText),
                                                      )
                                                  )
                                              );
                                            }
                                          });
                                        },
                                        icon: Tooltip(
                                          message: 'สแกน QR Code',
                                          child: Icon(
                                            Icons.qr_code_scanner,
                                            color: Colors.black,
                                          ),
                                        )),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "",
                                    style: TextStyle(
                                        fontSize: fontSubTitle,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: buttonAdd,
                                    foregroundColor: buttonAdd,
                                    radius: 20,
                                    child: Tooltip(
                                      message: 'เพิ่มรอบใหม่',
                                      child: IconButton(
                                          onPressed: () async {
                                            if(getCheckIn() != getAllEmployeeInCar()) {
                                              alertDialog(
                                                  screenHeight,
                                                  screenWidth,
                                                  'ไม่สามารถเพิ่มรอบใหม่ได้\n ยังไม่ได้ปิดรอบ',
                                                  fontTitleDialog,
                                                  fontButtonDialog
                                              );
                                            } else {
                                              await EmployeeService.closeBoatEmployee(getCarNoFromUsername(username.text));
                                              setState(() {
                                                isVisibleRound = false;
                                                incrementCountOfRound();
                                              });
                                              fetchEmployeeData();
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                        "เพิ่มรอบสำเร็จ",
                                                        style: TextStyle(fontSize: fontInputText),
                                                      )
                                                  )
                                              );
                                            }
                                          },
                                          icon: Icon(
                                            Icons.add_circle,
                                            color: Colors.black,
                                          )),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "",
                                    style: TextStyle(
                                        fontSize: fontSubTitle,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: buttonClose,
                                    foregroundColor: buttonClose,
                                    radius: 20,
                                    child: Tooltip(
                                      message: 'ปิดรอบ',
                                      child: IconButton(
                                          onPressed: () async {
                                            if(getCheckIn() != getAllEmployeeInCar()) {
                                              alertDialog(
                                                  screenHeight,
                                                  screenWidth,
                                                  'ไม่สามารถปิดรอบได้\n ยังมีคนเช็คอินไม่ครบ',
                                                  fontTitleDialog,
                                                  fontButtonDialog
                                              );
                                            } else {
                                              print(getCarNoFromUsername(username.text));
                                              setState(() {
                                                isVisibleRound = true;
                                                fetchEmployeeData();
                                              });
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                        "ปิดรอบสำเร็จ",
                                                        style: TextStyle(fontSize: fontInputText),
                                                      )
                                                  )
                                              );
                                            }
                                          },
                                          icon: Icon(
                                            Icons.close_rounded,
                                            color: Colors.black,
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //data car
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "เรือ ${getCarNoFromUsername(username.text)} (รอบที่ $countOfRound)",
                              style: TextStyle(
                                  fontSize: fontTitle, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Visibility(
                            visible: isVisibleRound,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "ปิดรอบแล้ว",
                                style: TextStyle(
                                    fontSize: fontTitle, fontWeight: FontWeight.bold, color: dataButton),
                              ),
                            ),
                          ),
                          Tooltip(
                            message: 'รีเฟรชข้อมูล',
                            child: InkWell(
                              onTap: () {
                                fetchEmployeeData();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                          "รีเฟรชข้อมูลสำเร็จ",
                                          style: TextStyle(fontSize: fontInputText),
                                        )
                                    )
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Icon(Icons.refresh, size: 30, color : Colors.blueAccent),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              empNotRegisData();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20, bottom: 5),
                              child: Text(
                                "เช็คอินแล้ว ${getCheckIn()} / ${getAllEmployeeInCar()} คน",
                                style: TextStyle(
                                    fontSize: fontSubTitle,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 5),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isVisibleCar = !isVisibleCar;
                                });
                              },
                              child: Text(
                                "แสดง / ซ่อน",
                                style: TextStyle(
                                    fontSize: fontSubTitle,
                                    fontWeight: FontWeight.w500,
                                    color: hideData),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: isVisibleCar,
                        child: employeeData == null
                            ? Center(
                          child: SizedBox(
                            width:
                            50, // ขนาดของ CircularProgressIndicator
                            height: 50,
                            child: CircularProgressIndicator(
                              strokeWidth: 4, // ลดความหนาของเส้น
                              valueColor:
                              AlwaysStoppedAnimation<Color>(
                                  const Color.fromARGB(255, 255,
                                      145, 182)), // สี
                            ),
                          ),
                        )
                            : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                                headingRowColor:
                                WidgetStateProperty.resolveWith(
                                        (states) =>
                                    Colors.teal.shade100),
                                dataRowColor:
                                WidgetStateProperty.resolveWith(
                                        (states) => Colors.teal.shade50),
                                horizontalMargin: 10,
                                columnSpacing: 30,
                                border: TableBorder.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Expanded(
                                      child: Center(
                                        child: Text(
                                          'สถานะ',
                                          style: TextStyle(
                                              fontSize: fontData,
                                              fontWeight:
                                              FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Center(
                                        child: Text(
                                          'รหัส',
                                          style: TextStyle(
                                              fontSize: fontData,
                                              fontWeight:
                                              FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Center(
                                        child: Text(
                                          'ชื่อ-นามสกุล',
                                          style: TextStyle(
                                              fontSize: fontData,
                                              fontWeight:
                                              FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Center(
                                        child: Text(
                                          'ชื่อเล่น',
                                          style: TextStyle(
                                              fontSize: fontData,
                                              fontWeight:
                                              FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Center(
                                        child: Text(
                                          'สี',
                                          style: TextStyle(
                                              fontSize: fontData,
                                              fontWeight:
                                              FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                rows: (() {
                                  List<dynamic> selectedCarData;

                                  switch (username.text) {
                                    case 'boat1':
                                      selectedCarData = boat1;
                                      break;
                                    case 'boat2':
                                      selectedCarData = boat2;
                                      break;
                                    default:
                                      selectedCarData = []; // Return an empty list if no match
                                  }

                                  // ตรวจสอบว่า selectedCarData เป็นลิสต์ว่างหรือไม่
                                  if (selectedCarData.isEmpty) {
                                    return [
                                      DataRow(cells: [
                                        DataCell(Text('            ', style: TextStyle(fontSize: fontData))),
                                        DataCell(Text('            ', style: TextStyle(fontSize: fontData))),
                                        DataCell(Text('ไม่พบข้อมูล', style: TextStyle(fontSize: fontData, color: buttonClose))),
                                        DataCell(Text('            ', style: TextStyle(fontSize: fontData))),
                                        DataCell(Text('            ', style: TextStyle(fontSize: fontData))),
                                        // คุณสามารถเพิ่ม DataCell อื่นๆ ในที่นี้ได้ตามต้องการ
                                      ])
                                    ];
                                  } else {
                                    return selectedCarData.map<DataRow>((row) {
                                      bool isHighlighted =
                                          searchedEmployeeCode ==
                                              row.code;
                                      return DataRow(
                                        color: WidgetStateProperty
                                            .resolveWith(
                                              (states) => isHighlighted
                                              ? Colors.yellow.shade200
                                              : Colors.transparent,
                                        ),
                                        cells: <DataCell>[
                                          DataCell(
                                            InkWell(
                                              child: Center(
                                                child: Text(
                                                  row.checkBoat == false ? 'Check in' : 'เสร็จสิ้น',
                                                  style: TextStyle(
                                                    fontSize: fontData,
                                                    color: row.checkBoat == false ? dataButton : success,
                                                  ),
                                                ),
                                              ),
                                              onTap: ()  async {
                                                await EmployeeService.checkInBoat(row.code).whenComplete(() {
                                                  fetchEmployeeData();
                                                });
                                                employeeCode.clear();
                                                barcode.clear();
                                                barcodeFocus.requestFocus();
                                                // Handle your onTap logic here
                                              },
                                            ),
                                          ),
                                          DataCell(
                                            Center(
                                              child: Text(
                                                row.code,
                                                style: TextStyle(fontSize: fontData),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              row.name,
                                              softWrap: true,
                                              style: TextStyle(fontSize: fontData),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          DataCell(
                                            Center(
                                              child: Text(
                                                row.nickname,
                                                style: TextStyle(fontSize: fontData),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Center(
                                              child: Text(
                                                row.color,
                                                style: TextStyle(fontSize: fontData),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList();
                                  }
                                })(),
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
