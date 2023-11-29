import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/todo_list_controller.dart';

class TodoListView extends GetView<TodoListController> {
  const TodoListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoListView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TodoListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
