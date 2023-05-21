import 'package:app_tcc/service/dio_service.dart';
import 'package:dio/dio.dart';

class DioApiService implements DioServece {
  @override
  Dio getDio() {
    return Dio(
      BaseOptions(
        baseUrl: "https://doarseapi.onrender.com",
        headers: {'context-type': 'application/json; charset=utf-8'},
      ),
    );
  }
}
