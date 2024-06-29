class ShiftCalendarModel {
  final int id;
  final String name;
  final String code;
  final DateTime fromTime;
  final DateTime toTime;
  ShiftCalendarModel(
      {required this.id,
      required this.name,
      required this.code,
      required this.fromTime,
      required this.toTime});
  ShiftCalendarModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['title'],
        code = json['code'],
        fromTime =  DateTime.parse(json['fromTime']).toLocal(),
        toTime =  DateTime.parse(json['toTime']).toLocal();
}