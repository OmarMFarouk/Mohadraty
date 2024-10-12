import 'package:flutter/material.dart';

class MySnackbar {
  static show({context, isError, msg}) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 4),
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(6)),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError ? Colors.red : Colors.green,
        content: Text(
          msg,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ));
}
