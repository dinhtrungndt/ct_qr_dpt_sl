class FilterPersonnelModel {
  final int id;
  final String name;
  List<FilterPersonnelDetailModel> listFilterPersonnelDetailModel = [];
  FilterPersonnelModel({required this.id, required this.name});
}

class FilterPersonnelDetailModel {
  final int id;
  final int groupID;
  final String name;
  bool selected = false;
  FilterPersonnelDetailModel(
      {required this.groupID, required this.id, required this.name});
}
