import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../generated/assets.dart';
import '../utils/toast.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget(
      {super.key,
      required this.msg,
      required this.chatIndex,
      this.shouldAnimate = false});

  final String msg;
  final int chatIndex;
  final bool shouldAnimate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: chatIndex == 0
              ? UserChatView(
                  msg: msg,
                )
              : AiChatView(msg: msg, shouldAnimate: shouldAnimate),
        ),
      ],
    );
  }
}

class UserChatView extends StatelessWidget {
  const UserChatView({Key? key, required this.msg}) : super(key: key);

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 40.0),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Text(
                msg,
                style: TextStyle(
                  color: Get.theme.colorScheme.onSecondaryContainer,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        const CircleAvatar(
          backgroundImage: AssetImage(Assets.imagesPerson),
          radius: 16.0,
        )
      ],
    );
  }
}

class AiChatView extends StatelessWidget {
  const AiChatView({super.key, required this.msg, required this.shouldAnimate});

  final String msg;
  final bool shouldAnimate;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage(Assets.imagesOpenaiLogo),
          radius: 16.0,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: shouldAnimate
                ? InkWell(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: msg.trim()));
                      showToast("已经复制到剪切板");
                    },
                    child: DefaultTextStyle(
                      style: TextStyle(
                          color: Get.theme.colorScheme.onTertiaryContainer,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                      child: AnimatedTextKit(
                          isRepeatingAnimation: false,
                          repeatForever: false,
                          displayFullTextOnTap: true,
                          totalRepeatCount: 1,
                          animatedTexts: [
                            TyperAnimatedText(
                              msg.trim(),
                            ),
                          ]),
                    ),
                  )
                : SelectableText(
                    msg.trim(),
                    style: TextStyle(
                        color: Get.theme.colorScheme.onTertiaryContainer,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
          ),
        ),
        const SizedBox(width: 40.0),
      ],
    );
  }
}
