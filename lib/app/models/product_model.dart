class ProductModel {
  final int id;
  final String date;
  final String title;

  ProductModel({required this.id, required this.date, required this.title});

  static ProductModel fromJson(map) {
    return ProductModel(
      id: map['id'],
      date: map['date'],
      title: map['title']['rendered'],
    );
  }
}
