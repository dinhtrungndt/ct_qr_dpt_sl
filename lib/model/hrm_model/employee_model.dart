import 'dart:convert';

class UserModel {
  static int id = 10088; //8941;
  static String name = '';
  static String siteName = 'KIA';
  static int isShift = 0;
}

class EmployeeModel {
  int? id;
  String? code;
  String? attendCode;
  String? fullName;
  String? address;
  String? phone;
  DateTime? birthDay;
  bool? gender;
  String? position;
  String? organization;
  int? salary;
  EmployeeModel(
      {this.id,
      this.code,
      this.attendCode,
      this.gender,
      this.fullName,
      this.birthDay,
      this.phone,
      this.address,
      this.position,
      this.organization,
      this.salary});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'gender': gender,
      'code': code,
      'attendCode': attendCode,
      'fullName': fullName,
      'birthDay': birthDay,
      'phone': phone,
      'address': address,
      // 'radius': radius,
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      id: map['id'] != null ? map['id'] as dynamic : null,
      gender: map['gender'] != null ? map['gender'] as dynamic : null,
      code: map['code'] != null ? map['code'] as dynamic : null,
      attendCode:
          map['attendCode'] != null ? map['attendCode'] as dynamic : null,
      fullName: map['fullName'] != null ? map['fullName'] as dynamic : null,
      birthDay: map['birthDay'] != null
          ? DateTime.parse(map['birthDay']) as dynamic
          : null,
      phone: map['phone'] != null ? map['phone'] as dynamic : null,
      address: map['address'] != null ? map['address'] as dynamic : null,
      position: map['position'] != null ? map['position'] as dynamic : null,
      organization:
          map['organization'] != null ? map['organization'] as dynamic : null,
      salary: map['salary'] != null ? map['salary'] as dynamic : 0,
    );
  }

  String toJson() => json.encode(toMap());

  EmployeeModel copyWith({
    int? id,
    String? code,
    String? attendCode,
    String? fullName,
    DateTime? birthDay,
    String? phone,
    String? address,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      code: code ?? this.code,
      attendCode: attendCode ?? this.attendCode,
      fullName: fullName ?? this.fullName,
      birthDay: birthDay ?? this.birthDay,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }
}
