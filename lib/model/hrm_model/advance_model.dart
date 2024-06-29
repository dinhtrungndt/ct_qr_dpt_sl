class AdvanceKindModel {
  final int id;
  final String name;
  final String code;
  AdvanceKindModel({required this.id, required this.name, required this.code});
  AdvanceKindModel.fromJson(Map<String, dynamic> json)
      : id = json['ID'],
        name = json['Reduce'],
        code = json['Code'];
}
