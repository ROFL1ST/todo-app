// To parse this JSON data, do
//
//     final friends = friendsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Friends friendsFromJson(String str) => Friends.fromJson(json.decode(str));

String friendsToJson(Friends data) => json.encode(data.toJson());

class Friends {
  String status;
  List<Datum> data;

  Friends({
    required this.status,
    required this.data,
  });

  factory Friends.fromJson(Map<String, dynamic> json) => Friends(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String username;
  String email;
  String name;
  String defaultColor;
  dynamic photoProfile;
  String status;
  String idUser;

  Datum({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.defaultColor,
    required this.photoProfile,
    required this.status,
    required this.idUser,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        name: json["name"],
        defaultColor: json["default_color"],
        photoProfile: json["photo_profile"],
        status: json["status"],
        idUser: json["id_user"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "name": name,
        "default_color": defaultColor,
        "photo_profile": photoProfile,
        "status": status,
        "id_user": idUser,
      };
}
