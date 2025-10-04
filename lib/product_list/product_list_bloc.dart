import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'product_list_event.dart';
import 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(ProductListInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(
      FetchProducts event, Emitter<ProductListState> emit) async {
    emit(ProductListLoading());
    try {
      final response =
      await http.get(Uri.parse('https://dummyjson.com/carts'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final carts = data['carts'] as List<dynamic>;

        final List<dynamic> products = [];
        for (var cart in carts) {
          products.addAll(cart['products']);
        }

        emit(ProductListLoaded(products));
      } else {
        emit(ProductListError("Failed to load products"));
      }
    } catch (e) {
      emit(ProductListError(e.toString()));
    }
  }
}
