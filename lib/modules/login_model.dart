class ShopLoginModel {
  bool? status;
  String? message;
  UserData? data;

  ShopLoginModel.fromJosn(Map<String, dynamic> josn) {
    status = josn['status'];
    message = josn['message'];
    data = josn['data'] != null ? UserData.fromJosn(josn['data']) : null ;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  /* UserData(this.id, this.name, this.email, this.phone, this.image, this.points,
      this.credit, this.token);*/

  UserData.fromJosn(Map<String, dynamic> josn) {
    id = josn['id'];
    name = josn['name'];
    email = josn['email'];
    phone = josn['phone'];
    image = josn['image'];
    points = josn['points'];
    credit = josn['credit'];
    token = josn['token'];
  }
}
