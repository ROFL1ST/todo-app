// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditModal extends StatefulWidget {
  const EditModal({super.key});

  @override
  State<EditModal> createState() => _EditModalState();
}

class _EditModalState extends State<EditModal> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Edit Item'),
      content: Column(
        children: [
          Text('Edit your item name:'),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: CupertinoTextField(
              placeholder: 'Enter item name',
              // You can add controllers, validators, etc., based on your needs
            ),
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Save'),
          onPressed: () {
            // Handle save action
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
