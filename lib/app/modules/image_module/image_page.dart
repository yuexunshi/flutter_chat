import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat/app/modules/image_module/image_controller.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/provider/constants.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/expand_card.dart';

class ImagePage extends GetView<ImageController> {
  final TextEditingController _imageTextController = TextEditingController();

  ImagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Image Generator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Get.theme.colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      controller: _imageTextController,
                      onChanged: (text) {
                        // 当文本输入框的文本变化时，调用 ImageController 的方法更新状态
                        controller.enable.value = text.trim().isNotEmpty;
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Image to generate',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Obx(() {
                  return ElevatedButton(
                    onPressed: controller.enable.value
                        ? () async {
                            // 当按钮被点击时，调用 ImageController 的方法生成图片
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (GetStorage()
                                    .read<String>(StoreKey.API)
                                    ?.isEmpty ??
                                true) {
                              showApiDialog();
                            } else {
                              await controller.getImage(
                                _imageTextController.text.trim(),
                              );
                            }
                          }
                        : null,
                    child: const Text('Create'),
                  );
                })
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: GetBuilder<ImageController>(builder: (logic) {
                return ExpandingCards(
                  height: 400,
                  items: controller.items,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
