import 'package:anime_bloc/app/events/product_events.dart';
import 'package:anime_bloc/app/services/product_service.dart';
import 'package:anime_bloc/app/states/product_state.dart';
import 'package:bloc/bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProducService service;
  ProductBloc(this.service) : super(EmptyProductState()) {
    on<FetchProductEvents>(_fetchProducts);
    on<ClearProductEvents>((event, emit) {
      emit(const SuccessProductState([]));
      //emit(EmptyProductState());
    });
  }

  Future<void> _fetchProducts(
      FetchProductEvents events, Emitter<ProductState> emit) async {
    emit(LoadingProductState());
    try {
      await Future.delayed(const Duration(seconds: 2)); //delay
      final products = await service.fetchProducts();
      emit(SuccessProductState(products));
    } catch (e) {
      emit(ErrorProductState(e.toString()));
    }
  }
}
