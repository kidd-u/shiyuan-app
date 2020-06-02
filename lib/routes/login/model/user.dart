import 'dart:convert';
class UserToken {
  String jwt;
  List<String> perms;

  UserToken({this.jwt, this.perms});

  UserToken.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'];
    perms = json['perms'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    var content = utf8.encode(this.jwt);
    var digest = base64Encode(content);
    data['jwt'] = digest;
    data['perms'] = this.perms;
    return data;
  }
}
