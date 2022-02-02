import 'package:anime_bloc/app/blocs/product_bloc.dart';
import 'package:anime_bloc/app/events/product_events.dart';
import 'package:anime_bloc/app/services/product_service.dart';
import 'package:anime_bloc/app/states/product_state.dart';

import 'package:flutter/material.dart';

class HomeBlocPage extends StatefulWidget {
  const HomeBlocPage({Key? key}) : super(key: key);

  @override
  State<HomeBlocPage> createState() => _HomePageState();
}

class _HomePageState extends State<HomeBlocPage> {
  final bloc = ProductBloc(ProducService(DioClient()));

  @override
  void initState() {
    super.initState();
    bloc.stream.listen((event) {});

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      bloc.add(FetchProductEvents());
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Container();
    final state = bloc.state;

    if (state is EmptyProductState) {
      child = const Center(
        child: Text('Sem Produtos'),
      );
    }
    if (state is LoadingProductState) {
      child = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is ErrorProductState) {
      child = Center(
        child: Text(state.message),
      );
    }
    if (state is SuccessProductState) {
      child = ListView.builder(
        itemCount: state.products.length,
        itemBuilder: (_, index) {
          final product = state.products[index];
          return ListTile(
            title: Text(product.title),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
      ),
      body: child,
      floatingActionButton: FloatingActionButton(onPressed: () {
        bloc.add(FetchProductEvents());
      }),
    );
  }
}
