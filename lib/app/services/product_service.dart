import 'package:anime_bloc/app/services/http_client_interface.dart';
import 'package:dio/dio.dart';

class DioClient implements IhttpClient {
  final Dio dio = Dio();
  @override
  Future<dynamic> get(String url) async {
    final response = await dio.get(url);
    return response.data;
  }
}
