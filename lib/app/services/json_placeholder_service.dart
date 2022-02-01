import 'package:anime_bloc/app/models/product_model.dart';
import 'package:anime_bloc/app/services/http_client_interface.dart';

const url =
    'https://www.intoxianime.com/?rest_route=/wp/v2/posts&page=1&per_page=10';

class JsonPlaceholderService {
  final IhttpClient client;

  JsonPlaceholderService(this.client);

  Future<List<ProductModel>> getTodos() async {
    final body = await client.get(url);
    return (body as List).map(ProductModel.fromJson).toList();
  }
}
