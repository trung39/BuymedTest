import 'dart:async';

import 'package:buymed_test/model/product.dart';
import 'package:buymed_test/model/product_category.dart';
import 'package:buymed_test/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'quick_order_event.dart';
part 'quick_order_state.dart';
part 'quick_order_bloc.freezed.dart';

class QuickOrderBloc extends Bloc<QuickOrderEvent, QuickOrderState> {
  final ProductRepository repository;
  QuickOrderBloc(this.repository) : super(const QuickOrderState()) {
    on<_LoadProduct>(_onLoadProduct);
    on<_QueryChanged>(_onQueryChanged, transformer: debounce(const Duration(milliseconds: 500)));
    on<_CategoryChanged>(_onCategoryChanged);
    on<_Increase>(_onIncrease);
    on<_Decrease>(_onDecrease);
  }

  FutureOr<void> _onLoadProduct(_LoadProduct event, Emitter<QuickOrderState> emit) {
    final products = repository.getProducts();
    emit(state.copyWith(products: products,));
  }

  FutureOr<void> _onQueryChanged(_QueryChanged event, Emitter<QuickOrderState> emit) {
    final query = event.query;
    emit(state.copyWith(query: query));
  }

  FutureOr<void> _onCategoryChanged(_CategoryChanged event, Emitter<QuickOrderState> emit) {
    final category = event.category;
    emit(state.copyWith(category: category));
  }

  Future<void> _onIncrease(_Increase event, Emitter<QuickOrderState> emit) async {
    final productId = event.productId;
    final orders = Map.of(state.orders);

    final quantity = orders[productId] ?? 0;
    if (quantity == 99) return;

    orders[productId] = quantity + 1;
    emit(state.copyWith(orders: orders));
  }

  Future<void> _onDecrease(_Decrease event, Emitter<QuickOrderState> emit) async {
    final productId = event.productId;
    final orders = Map.of(state.orders);

    final quantity = orders[productId] ?? 0;
    if (quantity <= 0) return;

    orders[productId] = quantity - 1;
    if (orders[productId] == 0) {
      orders.remove(productId);
    }
    emit(state.copyWith(orders: orders));
  }

}

/// Transform debounce events for a given [duration].
EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}
