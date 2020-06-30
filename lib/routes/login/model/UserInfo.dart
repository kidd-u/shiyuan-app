class UserInfoModel {
  String phone;
  Depart depart;
  Depart job;
  String name;
  int id;

  UserInfoModel({this.phone, this.depart, this.job, this.name, this.id});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    depart =
    json['depart'] != null ? new Depart.fromJson(json['depart']) : null;
    job = json['job'] != null ? new Depart.fromJson(json['job']) : null;
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    if (this.depart != null) {
      data['depart'] = this.depart.toJson();
    }
    if (this.job != null) {
      data['job'] = this.job.toJson();
    }
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class Depart {
  String name;
  int id;

  Depart({this.name, this.id});

  Depart.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
