import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import '../../models/chat_model.dart';

class TranslateRepository {
  Future<String> translate(String text, String language) async {
    // 发起网络请求，使用post方法，并指定请求体的data参数为jsonEncode后的Map对象
    var result = await post('/completions',
        data: jsonEncode({
          "model": "text-davinci-003",
          "prompt": "Translate the following Chinese text to $language : $text",
          "max_tokens": 300,
        }),
        decodeType: ChatModel());
    var msg = '';
    // 处理请求结果
    result.when(
      success: (model) {
        // 遍历返回的ChatModel对象的choices列表，拼接文本
        model.choices?.forEach((element) {
          if (element.text?.isNotEmpty ?? false) {
            msg += element.text!;
          }
        });
      },
      failure: (msg, __) {
        // 请求失败时，弹出错误提示
        EasyLoading.showToast(msg);
      },
    );
    return msg.trim(); // 返回处理后的文本
  }
}
