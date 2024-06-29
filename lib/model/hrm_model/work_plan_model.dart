class WorkPlanModel {
  final String code;
  final String fullName;
  final String attendCode;
  final DateTime day;
  final int shiftID;
  final String shiftName;
  final String shiftCode;
  WorkPlanModel(
      {required this.code,
      required this.fullName,
      required this.attendCode,
      required this.day,
      required this.shiftID,
      required this.shiftName,
      required this.shiftCode});
  WorkPlanModel.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        fullName = json['fullName'],
        attendCode = json['attendCode'],
        day = DateTime.parse(json['day']).toLocal(),
        shiftID = json['shiftID'],
        shiftName = json['shiftName'],
        shiftCode = json['shiftCode'];

  factory WorkPlanModel.fromMap(Map<String, dynamic> map) {
    return WorkPlanModel(
      code: map['code'] ?? '',
      fullName: map['fullName'] ?? '',
      attendCode: map['attendCode'] ?? '',
      day: DateTime.parse(map['day']).toLocal() ?? DateTime.now(),
      shiftID: map['shiftID'],
      shiftName: map['shiftName'] ?? '',
      shiftCode: map['shiftCode'] ?? '',
    );
  }
}
