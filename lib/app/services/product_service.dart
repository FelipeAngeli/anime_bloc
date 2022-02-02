import 'package:anime_bloc/app/models/product_model.dart';
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

class ProducService {
  final DioClient client;

  ProducService(this.client);

  Future<List<ProductModel>> fetchProducts() async {
    const url =
        'https://www.intoxianime.com/?rest_route=/wp/v2/posts&page=1&per_page=10';
    final response = await client.get(url);

    final products = <ProductModel>[];

    for (var data in response) {
      final product = ProductModel.fromJson(data);
      products.add(product);
    }
    return products;
  }
}
