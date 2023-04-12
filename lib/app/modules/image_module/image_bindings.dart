import 'package:chat/app/modules/image_module/image_controller.dart';
import 'package:get/get.dart';

import '../../data/repository/image_repo.dart';

class ImageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImageController(repository:ImageRepository(),  ));
  }
}