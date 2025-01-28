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
  TextEditingController employeeCode = TextEditingController();
  TextEditingController name = TextEditingController();

  List<Employee>? employeeData;
  List officeTaLingChan = [];
  List officeBanglen = [];
  List lengthOfficeTaLingChan = [];
  List lengthOfficeBanglen = [];
  int registerTalingchan = 0;
  int registerBanglen = 0;

  String? searchedEmployeeCode;
  String? selectedValue; // ค่าของสำนักงานที่เลือก

  List<String> items = ['ตลิ่งชัน', 'บางเลน'];
  bool isLoading = true; // เริ่มต้นสถานะกำลังโหลด

  // ฟังก์ชันกรองข้อมูลพนักงาน
  void searchEmployeeData() {
    setState(() {
      // กรองข้อมูลจากรหัสพนักงานที่กรอก
      var filteredData = employeeData!.where((employee) {
        return employee.code.contains(employeeCode.text) &&
            employee.name.contains(name.text);
      }).toList();

      // อัปเดตข้อมูลที่กรองแล้ว
      officeTaLingChan = filteredData
          .where((employee) => employee.office == 'ตลิ่งชัน')
          .toList();
      officeBanglen = filteredData
          .where((employee) => employee.office == 'บางเลน')
          .toList();

      // ไฮไลต์แถวแรกที่ตรงกับผลการค้นหา
      if (filteredData.isNotEmpty) {
        searchedEmployeeCode = filteredData[0].code;
      }
    });
  }

  void empNotRegisData() {
    setState(() {
      var filteredData = employeeData!.where((employee) {
        return employee.outingStatus == false;
      }).toList();

      // อัปเดตข้อมูลที่กรองแล้ว
      officeTaLingChan = filteredData.where((employee) => employee.office == 'ตลิ่งชัน').toList();
      officeBanglen = filteredData.where((employee) => employee.office == 'บางเลน').toList();
    });
  }

  @override
  void initState() {
    super.initState();
    // เริ่มต้นสถานะกำลังโหลด
    isLoading = true;
    isVisibleTalingChan = true;
    isVisibleBangLen = true;

    Future.delayed(Duration(milliseconds: 100), () {
      fetchEmployeeData();
    });
  }

  void fetchEmployeeData() async {
    // ดึงข้อมูลพนักงานทั้งหมดจาก API
    var data = await EmployeeService.getAllEmployee();
    setState(() {
      employeeData = data;
      lengthOfficeTaLingChan =
          data.where((employee) => employee.office == 'ตลิ่งชัน').toList();
      lengthOfficeBanglen =
          data.where((employee) => employee.office == 'บางเลน').toList();
      officeTaLingChan =
          data.where((employee) => employee.office == 'ตลิ่งชัน').toList();
      registerTalingchan = officeTaLingChan
          .where((register) => register.outingStatus == true)
          .length;
      officeBanglen =
          data.where((employee) => employee.office == 'บางเลน').toList();
      registerBanglen = officeBanglen
          .where((register) => register.outingStatus == true)
          .length;

      isLoading = false; // หยุดสถานะกำลังโหลด
    });
  }

  Future<void> dialogNotRegister(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content: const Text(
            'A dialog is a type of modal window that\n'
                'appears in front of app content to\n'
                'provide critical information, or prompt\n'
                'for a decision to be made.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
    double fontData = screenWidth * 0.03;

    return SafeArea(
      child: Scaffold(
          backgroundColor: background,
          appBar: AppBar(
            backgroundColor: backgroundAppbar,
            title: Text(
              "ลงทะเบียน Outing trip",
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
                                        "สำนักงาน",
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
                                            if(selectedValue == 'ตลิ่งชัน') {
                                              isVisibleTalingChan = true;
                                              isVisibleBangLen = false;
                                            } else {
                                              isVisibleTalingChan = false;
                                              isVisibleBangLen = true;
                                            }
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
                                    width: screenWidth / 1.8,
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
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: screenHeight / 20,
                                    width: screenWidth / 1.93,
                                    child: SearchField(
                                      readOnly: false,
                                      controller: name,
                                      focusNode: nameFocus,
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.text,
                                      fontText: fontInputText,
                                      obscureText: false,
                                      onChanged: (val) {
                                        searchEmployeeData();
                                      }
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
                                              employeeCode.text = txtBarcode;
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
                                        searchEmployeeData();
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "สำนักงานใหญ่ (ตลิ่งชัน)",
                              style: TextStyle(
                                  fontSize: fontTitle, fontWeight: FontWeight.bold),
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
                                "ลงทะเบียนแล้ว $registerTalingchan / ${lengthOfficeTaLingChan.length} คน",
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
                                  isVisibleTalingChan = !isVisibleTalingChan;
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
                        child: employeeData == null
                            ? Center(
                                child: SizedBox(
                                  width: 50,
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
                                          'แผนก',
                                          style: TextStyle(
                                              fontSize: fontData,
                                              fontWeight:
                                                  FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                rows: officeTaLingChan.map((row) {
                                  bool isHighlighted =
                                      searchedEmployeeCode == row.code;

                                  return DataRow(
                                    color:
                                        WidgetStateProperty.resolveWith(
                                      (states) => isHighlighted
                                          ? Colors.yellow.shade200
                                          : Colors.transparent,
                                    ),
                                    cells: <DataCell>[
                                      DataCell(
                                        InkWell(
                                          child: Center(
                                            child: Text(
                                              row.outingStatus ==
                                                  false
                                                  ? 'ลงทะเบียน'
                                                  : 'เสร็จสิ้น',
                                              style: TextStyle(
                                                fontSize: fontData,
                                                color:
                                                row.outingStatus ==
                                                    false
                                                    ? dataButton
                                                    : success,
                                              ),
                                            ),
                                          ),
                                          onTap: () async {
                                            await EmployeeService
                                                .registerEmployee(
                                                row.code);
                                            fetchEmployeeData();
                                            employeeCode.clear();
                                            name.clear();
                                          },
                                        ),
                                      ),
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
                                            row.department,
                                            style: TextStyle(
                                                fontSize: fontData),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                      ),

                      //data banglen
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "สำนักงาน (บางเลน)",
                          style: TextStyle(
                              fontSize: fontTitle, fontWeight: FontWeight.bold),
                        ),
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
                                "ลงทะเบียนแล้ว $registerBanglen / ${lengthOfficeBanglen.length} คน",
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
                                  isVisibleBangLen = !isVisibleBangLen;
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
                        visible: isVisibleBangLen,
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
                                  : employeeData != null
                                      ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                            headingRowColor:
                                                WidgetStateProperty
                                                    .resolveWith((states) =>
                                                        Colors.teal.shade100),
                                            dataRowColor: WidgetStateProperty
                                                .resolveWith((states) =>
                                                    Colors.teal.shade50
                                                        .withOpacity(0.5)),
                                            horizontalMargin: 20,
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
                                                          FontWeight
                                                              .w500),
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
                                                              FontWeight
                                                                  .w500),
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
                                                              FontWeight
                                                                  .w500),
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
                                                              FontWeight
                                                                  .w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      'แผนก',
                                                      style: TextStyle(
                                                          fontSize: fontData,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                            rows: officeBanglen.map((row) {
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
                                                  DataCell(InkWell(
                                                    child: Center(
                                                      child: Text(
                                                        row.outingStatus ==
                                                            false
                                                            ? 'ลงทะเบียน'
                                                            : 'เสร็จสิ้น',
                                                        style: TextStyle(
                                                            fontSize:
                                                            fontData,
                                                            color: row.outingStatus ==
                                                                false
                                                                ? dataButton
                                                                : success),
                                                      ),
                                                    ),
                                                    onTap: () async {
                                                      await EmployeeService
                                                          .registerEmployee(
                                                          row.code);
                                                      fetchEmployeeData();
                                                      employeeCode.clear();
                                                      name.clear();
                                                    },
                                                  )),
                                                  DataCell(Center(
                                                    child: Text(
                                                      row.code,
                                                      style: TextStyle(
                                                          fontSize: fontData),
                                                    ),
                                                  )),
                                                  DataCell(Text(
                                                    row.name,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontSize: fontData),
                                                    textAlign:
                                                        TextAlign.start,
                                                  )),
                                                  DataCell(Center(
                                                    child: Text(
                                                      row.nickname,
                                                      style: TextStyle(
                                                          fontSize: fontData),
                                                    ),
                                                  )),
                                                  DataCell(Center(
                                                    child: Text(
                                                      row.department,
                                                      style: TextStyle(
                                                          fontSize: fontData),
                                                    ),
                                                  )),
                                                ],
                                              );
                                            }).toList()),
                                      )
                                      : Center(
                                          child: SizedBox(
                                            width: 10,
                                            height: 10,
                                            child:
                                                CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<
                                                          Color>(
                                                      const Color.fromARGB(
                                                          255,
                                                          255,
                                                          167,
                                                          196)),
                                            ),
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
