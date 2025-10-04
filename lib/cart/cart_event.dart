abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Map<String, dynamic> product;
  AddToCart(this.product);
}

class IncrementQuantity extends CartEvent {
  final int index;
  IncrementQuantity(this.index);
}

class DecrementQuantity extends CartEvent {
  final int index;
  DecrementQuantity(this.index);
}

class ClearCart extends CartEvent {}