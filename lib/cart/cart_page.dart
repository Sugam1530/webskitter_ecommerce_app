import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final items = state.cartItems;

          if (items.isEmpty) {
            return const Center(child: Text("Your cart is empty", style: TextStyle(fontSize: 20),));
          }

          final total = state.totalPrice;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final price = (item['price'] as num).toDouble();
                    final quantity = item['quantity'] as int;
                    final lineTotal = price * quantity;

                    return ListTile(
                      leading: item['thumbnail'] != null
                          ? Image.network(item['thumbnail'], width: 60, fit: BoxFit.cover)
                          : null,
                      title: Text(item['title'] ?? 'No title'),
                      subtitle: Text(
                        "₹${price.toStringAsFixed(2)} x $quantity = ₹${lineTotal.toStringAsFixed(2)}",
                      ),
                      trailing: SizedBox(
                        width: 110,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                context.read<CartBloc>().add(DecrementQuantity(index));
                              },
                            ),
                            Text('$quantity',),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                context.read<CartBloc>().add(IncrementQuantity(index));
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total', style: Theme.of(context).textTheme.titleLarge),
                        Text('₹${total.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleLarge),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Thank You for ordering. Your order is being processed.')),
                              );
                              context.read<CartBloc>().add(ClearCart());
                            },
                            child: const Text('Checkout'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
