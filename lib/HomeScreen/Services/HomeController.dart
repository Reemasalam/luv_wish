import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:luve_wish/HomeScreen/Models/ProductModel.dart';
import 'package:luve_wish/main.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = false.obs;
  var error = RxnString();

  /// Fetch products from API
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      error.value = null;

      final response = await http.get(Uri.parse("$baseUrl/products"));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['success'] == true) {
          // ✅ Correct: API wraps products inside data -> data
          final List<dynamic> dataList = jsonData['data']['data'] ?? [];

          // Debug print first product for testing
          if (dataList.isNotEmpty) {
            print("First product: ${dataList[0]}");
          }

          // ✅ Map into Product model
          products.value = dataList.map((e) => Product.fromJson(e)).toList();
        } else {
          error.value = "API returned success=false";
        }
      } else {
        error.value = "Failed to load products: ${response.statusCode}";
      }
    } catch (e) {
      error.value = "Exception: $e";
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }
}
