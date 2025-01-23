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
  List<String> items = ['คันที่ 1', 'คันที่ 2', 'คันที่ 3', 'Mini bus'];
  List car1 = [];
  List car2 = [];
  List car3 = [];
  List car4 = [];

  List<Employee>? employeeData;

  String? selectedValue;

  void fetchEmployeeData() async {
    // ดึงข้อมูลพนักงานทั้งหมดจาก API
    var data = await EmployeeService.getAllEmployee();
    setState(() {
      employeeData = data;
      print(employeeData);
      car1 = data.where((employee) => employee.car == 'คันที่ 1').toList();
      car2 = data.where((employee) => employee.car == 'คันที่ 2').toList();
      car3 = data.where((employee) => employee.car == 'คันที่ 3').toList();
      car4 = data.where((employee) => employee.car == 'Mini Bus').toList();
      // registerTalingchan = officeTaLingChan
      //     .where((register) => register.outingStatus == true)
      //     .length;

      // registerBanglen = officeBanglen
      //     .where((register) => register.outingStatus == true)
      //     .length;
      // isLoading = false; // หยุดสถานะกำลังโหลด
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchEmployeeData();
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
                                    width: screenWidth / 5,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        isExpanded: true,
                                        hint: Row(
                                          children: [
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'คันที่ 1',
                                                style: TextStyle(
                                                  fontSize: fontDropdown,
                                                  fontWeight: FontWeight.bold,
                                                  color: subHeader,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: items
                                            .map((String item) =>
                                            DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: TextStyle(
                                                  fontSize: fontDropdown,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                            ))
                                            .toList(),
                                        value: selectedValue,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedValue = value;

                                          });
                                        },
                                        buttonStyleData: ButtonStyleData(
                                          height: screenHeight / 20,
                                          width: screenWidth / 3,
                                          padding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(14),
                                            border: Border.all(
                                              color: Colors.black26,
                                            ),
                                            color: Colors.white,
                                          ),
                                          elevation: 2,
                                        ),
                                        iconStyleData: IconStyleData(
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                          ),
                                          iconSize: fontDropdown,
                                          iconEnabledColor: Colors.black,
                                          iconDisabledColor: Colors.grey,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200,
                                          width: screenWidth / 3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(14),
                                            border: Border.all(
                                              color: Colors
                                                  .black26, // เพิ่มขอบให้กับดรอปดาวน์
                                            ),
                                            //color: Colors.pink[300],
                                          ),
                                          scrollbarTheme: ScrollbarThemeData(
                                            radius: const Radius.circular(40),
                                            thickness:
                                            WidgetStateProperty.all(6),
                                            thumbVisibility:
                                            WidgetStateProperty.all(true),
                                          ),
                                        ),
                                        menuItemStyleData: MenuItemStyleData(
                                          height: 50,
                                          padding: EdgeInsets.only(
                                              left: 14, right: 14),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              // กรอกรหัสพนักงาน
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
                                            scanFormat: ScanFormat.ONLY_BARCODE,
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
                          "รถคันที่ 1",
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
                              "เช็คอินแล้ว 0 / 5 คน",
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
                                  //isVisibleTalingChan = !isVisibleTalingChan;
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
                        visible: isVisibleTalingChan,
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
                                  rows: car1.map((row) {
                                    // bool isHighlighted =
                                    //     searchedEmployeeCode == row.code;

                                    return DataRow(
                                      // color:
                                      // WidgetStateProperty.resolveWith(
                                      //       (states) => isHighlighted
                                      //       ? Colors.yellow.shade200
                                      //       : Colors.transparent,
                                      // ),
                                      cells: <DataCell>[
                                        DataCell(
                                          Center(
                                            child: Text(
                                              row.code,
                                              style: TextStyle(
                                                  fontSize: fontData),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            row.name,
                                            softWrap: true,
                                            style: TextStyle(
                                                fontSize: fontData),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        DataCell(
                                          Center(
                                            child: Text(
                                              row.nickname,
                                              style: TextStyle(
                                                  fontSize: fontData),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Center(
                                            child: Text(
                                              row.color,
                                              style: TextStyle(
                                                  fontSize: fontData),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          InkWell(
                                            child: Center(
                                              child: Text(
                                                row.checkIn ==
                                                    false
                                                    ? 'Check in'
                                                    : 'เสร็จสิ้น',
                                                style: TextStyle(
                                                  fontSize: fontData,
                                                  color:
                                                  row.checkIn ==
                                                      false
                                                      ? dataButton
                                                      : success,
                                                ),
                                              ),
                                            ),
                                            onTap: () async {
                                              // await EmployeeService
                                              //     .registerEmployee(
                                              //     row.code);
                                              // fetchEmployeeData();
                                              // employeeCode.clear();
                                              // name.clear();
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
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
