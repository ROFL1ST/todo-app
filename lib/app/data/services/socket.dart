// web_socket_controller.dart
// ignore_for_file: avoid_print

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:todo_app/app/controller/global_controller.dart';
import 'package:jwt_decode/jwt_decode.dart';

class WebSocketController extends GetxController with WidgetsBindingObserver {
  IO.Socket? socket;
  var global = Get.put(GlobalController());
  final storage = GetStorage();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  void connectWebSocket() async {
    // Replace 'http://your_socket_server_url' with the actual WebSocket server URL
    IO.Socket socket = IO.io(global.url, <String, dynamic>{
      "transports": ["websocket"]
    });
    socket.onConnect((data) {
      socket.emit("online", Jwt.parseJwt(storage.read("token")!)["id"]);
      print("connect");
    });
    socket.onConnectError((data) => print("error $data"));
    socket.onDisconnect((data) {
      socket.emit("offline", Jwt.parseJwt(storage.read("token")!)["id"]);
    });
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    socket?.emit("offline", Jwt.parseJwt(storage.read("token")!)["id"]);
    socket?.disconnect();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      // Disconnect the socket when the app is paused or detached
      socket?.emit("offline", Jwt.parseJwt(storage.read("token")!)["id"]);
      socket?.disconnect();
    }
    if (state == AppLifecycleState.resumed) {
      socket?.emit("online", Jwt.parseJwt(storage.read("token")!)["id"]);
    }
  }
}
