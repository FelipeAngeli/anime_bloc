import 'package:anime_bloc/app/services/product_service.dart';
import 'package:anime_bloc/app/states/product_state.dart';
import 'package:anime_bloc/app/stores/product_store.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = ProductStore(ProducService(DioClient()));

  @override
  void initState() {
    super.initState();
    store.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      store.fetchProducts();
    });
  }

  // @override
  // void completedBuild() {
  //   store.fetchProducts();
  // }

  @override
  Widget build(BuildContext context) {
    Widget child = Container();
    final state = store.value;

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
            title: Text(product.date),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
      ),
      body: child,
    );
  }
}

// mixin OnCompleteBuild on State<StatefulWidget> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
//       completedBuild();
//     });
//   }

//   void completedBuild();
// }
