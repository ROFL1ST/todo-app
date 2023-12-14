// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Todo todoFromJson(String str) => Todo.fromJson(json.decode(str));

String todoToJson(Todo data) => json.encode(data.toJson());

class Todo {
    String status;
    List<Datum> data;

    Todo({
        required this.status,
        required this.data,
    });

    factory Todo.fromJson(Map<String, dynamic> json) => Todo(
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
    String name;
    String percent;
    String description;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    List<Todolist> todolists;
    List<User> user;

    Datum({
        required this.id,
        required this.idUser,
        required this.name,
        required this.percent,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.todolists,
        required this.user,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        idUser: json["id_user"],
        name: json["name"],
        percent: json["percent"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        todolists: List<Todolist>.from(json["todolists"].map((x) => Todolist.fromJson(x))),
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "id_user": idUser,
        "name": name,
        "percent": percent,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "todolists": List<dynamic>.from(todolists.map((x) => x.toJson())),
        "user": List<dynamic>.from(user.map((x) => x.toJson())),
    };
}

class Todolist {
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

    Todolist({
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

    factory Todolist.fromJson(Map<String, dynamic> json) => Todolist(
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

class User {
    String id;
    String idTodo;
    String idUser;
    String role;
    int v;
    String username;
    String email;
    String name;
    bool isVerified;
    String defaultColor;
    dynamic photoProfile;
    String status;

    User({
        required this.id,
        required this.idTodo,
        required this.idUser,
        required this.role,
        required this.v,
        required this.username,
        required this.email,
        required this.name,
        required this.isVerified,
        required this.defaultColor,
        required this.photoProfile,
        required this.status,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        idTodo: json["id_todo"],
        idUser: json["id_user"],
        role: json["role"],
        v: json["__v"],
        username: json["username"],
        email: json["email"],
        name: json["name"],
        isVerified: json["isVerified"],
        defaultColor: json["default_color"],
        photoProfile: json["photo_profile"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "id_todo": idTodo,
        "id_user": idUser,
        "role": role,
        "__v": v,
        "username": username,
        "email": email,
        "name": name,
        "isVerified": isVerified,
        "default_color": defaultColor,
        "photo_profile": photoProfile,
        "status": status,
    };
}
