import 'package:anime_bloc/app/services/product_service.dart';
import 'package:anime_bloc/app/states/product_state.dart';
import 'package:flutter/cupertino.dart';

class ProductStore extends ValueNotifier<ProductState> {
  final ProducService service;
  ProductStore(this.service) : super(EmptyProductState());

  Future<void> fetchProducts() async {
    value = LoadingProductState();
    try {
      await Future.delayed(const Duration(seconds: 2)); //delay
      final products = await service.fetchProducts();
      value = SuccessProductState(products);
    } catch (e) {
      value = ErrorProductState(e.toString());
    }
  }
}
