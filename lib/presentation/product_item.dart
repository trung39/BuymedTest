import 'package:buymed_test/model/product.dart';
import 'package:buymed_test/model/product_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/quick_order_bloc.dart';

NumberFormat format = NumberFormat.currency(locale: 'vi');

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final name = product.name;
    final price = product.price;
    final category = product.category;
    return ListTile(
      leading: _buildLeadingByCategory(),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (product.isPrescription) prescriptionLabel(),
              Text(category.text),
            ],
          ),
          Text(
            format.format(price),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      trailing: BlocBuilder<QuickOrderBloc, QuickOrderState>(
        buildWhen: (_, _) => false,
        builder: (context, state) {
          final bloc = context.read<QuickOrderBloc>();
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  bloc.add(QuickOrderEvent.decrease(product.id));
                },
                visualDensity: VisualDensity.compact,
                icon: Icon(Icons.remove),
              ),
              _buildQuantity(),
              IconButton(
                onPressed: () {
                  bloc.add(QuickOrderEvent.increase(product.id));
                },
                visualDensity: VisualDensity.compact,
                icon: Icon(Icons.add),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget prescriptionLabel() {
    return RawChip(
      label: Text('Rx', style: TextStyle(fontSize: 12),),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      labelPadding: EdgeInsets.zero,
      padding: EdgeInsets.symmetric(horizontal: 6),
      backgroundColor: Colors.deepPurple.shade50,
    );
  }

  BlocBuilder<QuickOrderBloc, QuickOrderState> _buildQuantity() {
    return BlocBuilder<QuickOrderBloc, QuickOrderState>(
      buildWhen: (previous, current) =>
          previous.getQuantity(product.id) != current.getQuantity(product.id),
      builder: (context, state) {
        final quantity = state.getQuantity(product.id);
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Text('$quantity', style: TextStyle(fontSize: 16)),
        );
      },
    );
  }

  Widget _buildLeadingByCategory() {
    return switch (product.category) {
      ProductCategory.painRelief => Icon(Icons.sports_handball),
      ProductCategory.supplement => Icon(Icons.medication_outlined),
      ProductCategory.antibiotic => Icon(Icons.biotech),
      ProductCategory.allergy => Icon(Icons.sick_outlined),
    };
  }
}
