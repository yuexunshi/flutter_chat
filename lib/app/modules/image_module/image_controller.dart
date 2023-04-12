import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../data/repository/image_repo.dart';

class ImageController extends GetxController {
  ImageRepository repository;

  ImageController({
    required this.repository,
  });

  final enable = false.obs;

  final List<String> _items = [];

  List<String> get items => _items;

  @override
  void onInit() {
    super.onInit();
    resetItems();
  }

  resetItems() {
    _items.clear();
    _items
        .add("https://n.sinaimg.cn/translate/20170404/35QX-fycxmks5593334.jpg");
  }

  Future getImage(String imageText) async {
    EasyLoading.show();
    var list = await repository.sendMessage(message: imageText);
    if (list.isEmpty) {
      resetItems();
    }else{
      _items.clear();
      _items.addAll(list);
    }
    EasyLoading.dismiss();
    update();
  }
}
