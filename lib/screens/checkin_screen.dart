import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:outing_project/components/colors.dart';
import 'package:outing_project/components/variables.dart';
import 'package:outing_project/src/model/employee.dart';
import 'package:outing_project/src/services/employee_service.dart';
import 'package:outing_project/widgets/button.dart';
import 'package:outing_project/widgets/search_form.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  List car1 = [];
  List car2 = [];
  List car3 = [];
  List car4 = [];

  List<Employee>? employeeData;

  String? selectedValue;
  String carNo = '';

  void fetchEmployeeData() async {
    // ดึงข้อมูลพนักงานทั้งหมดจาก API
    var data = await EmployeeService.getAllEmployee();

    setState(() {
      employeeData = data;

      switch (username.text) {
        case 'car1':
          car1 = data.where((employee) => employee.car == 'คันที่ 1').toList();
          break;

        case 'car2':
          car2 = data.where((employee) => employee.car == 'คันที่ 2').toList();
          break;

        case 'car3':
          car3 = data.where((employee) => employee.car == 'คันที่ 3').toList();
          break;

        case 'car4':
          car4 = data.where((employee) => employee.car == 'Mini Bus').toList();
          break;

        default: print('Username does not match any car');
      }
    });
  }

  String getCarNoFromUsername(String username) {
    switch(username) {
      case 'car1':
        return 'คันที่ 1';  // Example car number for 'car1'
      case 'car2':
        return 'คันที่ 2';  // Example car number for 'car2'
      case 'car3':
        return 'คันที่ 3';
      case 'car4':
        return 'Mini Bus';  // Example car number for 'car3'
      default:
        return 'คันที่ 1'; // Return 'Unknown' if username doesn't match any case
    }
  }

  int getCheckIn() {
    switch (username.text) {
      case 'car1':
        return car1.where((register) => register.checkIn == true).length;
      case 'car2':
        return car2.where((register) => register.checkIn == true).length;
      case 'car3':
        return car3.where((register) => register.checkIn == true).length;
      case 'car4':
        return car4.where((register) => register.checkIn == true).length;
      default:
        return 0;  // Return 0 if the username doesn't match any car
    }
  }

  int getAllEmployeeInCar() {
    switch (username.text) {
      case 'car1':
        return car1.where((register) => register.car == 'คันที่ 1').length;
      case 'car2':
        return car2.where((register) => register.car == 'คันที่ 2').length;
      case 'car3':
        return car3.where((register) => register.car == 'คันที่ 3').length;
      case 'car4':
        return car4.where((register) => register.car == 'Mini Bus').length;
      default:
        return car1.where((register) => register.car == 'คันที่ 1').length; // Return 0 if the username doesn't match any car
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchEmployeeData();
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: backgroundAppbar,
          title: Text(
            "เช็คอินพนักงาน",
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
                                        "คันที่",
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
                                      if (selectedValue == null ||
                                          selectedValue == '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "กรุณาเลือกสำนักงาน",
                                              style: TextStyle(
                                                  fontSize: fontInputText),
                                            ),
                                          ),
                                        );
                                      } else {

                                      }
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
                                      keyboardType: TextInputType.text,
                                      fontText: fontInputText,
                                      obscureText: false,
                                      onChanged: (val) {},
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
                                            // scanType: ScanType.qr,
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
                                          });
                                        },
                                        icon: Icon(
                                          Icons.qr_code_scanner,
                                          color: Colors.black,
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
                                    child: IconButton(
                                        onPressed: () async {

                                        },
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: Colors.black,
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
                                    backgroundColor: buttonClose,
                                    foregroundColor: buttonClose,
                                    radius: 20,
                                    child: IconButton(
                                        onPressed: () async {

                                        },
                                        icon: Icon(
                                          Icons.close_rounded,
                                          color: Colors.black,
                                        )),
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
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "รถ${getCarNoFromUsername(username.text)}",
                          style: TextStyle(
                              fontSize: fontTitle, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, bottom: 5),
                            child: Text(
                              "เช็คอินแล้ว ${getCheckIn()} / ${getAllEmployeeInCar()} คน",
                              style: TextStyle(
                                  fontSize: fontSubTitle,
                                  fontWeight: FontWeight.w500),
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
                        child: Row(
                          children: [
                            Expanded(
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
                                  : FittedBox(
                                child: DataTable(
                                  headingRowColor:
                                  WidgetStateProperty.resolveWith(
                                          (states) =>
                                      Colors.teal.shade100),
                                  dataRowColor:
                                  WidgetStateProperty.resolveWith(
                                          (states) => Colors.teal.shade50
                                          .withOpacity(0.5)),
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
                                  ],
                                  rows: (() {
                                    // Decide which car's data to show based on the username
                                    List<dynamic> selectedCarData;

                                    switch (username.text) {
                                      case 'car1':
                                        selectedCarData = car1;
                                        break;
                                      case 'car2':
                                        selectedCarData = car2;
                                        break;
                                      case 'car3':
                                        selectedCarData = car3;
                                        break;
                                      case 'car4':
                                        selectedCarData = car4;
                                        print(selectedCarData[0].checkIn);
                                        break;
                                      default:
                                        selectedCarData = []; // Return an empty list if no match
                                    }

                                    // Map the selected data into DataRow widgets
                                    return selectedCarData.map<DataRow>((row) {
                                      return DataRow(
                                        cells: <DataCell>[
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
                                          DataCell(
                                            InkWell(
                                              child: Center(
                                                child: Text(
                                                  row.checkIn == false ? 'Check in' : 'เสร็จสิ้น',
                                                  style: TextStyle(
                                                    fontSize: fontData,
                                                    color: row.checkIn == false ? dataButton : success,
                                                  ),
                                                ),
                                              ),
                                              onTap: ()  async {
                                                await EmployeeService.checkInEmployee(row.code).whenComplete(() {
                                                  fetchEmployeeData();
                                                });
                                                employeeCode.clear();
                                                barcode.clear();
                                                // Handle your onTap logic here
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList();
                                  })(),
                                  // rows: car1.map((row) {
                                  //   // bool isHighlighted =
                                  //   //     searchedEmployeeCode == row.code;
                                  //
                                  //   return DataRow(
                                  //     // color:
                                  //     // WidgetStateProperty.resolveWith(
                                  //     //       (states) => isHighlighted
                                  //     //       ? Colors.yellow.shade200
                                  //     //       : Colors.transparent,
                                  //     // ),
                                  //     cells: <DataCell>[
                                  //       DataCell(
                                  //         Center(
                                  //           child: Text(
                                  //             row.code,
                                  //             style: TextStyle(
                                  //                 fontSize: fontData),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       DataCell(
                                  //         Text(
                                  //           row.name,
                                  //           softWrap: true,
                                  //           style: TextStyle(
                                  //               fontSize: fontData),
                                  //           textAlign: TextAlign.start,
                                  //         ),
                                  //       ),
                                  //       DataCell(
                                  //         Center(
                                  //           child: Text(
                                  //             row.nickname,
                                  //             style: TextStyle(
                                  //                 fontSize: fontData),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       DataCell(
                                  //         Center(
                                  //           child: Text(
                                  //             row.color,
                                  //             style: TextStyle(
                                  //                 fontSize: fontData),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       DataCell(
                                  //         InkWell(
                                  //           child: Center(
                                  //             child: Text(
                                  //               row.checkIn ==
                                  //                   false
                                  //                   ? 'Check in'
                                  //                   : 'เสร็จสิ้น',
                                  //               style: TextStyle(
                                  //                 fontSize: fontData,
                                  //                 color:
                                  //                 row.checkIn ==
                                  //                     false
                                  //                     ? dataButton
                                  //                     : success,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //           onTap: () async {
                                  //             // await EmployeeService
                                  //             //     .registerEmployee(
                                  //             //     row.code);
                                  //             // fetchEmployeeData();
                                  //             // employeeCode.clear();
                                  //             // name.clear();
                                  //           },
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   );
                                  // }).toList(),
                                ),
                              ),
                            ),
                          ],
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
