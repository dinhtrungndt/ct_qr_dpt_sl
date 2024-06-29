// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'shift_model.dart';

class Company {
  int id;
  String code;
  String name;
  Company({
    required this.id,
    required this.code,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'name': name,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['id'] as int,
      code: map['code'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CompanyModel {
  static List<RegionModel> regionList = [
    // RegionModel(id: 1, name: 'vung a', note: 'n v a', branchList: [
    //   BranchModel(id: 1, name: 'chi nhanh a1', note: '', regionName: 'vung a',regionID: 1),
    //   BranchModel(id: 2, name: 'chi nhanh a2', note: '', regionName: 'vung a',regionID: 1)
    // ]),
    // RegionModel(id: 2, name: 'vung b', note: 'n v b', branchList: [
    //   BranchModel(
    //       id: 1, name: 'chi nhanh b1', note: 'note1', regionName: 'vung b',regionID: 2),
    //   BranchModel(id: 2, name: 'chi nhanh b2', note: '', regionName: 'vung b',regionID: 2),
    //   BranchModel(
    //       id: 3, name: 'chi nhanh b3', note: 'note3', regionName: 'vung b',regionID: 2)
    // ]),
  ];
  static List<LocationModel> locationList = [];
  static LocationModel? currentLocation;
  static ShiftModel? shiftModel;
  static bool checkInStatus = false;
}

class RegionModel {
  int id;
  String name;
  String description;
  RegionModel({
    required this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory RegionModel.fromMap(Map<String, dynamic> map) {
    return RegionModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegionModel.fromJson(String source) =>
      RegionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
// class RegionModel {
//   int id;
//   String name;
//   String note;
//   List<BranchModel> branchList;
//   RegionModel(
//       {required this.id,
//       required this.name,
//       required this.note,
//       required this.branchList});
//   RegionModel copyWith(
//       {int? id, String? name, String? note, List<BranchModel>? branchList}) {
//     return RegionModel(
//         id: id ?? this.id,
//         name: name ?? this.name,
//         note: note ?? this.note,
//         branchList: branchList ?? this.branchList);
//   }
// }

class BranchModel {
  int id;
  String name;
  int areaID;
  String description;
  BranchModel({
    required this.id,
    required this.name,
    required this.areaID,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'areaID': areaID,
      'description': description,
    };
  }

  factory BranchModel.fromMap(Map<String, dynamic> map) {
    return BranchModel(
      id: map['id'] as int,
      name: map['name'] as String,
      areaID: map['areaID'] as int,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BranchModel.fromJson(String source) =>
      BranchModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class LocationModel {
  int id;
  String name;
  String address;
  double lat;
  double lng;
  int branchID;
  double radius;
  LocationModel({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
    required this.branchID,
    required this.radius,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'latitude': lat,
      'longitude': lng,
      'branchID': branchID,
      'radius': radius,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      lat: map['latitude'].toDouble() ?? .0,
      lng: map['longitude'].toDouble() ?? .0,
      branchID: map['branchID'],
      radius: map['radius'] != null ? map['radius'].toDouble() : .0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  LocationModel copyWith({
    int? id,
    String? name,
    String? address,
    double? lat,
    double? lng,
    int? branchID,
    double? radius,
  }) {
    return LocationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      branchID: branchID ?? this.branchID,
      radius: radius ?? this.radius,
    );
  }
}

class PlaceSearchModel {
  final String description;
  final String placeId;
  PlaceSearchModel({required this.description, required this.placeId});
  PlaceSearchModel.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        placeId = json['place_id'];
}

class PlaceModel {
  final GeometryModel geometry;
  final String name;
  PlaceModel({required this.geometry, required this.name});
  PlaceModel.fromJson(Map<String, dynamic> json)
      : geometry = GeometryModel.fromJson(json['geometry']),
        name = json['formatted_address'];
}

class GeometryModel {
  final CoordinatesModel coordinates;
  GeometryModel({required this.coordinates});
  GeometryModel.fromJson(Map<dynamic, dynamic> json)
      : coordinates = CoordinatesModel.fromJson(json['location']);
}

class CoordinatesModel {
  final double lat;
  final double lng;
  CoordinatesModel({required this.lat, required this.lng});
  CoordinatesModel.fromJson(Map<dynamic, dynamic> json)
      : lat = json['lat'],
        lng = json['lng'];
}

class OrganizationModel {
  int id;
  String title;
  String? description;
  OrganizationModel({
    required this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory OrganizationModel.fromMap(Map<String, dynamic> map) {
    return OrganizationModel(
      id: map['id'],
      title: map['title'],
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrganizationModel.fromJson(String source) =>
      OrganizationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PositionModel {
  int id;
  String name;
  String? description;
  PositionModel({
    required this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory PositionModel.fromMap(Map<String, dynamic> map) {
    return PositionModel(
      id: map['ID'],
      name: map['Name'],
      description: map['Description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PositionModel.fromJson(String source) =>
      PositionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
