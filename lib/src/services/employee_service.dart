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

  static Future<Map<String, dynamic>> checkInBoat(String code) async {
    try {
      print('Before sending data: ${jsonEncode(code)}');

      final response = await http.put(
        Uri.parse(ApiEndPoints.baseUrl +  ApiEndPoints.authEndPoints.checkInBoat + code),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('check in success');
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

  static Future<Map<String, dynamic>> nightPartyEmployee(String code) async {
    try {
      print('Before sending data: ${jsonEncode(code)}');

      final response = await http.put(
        Uri.parse(ApiEndPoints.baseUrl +  ApiEndPoints.authEndPoints.nightParty + code),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('check in success');
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

  static Future<Map<String, dynamic>> closeRoundEmployee(String car) async {
    var result;

    final Map<String, dynamic> carData = {
      'car': car
    };

    print('Before sending data: ${jsonEncode(car)}');

    final response = await http.post(
      Uri.parse(ApiEndPoints.baseUrl +  ApiEndPoints.authEndPoints.closeRound),
      body: json.encode(carData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var body = response.body;
      result = await json.decode(body);
      print(result);
    }
    return result;

  }

  static Future<Map<String, dynamic>> closeNightPartyEmployee() async {
    try {

      final response = await http.put(
        Uri.parse(ApiEndPoints.baseUrl +  ApiEndPoints.authEndPoints.closeNightParty),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('check in success');
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

  static Future<Map<String, dynamic>> closeBoatEmployee(String boat) async {
    var result;

    final Map<String, dynamic> boatData = {
      'boat': boat
    };

    print('Before sending data: ${jsonEncode(boat)}');

    final response = await http.post(
      Uri.parse(ApiEndPoints.baseUrl +  ApiEndPoints.authEndPoints.closeBoat),
      body: json.encode(boatData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var body = response.body;
      result = await json.decode(body);
      print(result);
    }
    return result;

  }


}