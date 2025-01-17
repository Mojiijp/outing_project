class Employee {
  String code;
  String barcode;
  String name;
  String nickName;
  String jobPosition;
  String jobDepartment;
  String color;
  String carNo;
  bool statusRegister;
  String office;
  bool rewardOnSite;
  bool rewardInSite;

  Employee({
    required this.code,
    required this.barcode,
    required this.name,
    required this.nickName,
    required this.jobPosition,
    required this.jobDepartment,
    required this.color,
    required this.carNo,
    required this.statusRegister,
    required this.office,
    required this.rewardOnSite,
    required this.rewardInSite
  });

  factory Employee.fromJSON(Map<String, dynamic> json) => Employee(
      code: json['รหัสพนักงาน'] ?? '',
      barcode: json['รหัสบาร์โค้ด'] ?? '',
      name: json['ชื่อนามสกุล'] ?? '',
      nickName: json['ชื่อเล่น'] ?? '',
      jobPosition: json['ตำแหน่ง'] ?? '',
      jobDepartment: json['แผนก'] ?? '',
      color: json['ประจำสี'] ?? '',
      carNo: json['รถคันที่'] ?? '',
      statusRegister: json['สถานะเข้าร่วม'] ?? false,
      office: json['สำนักงาน'] ?? '',
      rewardOnSite: json['รางวัลหน้างาน'] ?? false,
      rewardInSite: json['รางวัลในงาน'] ?? false
  );

}
