import 'package:uuid/uuid.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  static const notSpecified = "__notspecified__";

  @override
  String toString() {
    return "{\nid: $id,\ntitle: $title,\ndescription: $description,\nprice:${price.toStringAsFixed(2)},\nimageUrl: $imageUrl\n}";
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "imageUrl": imageUrl,
      };

  Product.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        price = json["price"],
        description = json["description"],
        imageUrl = json["imageUrl"];

  Product.create()
      : id = const Uuid().v4(),
        title = "",
        description = "",
        price = 0.0,
        imageUrl = "";

  Product clone() {
    return Product(
      id: id,
      title: title,
      description: description,
      price: price,
      imageUrl: imageUrl,
    );
  }

  Product withValues({
    String title = notSpecified,
    String description = notSpecified,
    double? price,
    String imageUrl = notSpecified,
  }) {
    return Product(
      id: id,
      title: title == notSpecified ? this.title : title,
      description: description == notSpecified ? this.description : description,
      price: price ?? this.price,
      imageUrl: imageUrl == notSpecified ? this.imageUrl : imageUrl,
    );
  }
}
