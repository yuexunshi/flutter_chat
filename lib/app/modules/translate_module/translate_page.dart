import 'dart:math';

import 'package:chat/app/data/provider/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:chat/app/modules/translate_module/translate_controller.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/language_bean.dart';
import '../../widgets/drawer_widget.dart';

class TranslatePage extends GetView<TranslateController> {
  TranslatePage({super.key});

  final _txtWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      onVerticalDragDown: (_) => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Translate')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _titleCard(),
              _inputCard(),
              _resultCard(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            var text = _txtWord.text.trim();
            if (GetStorage().read<String>(StoreKey.API)?.isEmpty ?? true) {
              showApiDialog();
            } else if (text.isNotEmpty) {
              controller.transition(text);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Please type a message",
                  ),
                ),
              );
            }
          },
          label: const Text('Translate'),
          icon: const Icon(Icons.translate),
        ),
      ),
    );
  }

  /// 定义输入框卡片小部件
  Widget _inputCard() {
    // 返回一个卡片小部件
    return Card(
      margin: const EdgeInsets.only(top: 32), // 设置卡片的上边距
      child: SizedBox(
        height: Get.size.height * .25, // 设置卡片的高度为屏幕高度的 0.25 倍
        child: Column(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(12),
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                controller: _txtWord,
                // 绑定文本输入框的控制器
                maxLines: 6,
                // 设置最大可显示的行数为 6
                textInputAction: TextInputAction.newline,
                // 设置输入动作为换行
                keyboardType: TextInputType.multiline, // 设置键盘类型为多行文本
              ),
            ),
            const Divider(
              thickness: 1, // 设置分隔线的粗细
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              // 设置操作按钮的水平内边距
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // 设置按钮的对齐方式为末尾对齐
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    color: Get.theme.colorScheme.onSurface,
                    iconSize: 22.0,
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                          text: _txtWord.text.trim())); // 复制输入框中的文本到剪贴板
                      EasyLoading.showToast("已经复制到剪切板"); // 显示一个 Toast 提示
                    },
                    icon: const Icon(
                      Icons.copy_outlined,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    color: Get.theme.colorScheme.onSurface,
                    iconSize: 22.0,
                    onPressed: () {
                      _txtWord.text = ''; // 清空输入框中的文本
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 定义结果卡片小部件
  Widget _resultCard() {
    // 返回一个卡片小部件
    return Card(
      margin: const EdgeInsets.only(top: 32), // 设置卡片的上边距
      child: SizedBox(
        height: Get.size.height * .25, // 设置卡片的高度为屏幕高度的 0.25 倍
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: Obx(() {
                  return Text(
                    controller.result.value,
                    textAlign: TextAlign.left,
                    style: Get.theme.textTheme.bodyLarge,
                    // maxLines: 6,
                  );
                }),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    color: Get.theme.colorScheme.onSurface,
                    // 使用 GetX 状态管理库中的颜色样式
                    iconSize: 22.0,
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                          text: controller.result.trim())); // 复制结果文本到剪贴板
                      EasyLoading.showToast("已经复制到剪切板");
                    },
                    icon: const Icon(
                      Icons.copy_outlined,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    color: Get.theme.colorScheme.onSurface,
                    iconSize: 22.0,
                    onPressed: () {
                      controller.clean(); // 清空结果
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _titleCard() {
    final colorScheme = Get.theme.colorScheme;
    Widget buildLanguageItem(Rx<LanguageBean> language) {
      return Row(
        children: [
          CircleAvatar(
            radius: 16,
            child: Obx(() {
              return Text(
                language.value.code,
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Obx(() {
              return Text(
                language.value.native,
                style: TextStyle(
                  color: colorScheme.onTertiaryContainer,
                ),
              );
            }),
          ),
          Transform.rotate(
            angle: -pi / 2,
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 16.0,
              color: colorScheme.onTertiaryContainer,
            ),
          )
        ],
      );
    }

    Widget buildPopMenu(
        {required Rx<LanguageBean> language,
        required PopupMenuItemSelected<LanguageBean> onSelected}) {
      return PopupMenuButton<LanguageBean>(
        onSelected: onSelected,
        constraints: BoxConstraints(
          maxHeight: Get.height / 2,
          maxWidth: Get.width / 3,
        ),
        child: buildLanguageItem(language),
        itemBuilder: (context) {
          return controller.lugs
              .map((e) => PopupMenuItem<LanguageBean>(
                    value: e,
                    child: Text(e.name),
                  ))
              .toList();
        },
      );
    }

    return Card(
      color: colorScheme.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildPopMenu(
                language: controller.currentLanguage,
                onSelected: (LanguageBean value) {
                  controller.changeCurrentLanguage(value);
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: InkWell(
                onTap: controller.changeLanguage,
                child: Icon(
                  Icons.swap_horiz_outlined,
                  size: 22.0,
                  color: colorScheme.onTertiaryContainer,
                ),
              ),
            ),
            buildPopMenu(
                language: controller.targetLanguage,
                onSelected: (LanguageBean value) {
                  controller.changeTargetLanguage(value);
                }),
          ],
        ),
      ),
    );
  }
}
