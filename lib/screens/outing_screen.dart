import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:outing_project/components/colors.dart';
import 'package:outing_project/components/variables.dart';
import 'package:outing_project/src/model/employee.dart';
import 'package:outing_project/src/services/employee_service.dart';
import 'package:outing_project/widgets/button.dart';
import 'package:outing_project/widgets/search_form.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class OutingScreen extends StatefulWidget {
  const OutingScreen({super.key});

  @override
  State<OutingScreen> createState() => _OutingScreenState();
}

class _OutingScreenState extends State<OutingScreen> {
  List<Employee>? employeeData;
  List officeTaLingChan = [];
  List officeBanglen = [];
  int registerTalingchan = 0;
  int registerBanglen = 0;

  String? searchedEmployeeCode;

  BarcodeViewController? controller;

  final List<String> items = [
    'ตลิ่งชัน',
    'บางเลน'
  ];
  String? selectedValue;

  void fetchEmployeeData() async {
    var data = await EmployeeService.getAllEmployee();

    setState(() {
      employeeData = data;

      officeTaLingChan = data.where((employee) {
        return employee.office == 'ตลิ่งชัน';
      }).toList();

      registerTalingchan = officeTaLingChan.where((register) {
        return register.statusRegister == true;
      }).length;

      officeBanglen = data.where((employee) {
        return employee.office == 'บางเลน';
      }).toList();

      registerBanglen = officeBanglen.where((register) {
        return register.statusRegister == true;
      }).length;
    });
  }

  List getSearchDataTaLingChan(String employeeCode, String name) {
    return officeTaLingChan.where((row) {
      return row.code.contains(employeeCode) ||  // กรองตามรหัส
          row.name.contains(name); // กรองตามชื่อเล่น
    }).toList();
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
            "ลงทะเบียน Outing trip",
            style: TextStyle(
              fontSize: fontAppbar,
              fontWeight: FontWeight.bold
            ),
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
                      fontSize: fontTitle,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: screenHeight / 5,
                    width: screenWidth / 1.05,
                    decoration: BoxDecoration(
                        color: Colors.pink[200],
                        borderRadius: BorderRadius.circular(20)
                    ),
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
                                      "สำนักงาน",
                                      style: TextStyle(
                                          fontSize: fontSubTitle,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          fontSize: fontSubTitle,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: screenWidth / 3,
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
                                              'เลือกสำนักงาน',
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
                                          .map((String item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            fontSize: fontDropdown,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )).toList(),
                                      value: selectedValue,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = value;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: screenHeight / 20,
                                        width: screenWidth / 3,
                                        padding: const EdgeInsets.only(left: 14, right: 14),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14),
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
                                          borderRadius: BorderRadius.circular(14),
                                          border: Border.all(
                                            color: Colors.black26, // เพิ่มขอบให้กับดรอปดาวน์
                                          ),
                                          //color: Colors.pink[300],
                                        ),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness: WidgetStateProperty.all(6),
                                          thumbVisibility: WidgetStateProperty.all(true),
                                        ),
                                      ),
                                      menuItemStyleData: MenuItemStyleData(
                                        height: 50,
                                        padding: EdgeInsets.only(left: 14, right: 14),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "รหัสพนักงาน",
                                  style: TextStyle(
                                      fontSize: fontSubTitle,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight / 20,
                                  width: screenWidth / 1.8,
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
                                  "ชื่อ-นามสกุล",
                                  style: TextStyle(
                                      fontSize: fontSubTitle,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight / 20,
                                  width: screenWidth / 1.93,
                                  child: SearchField(
                                    readOnly: false,
                                    controller: name,
                                    focusNode: nameFocus,
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
                                  "",
                                  style: TextStyle(
                                      fontSize: fontSubTitle,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: buttonCamera,
                                  foregroundColor: buttonCamera,
                                  radius: 20,
                                  child: IconButton(
                                      onPressed: () async {
                                        String? res = await SimpleBarcodeScanner.scanBarcode(
                                          context,
                                          barcodeAppBar: const BarcodeAppBar(
                                            appBarTitle: 'Test',
                                            centerTitle: false,
                                            enableBackButton: true,
                                            backButtonIcon: Icon(Icons.arrow_back_ios),
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
                                      icon: Icon(Icons.qr_code_scanner, color: Colors.black,)
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text('', style: TextStyle(fontSize: fontSubTitle),),
                                ButtonWidget(
                                  height: screenHeight / 20,
                                  width: screenWidth / 4.5,
                                  text: 'ค้นหา',
                                  colorText: Colors.white,
                                  colorButton: saveButton,
                                  fontTextSize: fontSubTitle,
                                  onPressed: () async {
                                    if(selectedValue == null || selectedValue == '') {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "กรุณาเลือกสำนักงาน",
                                            style: TextStyle(fontSize: fontInputText),
                                          )
                                        )
                                      );
                                    } else {
                                      getSearchDataTaLingChan(employeeCode.text, name.text);
                                      // filterData();
                                      // var result = await EmployeeService.searchEmployee(
                                      //     employeeCode.text,
                                      //     name.text,
                                      //     selectedValue!
                                      // );
                                      // if(result.isNotEmpty) {
                                      //   searchedEmployeeCode = result[0]['รหัสพนักงาน'].toString();
                                      //   fetchEmployeeData();
                                      // }
                                    }
                                  },
                                ),
                              ],
                            )
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
                    //data talingchan
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "สำนักงานใหญ่ (ตลิ่งชัน)",
                        style: TextStyle(
                            fontSize: fontTitle,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 5),
                          child: Text(
                            "ลงทะเบียนแล้ว $registerTalingchan / ${officeTaLingChan.length} คน",
                            style: TextStyle(
                                fontSize: fontSubTitle,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                          child: InkWell(
                            onTap : () {
                              setState(() {
                                isVisibleTalingChan = !isVisibleTalingChan;
                              });
                            },
                            child: Text(
                              "แสดง / ซ่อน",
                              style: TextStyle(
                                fontSize: fontSubTitle,
                                fontWeight: FontWeight.w500,
                                color: hideData
                              ),
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
                            child: FittedBox(
                              child: employeeData != null ?
                              DataTable(
                                headingRowColor: WidgetStateProperty.resolveWith((states) => Colors.teal.shade100),
                                dataRowColor: WidgetStateProperty.resolveWith((states) => Colors.teal.shade50.withOpacity(0.5)),
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
                                          style: TextStyle(fontSize: fontData, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Center(
                                        child: Text(
                                          'ชื่อ-นามสกุล',
                                          style: TextStyle(fontSize: fontData, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Center(
                                        child: Text(
                                          'ชื่อเล่น',
                                          style: TextStyle(fontSize: fontData, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Center(
                                        child: Text(
                                          'แผนก',
                                          style: TextStyle(fontSize: fontData, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Center(
                                        child: Text(
                                          'สถานะ',
                                          style: TextStyle(fontSize: fontData, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                rows: officeTaLingChan.map((row) {
                                  bool isHighlighted = searchedEmployeeCode == row.code;

                                  return DataRow(
                                    color: WidgetStateProperty.resolveWith(
                                          (states) => isHighlighted ? Colors.yellow.shade200 : Colors.transparent,
                                    ),
                                    cells: <DataCell>[
                                      DataCell(
                                          Center(
                                            child: Text(
                                              row.code,
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Text(
                                            row.name,
                                            softWrap: true,
                                            style: TextStyle(
                                                fontSize: fontData
                                            ),
                                            textAlign: TextAlign.start,
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              row.nickName,
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              row.jobDepartment,
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          InkWell(
                                            child: Center(
                                              child: Text(
                                                row.statusRegister == false
                                                    ? 'ลงทะเบียน'
                                                    : 'เสร็จสิ้น',
                                                style: TextStyle(
                                                    fontSize: fontData,
                                                    color: row.statusRegister == false
                                                        ? dataButton
                                                        : success
                                                ),
                                              ),
                                            ),
                                            onTap: () async {
                                              await EmployeeService.registerEmployee(row.code);
                                              fetchEmployeeData();
                                            },
                                          )
                                      ),
                                    ],
                                  );
                                }).toList()
                              )
                              : SizedBox(
                                  width : screenWidth / 2,
                                  height: screenHeight / 12,
                                  child: CircularProgressIndicator())
                            ),
                          ),
                        ],
                      ),
                    ),

                    //data banglen
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "สำนักงาน (บางเลน)",
                        style: TextStyle(
                            fontSize: fontTitle,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 5),
                          child: Text(
                            "ลงทะเบียนแล้ว $registerBanglen / ${officeBanglen.length} คน",
                            style: TextStyle(
                                fontSize: fontSubTitle,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                          child: InkWell(
                            onTap : () {
                              setState(() {
                                isVisibleBangLen = !isVisibleBangLen;
                              });
                            },
                            child: Text(
                              "แสดง / ซ่อน",
                              style: TextStyle(
                                fontSize: fontSubTitle,
                                fontWeight: FontWeight.w500,
                                color: hideData
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isVisibleBangLen,
                      child: Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                                child: employeeData != null ?
                                DataTable(
                                    headingRowColor: WidgetStateProperty.resolveWith((states) => Colors.teal.shade100),
                                    dataRowColor: WidgetStateProperty.resolveWith((states) => Colors.teal.shade50.withOpacity(0.5)),
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
                                              style: TextStyle(fontSize: fontData, fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Center(
                                            child: Text(
                                              'ชื่อ-นามสกุล',
                                              style: TextStyle(fontSize: fontData, fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Center(
                                            child: Text(
                                              'ชื่อเล่น',
                                              style: TextStyle(fontSize: fontData, fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Center(
                                            child: Text(
                                              'แผนก',
                                              style: TextStyle(fontSize: fontData, fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Center(
                                            child: Text(
                                              'สถานะ',
                                              style: TextStyle(fontSize: fontData, fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: officeBanglen.map((row) {
                                      return DataRow(
                                        cells: <DataCell>[
                                          DataCell(
                                              Center(
                                                child: Text(
                                                  row.code,
                                                  style: TextStyle(
                                                      fontSize: fontData
                                                  ),
                                                ),
                                              )
                                          ),
                                          DataCell(
                                              Text(
                                                row.name,
                                                softWrap: true,
                                                style: TextStyle(
                                                    fontSize: fontData
                                                ),
                                                textAlign: TextAlign.start,
                                              )
                                          ),
                                          DataCell(
                                              Center(
                                                child: Text(
                                                  row.nickName,
                                                  style: TextStyle(
                                                      fontSize: fontData
                                                  ),
                                                ),
                                              )
                                          ),
                                          DataCell(
                                              Center(
                                                child: Text(
                                                  row.jobDepartment,
                                                  style: TextStyle(
                                                      fontSize: fontData
                                                  ),
                                                ),
                                              )
                                          ),
                                          DataCell(
                                            InkWell(
                                              child: Center(
                                                child: Text(
                                                  row.statusRegister == false
                                                      ? 'ลงทะเบียน'
                                                      : 'เสร็จสิ้น',
                                                  style: TextStyle(
                                                      fontSize: fontData,
                                                      color: row.statusRegister == false
                                                          ? dataButton
                                                          : success
                                                  ),
                                                ),
                                              ),
                                              onTap: () async {
                                                await EmployeeService.registerEmployee(row.code);
                                                fetchEmployeeData();
                                              },
                                            )
                                          ),
                                        ],
                                      );
                                    }).toList()
                                )
                                    : SizedBox(
                                    width : screenWidth / 2,
                                    height: screenHeight / 12,
                                    child: CircularProgressIndicator())
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
