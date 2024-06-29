class FilterAssignModel {
  final int id;
  final String name;
  List<FilterAssignDetailModel> listFilterAssignDetailModel = [];
  FilterAssignModel({required this.id, required this.name});
}

class FilterAssignDetailModel {
  final int id;
  final int groupID;
  final String name;
  bool selected = false;
  FilterAssignDetailModel(
      {required this.groupID, required this.id, required this.name});
}
