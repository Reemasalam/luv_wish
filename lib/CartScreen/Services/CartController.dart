import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


import 'package:luve_wish/CartScreen/Model/CartModel.dart';
import 'package:luve_wish/CartScreen/Model/CartItemModel.dart';
import 'package:luve_wish/main.dart';
class CartController extends GetxController {
  var cart = Rxn<Cart>();
  var isLoading = false.obs;
  var error = RxnString();



  /// Add to cart
  Future<void> addToCart(String productId, int quantity) async {
    try {
      isLoading.value = true;
      error.value = null;

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "productId": productId,
          "quantity": quantity,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          final item = CartItem.fromJson(data['data']);
          // If cart already exists, update it, else create new
          if (cart.value != null) {
            final updatedItems = [...cart.value!.items, item];
            cart.value = Cart(
              items: updatedItems,
              total: cart.value!.total + (double.tryParse(item.product.price) ?? 0) * item.quantity,
              itemCount: cart.value!.itemCount + item.quantity,
            );
          } else {
            cart.value = Cart(items: [item], total: 0, itemCount: item.quantity);
          }
        } else {
          error.value = "Failed to add to cart";
        }
      } else {
        error.value = "Error ${response.statusCode}";
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// Get cart
  Future<void> fetchCart() async {
    try {
      isLoading.value = true;
      error.value = null;

      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          cart.value = Cart.fromJson(data['data']);
        } else {
          error.value = "Failed to load cart";
        }
      } else {
        error.value = "Error ${response.statusCode}";
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
