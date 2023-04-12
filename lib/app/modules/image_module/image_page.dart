import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat/app/modules/image_module/image_controller.dart';

import '../../widgets/expand_card.dart';

class ImagePage extends GetView<ImageController> {
  final TextEditingController _imageTextController = TextEditingController();

  ImagePage({super.key});

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
                      FocusScope.of(context).requestFocus(FocusNode());
                      await controller.getImage(
                              _imageTextController.text.trim(),
                            );
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
