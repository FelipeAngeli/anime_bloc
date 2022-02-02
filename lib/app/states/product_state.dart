import 'package:anime_bloc/app/models/product_model.dart';

abstract class ProductState {
  const ProductState();
}

class EmptyProductState extends ProductState {}

class LoadingProductState extends ProductState {}

class ErrorProductState extends ProductState {
  final String message;

  const ErrorProductState(this.message);
}

class SuccessProductState extends ProductState {
  final List<ProductModel> products;

  const SuccessProductState(this.products);
}
