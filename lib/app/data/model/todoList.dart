// To parse this JSON data, do
//
//     final todoList = todoListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TodoList todoListFromJson(String str) => TodoList.fromJson(json.decode(str));

String todoListToJson(TodoList data) => json.encode(data.toJson());

class TodoList {
  String status;
  List<Datum> data;

  TodoList({
    required this.status,
    required this.data,
  });

  factory TodoList.fromJson(Map<String, dynamic> json) => TodoList(
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
  List<Sublist> sublist;
  List<Chat> chat;

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
    required this.sublist,
    required this.chat,
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
        sublist: json.containsKey("sublist")
            ? List<Sublist>.from(
                json["sublist"].map((x) => Sublist.fromJson(x)))
            : [],
        chat: List<Chat>.from(json["chat"].map((x) => Chat.fromJson(x))),
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
        "sublist": List<dynamic>.from(sublist.map((x) => x.toJson())),
        "chat": List<dynamic>.from(chat.map((x) => x.toJson())),
      };
}

class Chat {
  String id;
  String idTodoList;
  String roomCode;
  int v;

  Chat({
    required this.id,
    required this.idTodoList,
    required this.roomCode,
    required this.v,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"],
        idTodoList: json["id_todoList"],
        roomCode: json["room_code"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id_todoList": idTodoList,
        "room_code": roomCode,
        "__v": v,
      };
}

class Sublist {
  String id;
  String idUser;
  String idTodoList;
  String name;
  int checked;
  int v;

  Sublist({
    required this.id,
    required this.idUser,
    required this.idTodoList,
    required this.name,
    required this.checked,
    required this.v,
  });

  factory Sublist.fromJson(Map<String, dynamic> json) => Sublist(
        id: json["_id"],
        idUser: json["id_user"],
        idTodoList: json["id_todoList"],
        name: json["name"],
        checked: json["checked"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id_user": idUser,
        "id_todoList": idTodoList,
        "name": name,
        "checked": checked,
        "__v": v,
      };
}
