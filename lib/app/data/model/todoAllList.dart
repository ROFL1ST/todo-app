// To parse this JSON data, do
//
//     final todoAllList = todoAllListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TodoAllList todoAllListFromJson(String str) => TodoAllList.fromJson(json.decode(str));

String todoAllListToJson(TodoAllList data) => json.encode(data.toJson());

class TodoAllList {
    String status;
    List<Datum> data;

    TodoAllList({
        required this.status,
        required this.data,
    });

    factory TodoAllList.fromJson(Map<String, dynamic> json) => TodoAllList(
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
    String idTodo;
    String idUser;
    String name;
    String status;
    String priority;
    DateTime start;
    DateTime end;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Datum({
        required this.id,
        required this.idTodo,
        required this.idUser,
        required this.name,
        required this.status,
        required this.priority,
        required this.start,
        required this.end,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        idTodo: json["id_todo"],
        idUser: json["id_user"],
        name: json["name"],
        status: json["status"],
        priority: json["priority"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "id_todo": idTodo,
        "id_user": idUser,
        "name": name,
        "status": status,
        "priority": priority,
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
