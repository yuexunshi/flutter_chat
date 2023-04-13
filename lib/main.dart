import 'package:chat/app/data/provider/constants.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'app/data/provider/auth_interceptor.dart';
import 'app/theme/color_schemes.g.dart';

void main() async {
  NetOptions.instance
      .setBaseUrl(baseUrl)
      .addHeaders({
        // 'Authorization': 'Bearer aiApiKey',
        "Content-Type": "application/json"
      })
      .addInterceptor(AuthInterceptor())
      .setConnectTimeout(const Duration(milliseconds: 5000))
      .create();
  await GetStorage.init();
  // GetStorage().write(StoreKey.API, aiApiKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        themeMode:ThemeMode.dark,
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        title: 'Flutter ChatBOT',
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.CHAT,
        getPages: AppPages.pages,
        builder: EasyLoading.init());
  }
}
