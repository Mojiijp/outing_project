import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:outing_project/components/colors.dart';
import 'package:outing_project/components/variables.dart';
import 'package:outing_project/widgets/button.dart';
import 'package:outing_project/widgets/input_form.dart';
import 'package:outing_project/widgets/search_form.dart';
import 'package:outing_project/widgets/search_form.dart';

class OutingScreen extends StatefulWidget {
  const OutingScreen({super.key});

  @override
  State<OutingScreen> createState() => _OutingScreenState();
}

class _OutingScreenState extends State<OutingScreen> {
  final List<String> items = [
    'ตลิ่งชัน',
    'บางเลน'
  ];
  String? selectedValue;

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
                                  width: screenWidth / 1.55,
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
                              children: [
                                Text('', style: TextStyle(fontSize: fontSubTitle),),
                                ButtonWidget(
                                  height: screenHeight / 20,
                                  width: screenWidth / 4,
                                  text: 'ค้นหา',
                                  colorText: Colors.white,
                                  colorButton: saveButton,
                                  fontTextSize: fontSubTitle,
                                  onPressed: () {
                                    if(selectedValue == null || selectedValue == '') {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "กรุณาเลือกสำนักงาน",
                                            style: TextStyle(fontSize: fontInputText),
                                          )
                                        )
                                      );
                                    } else if ((employeeCode.text == '' || employeeCode.text.isEmpty) ||
                                        (name.text == '' || name.text.isEmpty) ) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                "กรุณากรอกรหัสหรือชื่อพนักงาน",
                                                style: TextStyle(fontSize: fontInputText),
                                              )
                                          )
                                      );
                                    } else {

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
                            "ลงทะเบียนแล้ว 5 / 10 คน",
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
                              child: DataTable(
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
                                rows: <DataRow>[
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                          Center(
                                            child: Text(
                                              '660143',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'พงศกร พันธุ์บุตรดี',
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'เดียร์',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'Software',
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
                                                'ลงทะเบียน',
                                                style: TextStyle(
                                                    fontSize: fontData,
                                                    color: dataButton
                                                ),
                                              ),
                                            ),
                                            onTap: () {},
                                          )
                                      ),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                          Center(
                                            child: Text(
                                              '660143',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'พงศกร พันธุ์บุตรดี',
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'เดียร์',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'Software',
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
                                                'ลงทะเบียน',
                                                style: TextStyle(
                                                    fontSize: fontData,
                                                    color: dataButton
                                                ),
                                              ),
                                            ),
                                            onTap: () {},
                                          )
                                      ),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                          Center(
                                            child: Text(
                                              '660143',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'พงศกร พันธุ์บุตรดี',
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'เดียร์',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'Software',
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
                                                'ลงทะเบียน',
                                                style: TextStyle(
                                                    fontSize: fontData,
                                                    color: dataButton
                                                ),
                                              ),
                                            ),
                                            onTap: () {},
                                          )
                                      ),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                          Center(
                                            child: Text(
                                              '660143',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'พงศกร พันธุ์บุตรดี',
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'เดียร์',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'Software',
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
                                                'ลงทะเบียน',
                                                style: TextStyle(
                                                    fontSize: fontData,
                                                    color: dataButton
                                                ),
                                              ),
                                            ),
                                            onTap: () {},
                                          )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
                            "ลงทะเบียนแล้ว 5 / 10 คน",
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
                              child: DataTable(
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
                                rows: <DataRow>[
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                          Center(
                                            child: Text(
                                              '660100',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'ชาติชาย ชัยมั่นคง',
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'เบิร์ด',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'บัญชี',
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
                                                'ลงทะเบียน',
                                                style: TextStyle(
                                                    fontSize: fontData,
                                                    color: dataButton
                                                ),
                                              ),
                                            ),
                                            onTap: () {},
                                          )
                                      ),
                                    ],
                                    color: WidgetStateProperty.resolveWith<Color?>(
                                          (states) {
                                        return Colors.yellow.shade200; // เปลี่ยนสีพื้นหลังถ้าตรงกับคำค้นหา
                                      },
                                    ),
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                          Center(
                                            child: Text(
                                              '660100',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'ชาติชาย ชัยมั่นคง',
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'เบิร์ด',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'บัญชี',
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
                                                'ลงทะเบียน',
                                                style: TextStyle(
                                                    fontSize: fontData,
                                                    color: dataButton
                                                ),
                                              ),
                                            ),
                                            onTap: () {},
                                          )
                                      ),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                          Center(
                                            child: Text(
                                              '660100',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'ชาติชาย ชัยมั่นคง',
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'เบิร์ด',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'บัญชี',
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
                                                'ลงทะเบียน',
                                                style: TextStyle(
                                                    fontSize: fontData,
                                                    color: dataButton
                                                ),
                                              ),
                                            ),
                                            onTap: () {},
                                          )
                                      ),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                          Center(
                                            child: Text(
                                              '660100',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'ชาติชาย ชัยมั่นคง',
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'เบิร์ด',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'บัญชี',
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
                                                'ลงทะเบียน',
                                                style: TextStyle(
                                                    fontSize: fontData,
                                                    color: dataButton
                                                ),
                                              ),
                                            ),
                                            onTap: () {},
                                          )
                                      ),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                          Center(
                                            child: Text(
                                              '660100',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'ชาติชาย ชัยมั่นคง',
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'เบิร์ด',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'บัญชี',
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
                                                'ลงทะเบียน',
                                                style: TextStyle(
                                                    fontSize: fontData,
                                                    color: dataButton
                                                ),
                                              ),
                                            ),
                                            onTap: () {},
                                          )
                                      ),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                          Center(
                                            child: Text(
                                              '660100',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'ชาติชาย ชัยมั่นคง',
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'เบิร์ด',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'บัญชี',
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
                                                'ลงทะเบียน',
                                                style: TextStyle(
                                                    fontSize: fontData,
                                                    color: dataButton
                                                ),
                                              ),
                                            ),
                                            onTap: () {},
                                          )
                                      ),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                          Center(
                                            child: Text(
                                              '660100',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'ชาติชาย ชัยมั่นคง',
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'เบิร์ด',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'บัญชี',
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
                                                'ลงทะเบียน',
                                                style: TextStyle(
                                                    fontSize: fontData,
                                                    color: dataButton
                                                ),
                                              ),
                                            ),
                                            onTap: () {},
                                          )
                                      ),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                          Center(
                                            child: Text(
                                              '660100',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'ชาติชาย ชัยมั่นคง',
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'เบิร์ด',
                                              style: TextStyle(
                                                  fontSize: fontData
                                              ),
                                            ),
                                          )
                                      ),
                                      DataCell(
                                          Center(
                                            child: Text(
                                              'บัญชี',
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
                                                'ลงทะเบียน',
                                                style: TextStyle(
                                                    fontSize: fontData,
                                                    color: dataButton
                                                ),
                                              ),
                                            ),
                                            onTap: () {},
                                          )
                                      ),
                                    ],
                                  ),

                                ],
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
