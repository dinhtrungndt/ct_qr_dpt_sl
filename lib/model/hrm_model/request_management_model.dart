// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RequestManagementKind {
  final int id;
  final String name;
  RequestManagementKind({required this.id, required this.name});
}

class FilterRequestModel {
  final int id;
  final String name;
  List<FilterRequestDetailModel> listFilterRequestDetailModel = [];
  FilterRequestModel({required this.id, required this.name});
}

class FilterRequestDetailModel {
  final int id;
  final int groupID;
  final String name;
  bool selected = false;
  FilterRequestDetailModel(
      {required this.groupID, required this.id, required this.name});
}

class RequestStatusModel {
  final int id;
  final String name;
  RequestStatusModel({required this.id, required this.name});
  static RequestStatusModel getRequestStatusModel(int kind) {
    if (kind == 0) {
      return RequestStatusModel(id: 0, name: 'Chờ phê duyệt');
    } else if (kind == 1) {
      return RequestStatusModel(id: 1, name: 'Đã phê duyệt');
    } else {
      return RequestStatusModel(id: 2, name: 'Từ chối');
    }
  }
}

class RequestModel {
  final int id;
  final String name;
  RequestModel({required this.id, required this.name});
}

class TimekeepingOffsetRequestModel {
  final int id;
  final int status;
  final int employeeID;
  final String? fullName;
  final String? position;
  final String? department;
  final int decision;
  final DateTime dateApply;
  final int shiftID;
  final String shift;
  final String reason;
  final String note;
  final DateTime fromTime;
  final DateTime toTime;
  final String? createBy;
  final DateTime? createDate;
  final String? roleNo_;

  TimekeepingOffsetRequestModel({
    required this.id,
    required this.status,
    required this.employeeID,
    required this.fullName,
    required this.position,
    required this.department,
    required this.decision,
    required this.dateApply,
    required this.shiftID,
    required this.shift,
    required this.reason,
    required this.note,
    required this.fromTime,
    required this.toTime,
    required this.createBy,
    required this.createDate,
    required this.roleNo_,
  });
  TimekeepingOffsetRequestModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        status = json['status'] ?? 0,
        employeeID = json['employeeID'] ?? 0,
        fullName = json['fullName'] ?? '',
        position = json['position'] ?? '',
        department = json['department'] ?? '',
        decision = json['decision'],
        dateApply = DateTime.parse(json['dateApply']).toLocal(),
        shiftID = json['shiftID'],
        shift = json['shift'],
        fromTime = DateTime.parse(json['fromTime']).toLocal(),
        toTime = DateTime.parse(json['toTime']).toLocal(),
        createBy = json['createBy'] ?? '',
        createDate = json['createDate'] == null
            ? null
            : DateTime.parse(json['createDate']).toLocal(),
        reason = json['reason'] ?? '',
        note = json['note'] ?? '',
        roleNo_ = json['roleNo_'] ?? '';
}

class OnLeaveRequestModel {
  final int id;
  final int status;
  final int decision;
  final int employeeID;
  final String? fullName;
  final String? position;
  final String? department;
  final DateTime expired;
  final int permissionType;
  final String permissionName;
  final String description;
  final DateTime fromDate;
  final DateTime toDate;
  final String createBy;
  final DateTime? createDate;
  final double qty;
  final String? roleNo_;
  final String? note;
  OnLeaveRequestModel(
      {required this.id,
      required this.status,
      required this.decision,
      required this.employeeID,
      required this.fullName,
      required this.position,
      required this.department,
      required this.expired,
      required this.permissionType,
      required this.permissionName,
      required this.fromDate,
      required this.toDate,
      required this.qty,
      required this.createBy,
      required this.createDate,
      required this.description,
      required this.roleNo_,
      required this.note});
  OnLeaveRequestModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        status = json['status'],
        decision = json['decision'] ?? 0,
        employeeID = json['employeeID'] ?? 0,
        fullName = json['fullName'] ?? '',
        position = json['position'] ?? '',
        department = json['department'] ?? '',
        expired = DateTime.parse(json['expired']).toLocal(),
        permissionType = json['permissionType'],
        permissionName = json['permissionName'] ?? '',
        fromDate = DateTime.parse(json['fromDate']).toLocal(),
        toDate = DateTime.parse(json['toDate']).toLocal(),
        qty = json['qty'] != null ? json['qty'].toDouble() : 0.0,
        createBy = json['createBy'] ?? '',
        createDate = json['createDate'] == null
            ? null
            : DateTime.parse(json['createDate']).toLocal(),
        description = json['description'] ?? '',
        roleNo_ = json['roleNo_'] ?? '',
        note = json['note'] ?? '';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'decision': decision,
      'employeeID': employeeID,
      'fullName': fullName,
      'position': position,
      'department': department,
      'expired': expired.millisecondsSinceEpoch,
      'permissionType': permissionType,
      'permissionName': permissionName,
      'description': description,
      'fromDate': fromDate.millisecondsSinceEpoch,
      'toDate': toDate.millisecondsSinceEpoch,
      'createBy': createBy,
      'createDate': createDate?.millisecondsSinceEpoch,
      'qty': qty,
      'roleNo_': roleNo_,
      'note': note,
    };
  }

  String toJson() => json.encode(toMap());
}

class AdvanceRequestModel {
  final int id;
  final String code;
  final int status;
  final int reduce;
  final int qty;
  final DateTime effectFrom;
  final DateTime effectTo;
  final DateTime? createDate;
  final String description;
  AdvanceRequestModel(
      {required this.id,
      required this.code,
      required this.status,
      required this.reduce,
      required this.qty,
      required this.effectFrom,
      required this.effectTo,
      required this.createDate,
      required this.description});
  AdvanceRequestModel.fromJson(Map<String, dynamic> json)
      : id = json['ID'],
        code = json['Code'],
        status = json['Status'],
        reduce = json['Reduce'],
        qty = json['Qty'],
        effectFrom = DateTime.parse(json['EffectFrom']).toLocal(),
        effectTo = DateTime.parse(json['EffectTo']).toLocal(),
        createDate = json['CreateDate'] == null
            ? null
            : DateTime.parse(json['CreateDate']).toLocal(),
        description = json['Description'] ?? '';
}
