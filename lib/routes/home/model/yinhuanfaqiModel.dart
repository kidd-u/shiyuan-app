class YinhuanfaqiModel {
  String name;
  List<Imgs> imgs;

  YinhuanfaqiModel({this.name, this.imgs});

  YinhuanfaqiModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['imgs'] != null) {
      imgs = new List<Imgs>();
      json['imgs'].forEach((v) {
        imgs.add(new Imgs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.imgs != null) {
      data['imgs'] = this.imgs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Imgs {
  String src;
  String msg;

  Imgs({this.src = '', this.msg = ''});

  Imgs.fromJson(Map<String, dynamic> json) {
    src = json['src'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['src'] = this.src;
    data['msg'] = this.msg;
    return data;
  }
}
