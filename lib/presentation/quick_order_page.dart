import 'package:buymed_test/bloc/quick_order_bloc.dart';
import 'package:buymed_test/model/product_category.dart';
import 'package:buymed_test/presentation/summary.dart';
import 'package:buymed_test/presentation/product_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuickOrderPage extends StatefulWidget {
  const QuickOrderPage({super.key});

  @override
  State<QuickOrderPage> createState() => _QuickOrderPageState();
}

class _QuickOrderPageState extends State<QuickOrderPage> {

  @override
  void initState() {
    super.initState();
    final bloc = context.read<QuickOrderBloc>();
    bloc.add(QuickOrderEvent.loadProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Order'),
      ),
      body: Column(
        spacing: 16,
        children: [
          _buildSearchBar(),
          _buildCategories(),
          _buildProductList(),
        ],
      ),
      bottomNavigationBar: QuickOrderSummary(),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<QuickOrderBloc, QuickOrderState>(
        buildWhen: (previous, current) => false,
        builder: (context, state) {
          return TextField(
            onTapOutside: (_) {
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              hintText: 'Search',
            ),
            onChanged: (value) {
              final bloc = context.read<QuickOrderBloc>();
              bloc.add(QuickOrderEvent.queryChanged(value));
            }
          );
        },
      ),
    );
  }

  Widget _buildCategories() {
    final List<ProductCategory?> categories = [
      null, ...ProductCategory.values
    ];

    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final category = categories[index];
          return BlocBuilder<QuickOrderBloc, QuickOrderState>(
            buildWhen: (p, c) =>
            p.category == category || c.category == category,
            builder: (context, state) {
              return FilterChip(
                selected: category == state.category,
                label: category == null ? const Text('All') : Text(
                    category.text),
                onSelected: (value) {
                  final bloc = context.read<QuickOrderBloc>();
                  bloc.add(QuickOrderEvent.categoryChanged(category));
                },
              );
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 16,);
        },

      ),
    );
  }

  Widget _buildProductList() {
    return Expanded(
      child: BlocBuilder<QuickOrderBloc, QuickOrderState>(
        buildWhen: (previous, current) =>
            !listEquals(previous.visibleProducts, current.visibleProducts),
        builder: (context, state) {
          final products = state.visibleProducts;
          if (products.isEmpty) {
            return _buildEmptyState();
          }
          return ListView.builder(
            itemCount: state.visibleProducts.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductItem(
                product: product,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text('No products found'),
    );
  }

}