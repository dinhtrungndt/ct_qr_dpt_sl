class OnLeaveKindModel {
  final int id;
  final String name;
  final String code;
  final String group;
  OnLeaveKindModel(
      {required this.id,
      required this.name,
      required this.code,
      required this.group});
  OnLeaveKindModel.fromJson(Map<String, dynamic> json)
      : id = json['ID'],
        name = json['PermissionType'],
        code = json['Code'],
        group = json['PermissionGroup'];
}

class OnLeaveProfileModel {
  final int id;
  final String code;
  final String fullName;
  final DateTime dateStart;
  final double dayEarn;
  final double dayBreak;
  final double pendingPermit;
  final double surplus;
  final double outdated;
  final double bonus;
  final double previousSurplus;
  final double advance;
  OnLeaveProfileModel(
      {required this.id,
      required this.code,
      required this.fullName,
      required this.dateStart,
      required this.dayEarn,
      required this.dayBreak,
      required this.pendingPermit,
      required this.surplus,
      required this.outdated,
      required this.bonus,
      required this.previousSurplus,
      required this.advance});
  OnLeaveProfileModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        code = json['code'],
        fullName = json['fullName'],
        dateStart = json['dateStart'],
        dayEarn = json['dayEarn'],
        dayBreak = json['dayBreak'],
        pendingPermit = json['pendingPermit'],
        surplus = json['surplus'],
        outdated = json['outdated'],
        bonus = json['bonus'],
        previousSurplus = json['previousSurplus'],
        advance = json['advance'];

  factory OnLeaveProfileModel.fromMap(Map<String, dynamic> map) {
    return OnLeaveProfileModel(
      id: map['id'] != null ? map['id'] as dynamic : null,
      code: map['code'] != null ? map['code'] as dynamic : null,
      fullName: map['fullName'] != null ? map['fullName'] as dynamic : null,
      dateStart: map['dateStart'] != null
          ? DateTime.parse(map['dateStart']) as dynamic
          : null,
      dayEarn:
          map['dayEarn'] != null ? map['dayEarn'].toDouble() as dynamic : null,
      dayBreak: map['dayBreak'] != null
          ? map['dayBreak'].toDouble() as dynamic
          : null,
      pendingPermit: map['pendingPermit'] != null
          ? map['pendingPermit'].toDouble() as dynamic
          : null,
      surplus:
          map['surplus'] != null ? map['surplus'].toDouble() as dynamic : null,
      outdated: map['outdated'] != null
          ? map['outdated'].toDouble() as dynamic
          : null,
      bonus: map['bonus'] != null ? map['bonus'].toDouble() as dynamic : null,
      previousSurplus: map['previousSurplus'] != null
          ? map['previousSurplus'].toDouble() as dynamic
          : null,
      advance:
          map['advance'] != null ? map['advance'].toDouble() as dynamic : 0,
    );
  }
}
