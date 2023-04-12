import 'package:chat/app/data/repository/chat_repo.dart';
import 'package:chat/app/modules/chat_module/chat_controller.dart';
import 'package:get/get.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController(repository: ChatRepository()));
  }
}
