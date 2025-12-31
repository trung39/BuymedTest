part of 'quick_order_bloc.dart';

@freezed
abstract class QuickOrderState with _$QuickOrderState {
  const factory QuickOrderState({
    @Default('') String query,
    ProductCategory? category,
    @Default([]) List<Product> products, // all products, without filtered
    @Default({}) Map<int, int> orders,
  }) = _Initial;

  const QuickOrderState._();

  List<Product> get visibleProducts {
    return products.where((p) {
      final matchesSearch = query.isEmpty || p.name.toLowerCase().contains(query.toLowerCase());
      final matchesFilter = category == null || category == p.category;
      return matchesSearch && matchesFilter;
    }).toList();
  }

  int get totalSku => orders.length;

  int get totalItems => orders.values.fold(0, (previous, element) => previous + element);

  int get totalAmount {
    if (orders.isEmpty) return 0;
    return orders.keys.map((productId) {
      final product = products.firstWhere((p) => p.id == productId);
      return product.price * getQuantity(productId);
    }).reduce((value, element) => value + element);
  }

  int getQuantity(int productId) {
    return orders[productId] ?? 0;
  }

}
