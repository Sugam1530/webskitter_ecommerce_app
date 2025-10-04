import 'package:flutter/material.dart';
import '../cart/cart_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cart/cart_event.dart';
import '../cart/cart_page.dart';
import '../cart/cart_state.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['title']),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              final cartCount = state.cartItems.length;
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartPage()),
                      );
                    },
                  ),
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        '$cartCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(product['thumbnail'], height: 200),
            const SizedBox(height: 20),
            Text(product['title'],
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("\$${product['price']}",
                style: const TextStyle(fontSize: 18, color: Colors.green)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<CartBloc>(context).add(AddToCart(product));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Added to cart"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text("Add to Cart"),
            )
          ],
        ),
      ),
    );
  }
}
