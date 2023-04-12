import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:chat/app/modules/translate_module/translate_controller.dart';
import '../../models/language_bean.dart';
import '../../utils/toast.dart';

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
            if (text.isNotEmpty) {
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

  Widget _resultCard() {
    return Card(
      margin: const EdgeInsets.only(top: 32),
      child: SizedBox(
        height: Get.size.height * .25,
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
                    iconSize: 22.0,
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: controller.result.trim()));
                      showToast("已经复制到剪切板");
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
                      controller.clean();
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

  Widget _inputCard() {
    return Card(
      margin: const EdgeInsets.only(top: 32),
      child: SizedBox(
        height: Get.size.height * .25,
        child: Column(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none),
                controller: _txtWord,
                maxLines: 6,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
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
                    iconSize: 22.0,
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: _txtWord.text.trim()));
                      showToast("已经复制到剪切板");
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
                      _txtWord.text = '';
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
    return Card(
      color: Get.theme.colorScheme.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PopupMenuButton<LanguageBean>(
              onSelected: (lan) {
                controller.changeCurrentLanguage(lan);
              },
              constraints: BoxConstraints(
                maxHeight: Get.height / 2,
                maxWidth: Get.width / 3,
              ),
              child: Row(
                children: [
                  Obx(() {
                    return CircleAvatar(
                      radius: 16,
                      child: Text(
                        controller.currentLanguage.value.code,
                      ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Obx(() {
                      return Text(
                        controller.currentLanguage.value.native,
                        style: TextStyle(
                          color: Get.theme.colorScheme.onTertiaryContainer,
                        ),
                      );
                    }),
                  ),
                  Transform.rotate(
                    angle: -pi / 2,
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 16.0,
                      color: Get.theme.colorScheme.onTertiaryContainer,
                    ),
                  )
                ],
              ),
              itemBuilder: (context) {
                return controller.lugs
                    .map((e) => PopupMenuItem<LanguageBean>(
                          value: e,
                          child: Text(e.name),
                        ))
                    .toList();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: InkWell(
                onTap: controller.changeLanguage,
                child: Icon(
                  Icons.swap_horiz_outlined,
                  size: 22.0,
                  color: Get.theme.colorScheme.onTertiaryContainer,
                ),
              ),
            ),
            PopupMenuButton<LanguageBean>(
              onSelected: (lan) {
                controller.changeTargetLanguage(lan);
                debugPrint('TranslatePage:_titleCard:${lan.native} ');
              },
              constraints: BoxConstraints(
                maxHeight: Get.height / 2,
                maxWidth: Get.width / 3,
              ),
              child: Row(
                children: [
                  Obx(() {
                    return CircleAvatar(
                      radius: 16,
                      child: Text(
                        controller.targetLanguage.value.code,
                      ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Obx(() {
                      return Text(
                        controller.targetLanguage.value.name,
                        style: TextStyle(
                          color: Get.theme.colorScheme.onTertiaryContainer,
                        ),
                      );
                    }),
                  ),
                  Transform.rotate(
                    angle: -pi / 2,
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 16.0,
                      color: Get.theme.colorScheme.onTertiaryContainer,
                    ),
                  )
                ],
              ),
              itemBuilder: (context) {
                return controller.lugs
                    .map((e) => PopupMenuItem<LanguageBean>(
                          value: e,
                          child: Text(e.name),
                        ))
                    .toList();
              },
            ),
          ],
        ),
      ),
    );
  }
}
