import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:luve_wish/Wishlist/Model/WishlistProductModel.dart';
import 'package:luve_wish/main.dart';

class WishlistController extends GetxController {
  var wishlistItems = <WishlistProduct>[].obs;
  var isLoading = false.obs;
  var error = RxnString();

  // Reactive variables for search, sort, and price filter
  var searchQuery = ''.obs;
  var sortOption = ''.obs; // "asc" or "desc"
  var minPrice = 0.0.obs;
  var maxPrice = double.infinity.obs;

  void setSearchQuery(String value) => searchQuery.value = value;
  void setSortOption(String value) => sortOption.value = value;
  void setMinPrice(double value) => minPrice.value = value;
  void setMaxPrice(double value) => maxPrice.value = value;

  /// Add a product to wishlist
  Future<void> addToWishlist(String productId) async {
    try {
      isLoading.value = true;
      error.value = null;

      final url = Uri.parse("$baseUrl/wishlist");

      print("ADD Wishlist Request URL: $url");
      print("ADD Wishlist Request Body: ${jsonEncode({"productId": productId})}");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({"productId": productId}),
      );

      print("ADD Wishlist Response Status: ${response.statusCode}");
      print("ADD Wishlist Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);
        if (body['success'] == true) {
          final wishlistData = body['data'];
          final wishlistItem = WishlistProduct.fromJson(wishlistData);
          wishlistItems.add(wishlistItem);
          Get.snackbar(
            "Success",
            "${wishlistItem.product?.name ?? 'Product'} added to wishlist",
          );
        } else {
          error.value = "Failed to add to wishlist";
        }
      } else {
        error.value = "Server error: ${response.statusCode}";
      }
    } catch (e) {
      error.value = e.toString();
      print("ADD Wishlist Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch wishlist
  Future<void> fetchWishlist({int page = 1, int limit = 10}) async {
    try {
      isLoading.value = true;
      error.value = null;

      final url = Uri.parse("$baseUrl/wishlist?page=$page&limit=$limit");
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      print("FETCH WISHLIST URL: $url");
      print("FETCH WISHLIST RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['success'] == true) {
          final List<dynamic> data = body['data']['data'];
          wishlistItems.value = data
              .map((item) => WishlistProduct.fromJson(item))
              .where((item) => item.product != null)
              .toList();

          print("Wishlist items count (with products): ${wishlistItems.length}");
        } else {
          error.value = "Failed to fetch wishlist";
        }
      } else {
        error.value = "Server error: ${response.statusCode}";
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// Remove item from wishlist
  Future<void> removeFromWishlist(String wishlistItemId) async {
    try {
      isLoading.value = true;
      error.value = null;

      final url = Uri.parse("$baseUrl/wishlist/?id=$wishlistItemId");
      print("REMOVE Wishlist Request URL: $url");

      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      print("REMOVE Wishlist Response Status: ${response.statusCode}");
      print("REMOVE Wishlist Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['success'] == true) {
          wishlistItems.removeWhere((item) => item.wishlistId == wishlistItemId);
          Get.snackbar("Success", "Item removed from wishlist");
        } else {
          error.value = "Failed to remove item from wishlist";
        }
      } else {
        error.value = "Server error: ${response.statusCode}";
      }
    } catch (e) {
      error.value = e.toString();
      print("REMOVE Wishlist Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Get filtered & sorted wishlist
  List<WishlistProduct> get filteredWishlist {
    var list = wishlistItems
        .where((item) =>
            item.product != null &&
            item.product!.name.toLowerCase().contains(searchQuery.value) &&
            item.product!.discountedPrice >= minPrice.value &&
            item.product!.discountedPrice <= maxPrice.value)
        .toList();

    if (sortOption.value == "asc") {
      list.sort((a, b) =>
          a.product!.discountedPrice.compareTo(b.product!.discountedPrice));
    } else if (sortOption.value == "desc") {
      list.sort((a, b) =>
          b.product!.discountedPrice.compareTo(a.product!.discountedPrice));
    }

    return list;
  }
}
