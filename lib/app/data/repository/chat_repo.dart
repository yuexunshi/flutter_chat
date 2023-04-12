import 'dart:convert';

import 'package:chat/app/models/chat_bean.dart';
import 'package:chat/app/models/model_list.dart';
import 'package:chat/app/utils/toast.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import '../../models/chat_model.dart';
import '../provider/constants.dart';

class ChatRepository {
  Future<ModelList?> getModels() async {
    var result = await get(
      '/models',
      decodeType: ModelList(),
    );
    result.when(
        success: (data) {
          return data;
        },
        failure: (String msg, int code) {});
    return null;
  }

  Future<List<ChatBean>> sendMessageGPT({required String message}) async {
    var result = await post('/chat/completions',
        data: jsonEncode({
          "model": aiModel,
          "messages": [
            {
              "role": "user",
              "content": message,
            }
          ]
        }),
        decodeType: ChatModel());

    List<ChatBean> chatList = [];

    result.when(success: (model) {
      model.choices?.forEach((element) {
        var content = element.message?.content;
        if (content?.isNotEmpty ?? false) {
          chatList.add(ChatBean(msg: content!, chatIndex: 1));
        }
      });
    }, failure: (msg, __) {
      showToast(msg);
    });

    return chatList;
  }
}
