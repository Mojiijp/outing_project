import 'dart:convert';

import 'package:outing_project/src/api_endpoint.dart';
import 'package:outing_project/src/model/employee.dart';
import 'package:http/http.dart' as http ;

class EmployeeService {
  static Future<List<Employee>> getAllEmployee () async {
    var result = <Employee>[];

    final response = await http.get(
      Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.allEmployee),
    );

    if (response.statusCode == 200) {
      var body = json.decode(response.body);

      if (body != null && body is List) {
        result = body.map((json) => Employee.fromJSON(json)).toList();
      } else {
        print('ไม่มี Data');
      }
    } else {
      print('API ไม่สามารถให้ข้อมูลได้: ${response.statusCode}');
    }

    return result;
  }

  static Future<Map<String, dynamic>> registerEmployee(String code) async {
    try {
      print('Before sending data: ${jsonEncode(code)}');

      final response = await http.put(
        Uri.parse(ApiEndPoints.baseUrl +  ApiEndPoints.authEndPoints.registerEmployee + code),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        print('Error response body: ${response.body}');
        throw Exception(
            "Failed to send data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      return {}; // คืนค่า Map เปล่าในกรณีเกิดข้อผิดพลาด
    }
  }

  static Future<Map<String, dynamic>> checkInEmployee(String code) async {
    try {
      print('Before sending data: ${jsonEncode(code)}');

      final response = await http.put(
        Uri.parse(ApiEndPoints.baseUrl +  ApiEndPoints.authEndPoints.checkInEmployee + code),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('check in success');
        print(jsonDecode(response.body) as Map<String, dynamic>);
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        print('Error response body: ${response.body}');
        throw Exception(
            "Failed to send data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      return {}; // คืนค่า Map เปล่าในกรณีเกิดข้อผิดพลาด
    }
  }


}