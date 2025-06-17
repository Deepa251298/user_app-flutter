import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_app/models/product_model.dart';

class ProductController {
  Future<ProductResponse> fetchProducts({int limit = 10, int skip = 10}) async {
    final url = 'https://dummyjson.com/products?limit=$limit&skip=$skip';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return ProductResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load products');
    }
  }
}
