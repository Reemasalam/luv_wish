import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:luve_wish/HomeScreen/Models/ProductModel.dart';
import 'package:luve_wish/main.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs; // all products from API
  var filteredProducts = <Product>[].obs; // after search/sort/filter
  var isLoading = false.obs;
  var error = RxnString();

  var searchQuery = "".obs;
  var sortOrder = "".obs; // "asc", "desc", or ""
  Rxn<RangeValues> priceRange = Rxn<RangeValues>();

  /// Fetch products from API
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      error.value = null;

      final response = await http.get(Uri.parse("$baseUrl/products"));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['success'] == true) {
          final List<dynamic> dataList = jsonData['data']['data'] ?? [];
          products.value = dataList.map((e) => Product.fromJson(e)).toList();

          // initially show all
          filteredProducts.assignAll(products);
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

  /// Apply search, sort, and filter together
  void applyFilters() {
    List<Product> result = List.from(products);

    // 🔍 Search filter
    if (searchQuery.value.isNotEmpty) {
      result = result
          .where((p) =>
              p.name.toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList();
    }

    // 💰 Price filter
    if (priceRange.value != null) {
      result = result
          .where((p) =>
              p.discountedPrice >= priceRange.value!.start &&
              p.discountedPrice <= priceRange.value!.end)
          .toList();
    }

    // ↕️ Sorting
    if (sortOrder.value == "asc") {
      result.sort((a, b) => a.discountedPrice.compareTo(b.discountedPrice));
    } else if (sortOrder.value == "desc") {
      result.sort((a, b) => b.discountedPrice.compareTo(a.discountedPrice));
    }

    filteredProducts.assignAll(result);
  }

  void setSearch(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void setSort(String order) {
    sortOrder.value = order;
    applyFilters();
  }

  void setPriceFilter(RangeValues range) {
    priceRange.value = range;
    applyFilters();
  }

  void resetFilters() {
    searchQuery.value = "";
    sortOrder.value = "";
    priceRange.value = null;
    filteredProducts.assignAll(products);
  }

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }
}
