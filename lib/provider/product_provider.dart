import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/repository/product_repo.dart';
import 'package:ecommerce/services/remote_config.dart';
import 'package:flutter/material.dart';


class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();
  final RemoteConfigService _remoteConfigService;

  ProductProvider(this._remoteConfigService);

  List<Product> _products = [];
  bool _loading = true;
  String? _errorMessage;

  List<Product> get products => _products;
  bool get loading => _loading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProducts() async {
    try {
      _loading = true;
      _products = await _productService.fetchProducts();
      _loading = false;
    } catch (e) {
      _errorMessage = e.toString();
      _loading = false;
    }
    notifyListeners();
  }

  bool get showDiscountedPrice => _remoteConfigService.showDiscountedPrice;
}
