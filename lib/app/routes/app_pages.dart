import '../../app/modules/translate_module/translate_page.dart';
import '../../app/modules/translate_module/translate_bindings.dart';
import '../../app/modules/image_module/image_page.dart';
import '../../app/modules/image_module/image_bindings.dart';
import '../../app/modules/chat_module/chat_bindings.dart';
import '../../app/modules/chat_module/chat_page.dart';
import 'package:get/get.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.CHAT,
      page: () => ChatPage(),
      binding: ChatBinding(),
    ),

    GetPage(
      name: Routes.IMAGE,
      page: () => ImagePage(),
      binding: ImageBinding(),
    ),
    GetPage(
      name: Routes.TRANSLATE,
      page: () => TranslatePage(),
      binding: TranslateBinding(),
    ),
  ];
}
