import 'package:chat/app/modules/translate_module/translate_controller.dart';
import 'package:get/get.dart';

import '../../data/repository/translate_repo.dart';
class TranslateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TranslateController( repository: TranslateRepository()));
  }
}