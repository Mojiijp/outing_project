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
        print("employee body : $body");
      } else {
        print('ไม่มี Data');
      }
    } else {
      print('API ไม่สามารถให้ข้อมูลได้: ${response.statusCode}');
    }

    return result;
  }
}