import 'dart:convert';

import 'package:chat/app/data/repository/translate_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../models/language_bean.dart';

class TranslateController extends GetxController {
  TranslateRepository repository;
  final currentLanguage =
      const LanguageBean(code: 'zh', name: 'Chinese', native: '中文').obs;
  final targetLanguage =
      const LanguageBean(code: 'ja', name: 'Japanese', native: '日本語').obs;

  final List<LanguageBean> lugs = [];
  final result = "".obs;

  TranslateController({
    required this.repository,
  });

  Future _getLocalJson() async {
    var result =
        jsonDecode(await rootBundle.loadString("assets/json/languages.json"));
    if (result is List) {
      var list = result.map((e) => LanguageBean.fromMap(e)).toList();
      lugs.clear();
      lugs.addAll(list);
    }
  }

  @override
  void onReady() async {
    super.onReady();
    EasyLoading.show();
    _getLocalJson();
    EasyLoading.dismiss();
  }

  Future<void> clean() async {
    result.value = '';
  }

  Future<void> transition(String text) async {
    EasyLoading.show();
    var res = await repository.sendMessage(text, targetLanguage.value.name);
    result.value = res;
    EasyLoading.dismiss();
  }

  /// 切换语言
  Future<void> changeLanguage() async {
    var temp = targetLanguage.value;
    targetLanguage.value = currentLanguage.value;
    currentLanguage.value = temp;
    debugPrint('TranslateController:changeTargetLanguage:${currentLanguage.value.native} ');

  }

  void changeCurrentLanguage(LanguageBean lan) {
    currentLanguage.value = lan;
    debugPrint('TranslateController:changeCurrentLanguage:${lan.native} ');
  }

  void changeTargetLanguage(LanguageBean lan) {
    targetLanguage.value = lan;
    debugPrint('TranslateController:changeTargetLanguage:${lan.native} ');
  }
}
