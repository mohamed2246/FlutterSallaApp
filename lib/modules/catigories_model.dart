class CatigoriesModel {
  bool? status;

  String? message;

  CatigoriesDataModel? data;

  CatigoriesModel.fromJosn(Map<String, dynamic> json) {
    status = json[status];
    message = json[message];
    data = CatigoriesDataModel.fromJson(json['data']);
  }
}

class CatigoriesDataModel {
  int? current_page;

  List<DataModel>? data = [];

  CatigoriesDataModel.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((e) {
      data?.add(DataModel.fromJson(e));
    });
  }
}

class DataModel {
  int? id;

  String? name;
  String? image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
