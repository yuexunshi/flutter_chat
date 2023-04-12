import 'package:chat/app/data/repository/chat_repo.dart';
import 'package:get/get.dart';
import '../../models/chat_bean.dart';

class ChatController extends GetxController {
  // Instance of ChatRepository
  ChatRepository repository;

  // Flag to track if user is typing or not
  bool _isTyping = false;

  // Getter for isTyping flag
  bool get isTyping => _isTyping;

  ChatController({
    required this.repository,
  });

  List<ChatBean> chatList = [];

  List<ChatBean> get getChatList {
    return chatList;
  }

  /// Method to add user message to chatList
  void addUserMessage({required String msg}) {
    _isTyping = true;
    chatList.add(ChatBean(msg: msg, chatIndex: 0));
    update();
  }

  /// Method to send user message to GPT model and get answers
  Future<void> sendMessageAndGetAnswers({required String msg}) async {
    chatList.addAll(await repository.sendMessageGPT(
      message: msg,
    ));
    _isTyping = false;
    update();
  }
}
