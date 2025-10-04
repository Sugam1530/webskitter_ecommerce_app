import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<AddToCart>(_onAddToCart);
    on<IncrementQuantity>(_onIncrement);
    on<DecrementQuantity>(_onDecrement);
    on<ClearCart> (_onClearCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final updatedCart = List<Map<String, dynamic>>.from(state.cartItems);
    final index = updatedCart.indexWhere((p) => p['id'] == event.product['id']);
    if (index >= 0) {
      updatedCart[index]['quantity']++;
    } else {
      final newProduct = Map<String, dynamic>.from(event.product);
      newProduct['quantity'] = 1;
      updatedCart.add(newProduct);
    }
    emit(CartState(cartItems: updatedCart));
  }

  void _onIncrement(IncrementQuantity event, Emitter<CartState> emit) {
    final updatedCart = List<Map<String, dynamic>>.from(state.cartItems);
    updatedCart[event.index]['quantity']++;
    emit(CartState(cartItems: updatedCart));
  }

  void _onDecrement(DecrementQuantity event, Emitter<CartState> emit) {
    final updatedCart = List<Map<String, dynamic>>.from(state.cartItems);
    if (updatedCart[event.index]['quantity'] > 1) {
      updatedCart[event.index]['quantity']--;
    } else {
      updatedCart.removeAt(event.index);
    }
    emit(CartState(cartItems: updatedCart));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(CartState.initial());
  }
}
