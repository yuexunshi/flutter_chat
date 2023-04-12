import 'dart:convert';

import 'package:chat/app/models/chat_bean.dart';
import 'package:chat/app/models/image_model.dart';
import 'package:chat/app/models/model_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';

import '../../models/chat_model.dart';

class ImageRepository {
  Future<List<String>> sendMessage({
    required String message,
  }) async {
    var result = await post<ImageModel, ImageModel>('/images/generations',
        data: jsonEncode({
          "prompt": message,
          "n": 4,
          "size": "256x256",
        }),
        decodeType: ImageModel());
    List<String> list = [];
    result.when(
        success: (model) {
          model.data?.forEach((element) {
            var url = element.url;
            if (url?.isNotEmpty ?? false) {
              list.add(url!);
            }
          });
        },
        failure: (_, __) {});
    return list;
  }
}
