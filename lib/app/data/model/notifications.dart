// To parse this JSON data, do
//
//     final notifications = notificationsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Notifications notificationsFromJson(String str) => Notifications.fromJson(json.decode(str));

String notificationsToJson(Notifications data) => json.encode(data.toJson());

class Notifications {
    String status;
    List<Datum> data;

    Notifications({
        required this.status,
        required this.data,
    });

    factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
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
    String idUser;
    String title;
    String type;
    String from;
    String status;
    String idContent;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Datum({
        required this.id,
        required this.idUser,
        required this.title,
        required this.type,
        required this.from,
        required this.status,
        required this.idContent,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        idUser: json["id_user"],
        title: json["title"],
        type: json["type"],
        from: json["from"],
        status: json["status"],
        idContent: json["id_content"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "id_user": idUser,
        "title": title,
        "type": type,
        "from": from,
        "status": status,
        "id_content": idContent,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
