import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:buymed_test/model/product_category.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.isPrescription,
  });

  final int id;
  final String name;
  final int price;
  final ProductCategory category;
  final bool isPrescription;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props => [id, name, price, category, isPrescription];

}

