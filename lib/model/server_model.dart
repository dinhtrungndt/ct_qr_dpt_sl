class ServerModel {
  final String url;
  final String siteID;

  ServerModel({
    required this.url,
    required this.siteID,
  });
  factory ServerModel.fromJson(Map<String, dynamic> json) {
    return ServerModel(url: json['url'], siteID: json['siteID']);
  }
}

class Server {
  static String url = "";
  static String siteID = "";
}
