import 'package:app_tcc/service/dio_service.dart';
import 'package:dio/dio.dart';

class DioApiService implements DioServece {
  @override
  Dio getDio() {
    return Dio(
      BaseOptions(
        baseUrl: "http://127.0.0.1:3000",
        headers: {'context-type': 'application/json; charset=utf-8'},
      ),
    );
  }
}
