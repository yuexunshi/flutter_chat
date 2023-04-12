import 'dart:convert';

import 'package:chat/app/models/chat_bean.dart';
import 'package:chat/app/models/model_list.dart';
import 'package:chat/app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nb_net/flutter_net.dart';

import '../../models/chat_model.dart';

class TranslateRepository {
  Future<String> sendMessage(String text, String language) async {
    var result = await post('/completions',
        data: jsonEncode({
          "model": "text-davinci-003",
          "prompt": "Translate the following Chinese text to $language : $text",
          "max_tokens": 300,
        }),
        decodeType: ChatModel());
    var msg = '';
    result.when(success: (model) {
      model.choices?.forEach((element) {
        if (element.text?.isNotEmpty ?? false) {
          msg += element.text!;
        }
      });
    }, failure: (msg, __) {
      showToast(msg);
    });
    return msg.trim();
  }
}
