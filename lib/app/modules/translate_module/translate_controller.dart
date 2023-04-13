import 'dart:convert';

import 'package:chat/app/data/repository/translate_repo.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../models/language_bean.dart';

/// 翻译控制器类
class TranslateController extends GetxController {
  TranslateRepository repository; // 翻译数据仓库
  final currentLanguage =
      const LanguageBean(code: 'zh', name: 'Chinese', native: '中文').obs; // 当前语言
  final targetLanguage =
      const LanguageBean(code: 'ja', name: 'Japanese', native: '日本語')
          .obs; // 目标语言

  final List<LanguageBean> lugs = []; // 语言列表
  final result = ''.obs; // 翻译结果

  TranslateController({
    required this.repository,
  });

  /// 获取本地JSON文件中的语言列表数据
  Future<void> _getLocalJson() async {
    var result =
        jsonDecode(await rootBundle.loadString('assets/json/languages.json'));
    if (result is List) {
      var list = result.map((e) => LanguageBean.fromMap(e)).toList();
      lugs.clear();
      lugs.addAll(list);
    }
  }

  @override
  void onReady() async {
    super.onReady();
    EasyLoading.show(); // 显示加载动画
    await _getLocalJson(); // 获取本地JSON数据
    EasyLoading.dismiss(); // 隐藏加载动画
  }

  /// 清空翻译结果
  Future<void> clean() async {
    result.value = '';
  }

  /// 进行文本翻译
  Future<void> transition(String text) async {
    EasyLoading.show(); // 显示加载动画
    var res = await repository.translate(
        text, targetLanguage.value.name); // 调用翻译数据仓库进行翻译
    result.value = res; // 更新翻译结果
    EasyLoading.dismiss(); // 隐藏加载动画
  }

  /// 切换目标语言和当前语言
  Future<void> changeLanguage() async {
    var temp = targetLanguage.value;
    targetLanguage.value = currentLanguage.value;
    currentLanguage.value = temp;
  }

  /// 更改当前语言
  void changeCurrentLanguage(LanguageBean lan) {
    currentLanguage.value = lan;
  }

  /// 更改目标语言
  void changeTargetLanguage(LanguageBean lan) {
    targetLanguage.value = lan;
  }
}
