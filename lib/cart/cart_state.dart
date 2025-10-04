class CartState {
  final List<Map<String, dynamic>> cartItems;

  CartState({required this.cartItems});

  factory CartState.initial() {
    return CartState(cartItems: []);
  }

  double get totalPrice {
    return cartItems.fold(
        0.0,
            (sum, item) =>
        sum + (item['price'] as num) * (item['quantity'] as int));
  }
}
