part of 'quick_order_bloc.dart';

@freezed
class QuickOrderEvent with _$QuickOrderEvent {
  const factory QuickOrderEvent.loadProduct() = _LoadProduct;
  const factory QuickOrderEvent.queryChanged(String query) = _QueryChanged;
  const factory QuickOrderEvent.categoryChanged(ProductCategory? category) = _CategoryChanged;
  const factory QuickOrderEvent.increase(int productId) = _Increase;
  const factory QuickOrderEvent.decrease(int productId) = _Decrease;
  const factory QuickOrderEvent.setQuantity(int productId, int quantity) = _SetQuantity;

}
