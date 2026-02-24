import 'user_model.dart';

class ProductModel {
  final String? id;
  final String? name;
  final String? description;
  final num? price;
  final int? stock;
  final String? category;
  final String? image;
  final String? userId;
  final String? brand;
  final bool? isDiscounted;
  final num? discountPercent;
  final List<String>? tags;
  final bool? isActive;
  final num? weight;
  final List<String>? colors;
  final String? dimensions;
  final String? createdAt;
  final String? updatedAt;
  final UserModel? user;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stock,
    this.category,
    this.image,
    this.userId,
    this.brand,
    this.isDiscounted,
    this.discountPercent,
    this.tags,
    this.isActive,
    this.weight,
    this.colors,
    this.dimensions,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      stock: json['stock'],
      category: json['category'],
      image: json['image'],
      userId: json['userId'],
      brand: json['brand'],
      isDiscounted: json['isDiscounted'],
      discountPercent: json['discountPercent'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      isActive: json['isActive'],
      weight: json['weight'],
      colors: json['colors'] != null ? List<String>.from(json['colors']) : null,
      dimensions: json['dimensions'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'category': category,
      'image': image,
      'userId': userId,
      'brand': brand,
      'isDiscounted': isDiscounted,
      'discountPercent': discountPercent,
      'tags': tags,
      'isActive': isActive,
      'weight': weight,
      'colors': colors,
      'dimensions': dimensions,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'user': user?.toJson(),
    };
  }
}
