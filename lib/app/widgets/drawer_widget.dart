import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../generated/assets.dart';
import '../data/provider/constants.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "北海道浪子",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Get.theme.colorScheme.onInverseSurface,
              ),
            ),
            accountEmail: Text(
              "xxx@gmail.com",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Get.theme.colorScheme.onInverseSurface,
              ),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage(Assets.imagesOpenaiLogo),
              radius: 16.0,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.api,
            ),
            title: const Text('API Setting'),
            onTap: () {
              showApiDialog();
              // Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
            ),
            title: const Text('Logout'),
            onTap: () {
              GetStorage().erase();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }


}

void showApiDialog() {
  String newName = '';
  Get.defaultDialog(
      title: 'API Setting',
      content: TextField(
        // display the current name of the conversation
        decoration: InputDecoration(
          hintText: GetStorage().read(StoreKey.API) ?? 'Enter API Key',
        ),
        onChanged: (value) {
          newName = value;
        },
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          child: const Text(
            'Save',
            style: TextStyle(
              color: Color(0xff55bb8e),
            ),
          ),
          onPressed: () {
            if (newName == '') {
              Get.back();
              return;
            }
            GetStorage().write(StoreKey.API, newName);
            Get.back();
          },
        ),
      ]);
}