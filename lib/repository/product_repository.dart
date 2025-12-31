
import 'dart:convert';

import 'package:buymed_test/model/product.dart';

class ProductRepository {
  List<Product> getProducts() {
    final jsonList = jsonDecode(productJson) as List<dynamic>;
    return jsonList.map((product) => Product.fromJson(product)).toList();
  }
}

const String productJson = r'''
[
   { "id": 1, "name": "Paracetamol 500mg", "price": 15000, "category": "painRelief", "isPrescription": false },
   { "id": 2, "name": "Amoxicillin 500mg", "price": 45000, "category": "antibiotic", "isPrescription": true },
   { "id": 3, "name": "Vitamin C 1000mg", "price": 30000, "category": "supplement", "isPrescription": false },
   { "id": 4, "name": "Cetirizine 10mg", "price": 20000, "category": "allergy", "isPrescription": false }
]
''';
