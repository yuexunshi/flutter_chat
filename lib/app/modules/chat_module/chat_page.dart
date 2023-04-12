import 'package:chat/app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:chat/app/modules/chat_module/chat_controller.dart';
import '../../routes/app_pages.dart';
import '../../widgets/chat_widget.dart';
import '../../widgets/text_widget.dart';

class ChatPage extends GetView<ChatController> {
  ChatPage({super.key});

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController _listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(builder: (logic) {
      return Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'ChatGPT',
          ),
          actions: <Widget>[
            // IconButton(
            //   onPressed: () async {
            //     await controller.getModels();
            //   },
            //   icon: const Icon(Icons.more_vert_rounded),
            // ),
            IconButton(
              onPressed: () async {
                Get.toNamed(Routes.TRANSLATE);
              },
              icon: const Icon(Icons.translate),
            ),
            IconButton(
              onPressed: () async {
                Get.toNamed(Routes.IMAGE);
              },
              icon: const Icon(Icons.image),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                    controller: _listScrollController,
                    itemCount: controller.getChatList.length, //chatList.length,
                    itemBuilder: (context, index) {
                      return ChatWidget(
                        msg: controller
                            .getChatList[index].msg, // chatList[index].msg,
                        chatIndex: controller.getChatList[index]
                            .chatIndex, //chatList[index].chatIndex,
                        shouldAnimate:
                            controller.getChatList.length - 1 == index,
                      );
                    }),
              ),
              if (controller.isTyping)
                SpinKitThreeBounce(
                  color: Get.theme.colorScheme.secondary,
                  size: 18,
                ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  color: Get.theme.colorScheme.primaryContainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          focusNode: focusNode,
                          controller: textEditingController,
                          onSubmitted: (value) async {
                            await _sendMessage();
                          },
                          decoration: InputDecoration.collapsed(
                              hintText: "How can I help you",
                              hintStyle: TextStyle(
                                color: Get.theme.colorScheme.onPrimaryContainer,
                              )),
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            await _sendMessage();
                          },
                          icon: Icon(
                            Icons.send,
                            color: Get.theme.colorScheme.onPrimaryContainer,
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void scrollListToEND() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut);
  }

  Future<void> _sendMessage() async {
    if (controller.isTyping) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "You cant send multiple messages at a time",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "Please type a message",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    String msg = textEditingController.text;
    textEditingController.clear();
    focusNode.unfocus();
    controller.addUserMessage(msg: msg);
    await controller.sendMessageAndGetAnswers(msg: msg);
    scrollListToEND();
  }
}
