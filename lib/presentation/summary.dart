import 'package:buymed_test/bloc/quick_order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

NumberFormat format = NumberFormat.decimalPattern('vi_VN');

class QuickOrderSummary extends StatelessWidget {
  const QuickOrderSummary({super.key});

  static final _numberStyle = TextStyle(fontSize: 20);
  static final _priceStyle = TextStyle(
    fontSize: 20,
    color: Colors.deepPurple,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(8),
        height: 80,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(flex: 2, child: _buildSKUs()),
                VerticalDivider(),
                Expanded(flex: 2, child: _buildQuantity()),
                VerticalDivider(),
                Expanded(flex: 3, child: _buildAmount()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSKUs() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Item'),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<QuickOrderBloc, QuickOrderState>(
                buildWhen: (previous, current) =>
                    previous.totalSku != current.totalSku,
                builder: (context, state) {
                  return Text('${state.totalSku}', style: _numberStyle);
                },
              ),
              Text(' SKUs', style: TextStyle(color: Colors.grey),),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantity() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quantity'),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<QuickOrderBloc, QuickOrderState>(
                buildWhen: (previous, current) =>
                    previous.totalItems != current.totalItems,
                builder: (context, state) {
                  return Text('${state.totalItems}', style: _numberStyle);
                },
              ),
              Text(' Total', style: TextStyle(color: Colors.grey),),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Total Amount'),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<QuickOrderBloc, QuickOrderState>(
                buildWhen: (previous, current) =>
                    previous.totalItems != current.totalItems,
                builder: (context, state) {
                  final totalAmount = state.totalAmount;
                  return Text(format.format(totalAmount), style: _priceStyle);
                },
              ),
              Text(' đ', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
