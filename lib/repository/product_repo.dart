import 'dart:convert';
import 'package:ecommerce/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepo {
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/products'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> productsData = data['products'];
        return productsData.map((item) => Product.fromMap(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
