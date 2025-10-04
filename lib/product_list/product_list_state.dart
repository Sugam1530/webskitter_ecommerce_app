abstract class ProductListState {}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<dynamic> products;
  ProductListLoaded(this.products);
}

class ProductListError extends ProductListState {
  final String message;
  ProductListError(this.message);
}
