class Employee {
  String code;
  String barcode;
  String name;
  String nickname;
  String position;
  String department;
  String color;
  String car;
  String boat;
  String office;
  bool outingStatus;
  bool flagGift;
  bool flagReward;
  bool checkIn;
  bool nightParty;
  String gift;
  bool rewards;
  bool checkBoat;

  Employee({
    required this.code,
    required this.barcode,
    required this.name,
    required this.nickname,
    required this.position,
    required this.department,
    required this.color,
    required this.car,
    required this.boat,
    required this.office,
    required this.outingStatus,
    required this.flagGift,
    required this.flagReward,
    required this.checkIn,
    required this.nightParty,
    required this.gift,
    required this.rewards,
    required this.checkBoat
  });

  factory Employee.fromJSON(Map<String, dynamic> json) => Employee(
    code: json['emp_code'] ?? '',
    barcode: json['barcode'] ?? '',
    name: json['emp_name'] ?? '',
    nickname: json['nickname'] ?? '',
    position: json['position'] ?? '',
    department: json['department'] ?? '',
    color: json['color'] ?? '',
    car: json['car'] ?? '',
    boat: json['boat'] ?? '',
    office: json['office'] ?? '',
    outingStatus: json['outing_status'] ?? false,
    flagGift: json['flag_gift'] ?? false,
    flagReward: json['flag_reward'] ?? false,
    checkIn: json['checkin'] ?? false,
    nightParty: json['nightparty'] ?? false,
    gift: json['gift'] ?? '',
    rewards: json['rewards'] ?? false,
    checkBoat: json['check_boat'] ?? false,
  );
}
