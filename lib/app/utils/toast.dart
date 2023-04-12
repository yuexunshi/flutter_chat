import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showToast(String message) {
  var context = Get.context;
  if (context != null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
