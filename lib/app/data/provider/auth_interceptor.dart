import 'package:chat/app/data/provider/constants.dart';
import 'package:flutter_nb_net/flutter_net.dart';
import 'package:get_storage/get_storage.dart';

class AuthInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 从本地缓存中取出 Token
    String api = GetStorage().read(StoreKey.API);
    if (api.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $api';
    }
    return super.onRequest(options, handler);
  }
}