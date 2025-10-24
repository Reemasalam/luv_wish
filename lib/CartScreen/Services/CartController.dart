import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:luve_wish/CartScreen/Model/CoupenModel.dart';
import 'package:luve_wish/CartScreen/Model/CartModel.dart';
import 'package:luve_wish/main.dart';

class CartController extends GetxController {
  // -----------------------------
  // Cart state
  // -----------------------------
  final isLoading = false.obs;
  final cart = Rxn<CartModel>();
  final error = RxnString();

  // -----------------------------
  // Coupons state
  // -----------------------------
  final couponLoading = false.obs;
  final validCoupons = <Coupon>[].obs;
  final selectedCoupon = Rxn<Coupon>();
  final discountAmount = 0.0.obs;
  final hasDiscount = false.obs; // reflects whether an effective discount is active

  // -----------------------------
  // Fetch cart
  // -----------------------------
  Future<void> fetchCart() async {
    try {
      isLoading.value = true;
      error.value = null;

      final response = await http.get(
        Uri.parse("$baseUrl/cart"),
        headers: {"Authorization": "Bearer $accessToken"},
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        cart.value = CartModel.fromJson(body);
      } else {
        cart.value = CartModel.empty();
        error.value = "Failed to fetch cart (${response.statusCode})";
      }
    } catch (e) {
      cart.value = CartModel.empty();
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // -----------------------------
  // Totals
  // -----------------------------
  double getTotalPrice() {
    final items = cart.value?.data ?? const <CartItem>[];
    return items.fold<double>(0, (sum, item) => sum + item.lineTotal);
  }

  double getPayableTotal() {
    final total = getTotalPrice();
    final discount = discountAmount.value;
    return (total - discount).clamp(0, double.infinity);
  }

  // -----------------------------
  // Fetch valid coupons
  // -----------------------------
  Future<void> fetchCoupons() async {
    try {
      couponLoading.value = true;

      final response = await http.get(
        Uri.parse("$baseUrl/coupons/valid-coupons"),
        headers: {"Authorization": "Bearer $accessToken"},
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['success'] == true && body['data'] != null) {
          final listRaw = (body['data']['data'] as List?) ?? [];
          final list = listRaw.map((e) => Coupon.fromJson(e)).toList();
          validCoupons.assignAll(list);
          validCoupons.refresh();
        } else {
          validCoupons.assignAll([]);
          validCoupons.refresh();
        }
      } else {
        validCoupons.assignAll([]);
        validCoupons.refresh();
      }
    } catch (e) {
      validCoupons.assignAll([]);
      validCoupons.refresh();
    } finally {
      couponLoading.value = false;
    }
  }

  // -----------------------------
  // Coupon eligibility helpers (aligned to your Coupon model)
  // -----------------------------
  bool _isWithinDateRange(Coupon c, DateTime now) {
    // validFrom and validTill are non-null in your model
    if (now.isBefore(c.validFrom)) return false;
    if (now.isAfter(c.validTill)) return false;
    return true;
  }

  // With current Coupon model (no include/exclude lists), all items are eligible.
  List<CartItem> _eligibleItemsForCoupon(Coupon c) {
    return cart.value?.data ?? const <CartItem>[];
  }

  double _eligibleSubtotalForCoupon(Coupon c) {
    final elig = _eligibleItemsForCoupon(c);
    return elig.fold<double>(0, (sum, it) => sum + it.lineTotal);
  }

  // Parse numeric strings safely from model fields
  double _parseDoubleStr(String s) => double.tryParse(s) ?? 0.0;

  String? validateCoupon(Coupon c) {
    final now = DateTime.now();
    if (!_isWithinDateRange(c, now)) {
      return "This coupon is not active right now.";
    }

    // Enforce per-user usage limit using model fields (usedByCount vs usageLimitPerPerson).
    // If usageLimitPerPerson == 0 treat as unlimited; else ensure usedByCount < usageLimitPerPerson.
    if (c.usageLimitPerPerson > 0 && c.usedByCount >= c.usageLimitPerPerson) {
      return "Coupon usage limit reached.";
    }

    final eligSubtotal = _eligibleSubtotalForCoupon(c);

    // minimumSpent is a String; treat empty as 0.
    final minSpend = _parseDoubleStr(c.minimumSpent);
    if (eligSubtotal < minSpend) {
      return "Minimum spend of ₹${minSpend.toStringAsFixed(2)} required.";
    }

    return null; // valid
  }

  // -----------------------------
  // Apply/Clear coupon
  // -----------------------------
  void applyCoupon(Coupon coupon) {
    final err = validateCoupon(coupon);
    if (err != null) {
      selectedCoupon.value = null;
      discountAmount.value = 0;
      hasDiscount.value = false;
      return;
    }

    selectedCoupon.value = coupon;

    final eligSubtotal = _eligibleSubtotalForCoupon(coupon);
    final valueNum = _parseDoubleStr(coupon.value);
    double discount;

    // valueType expected 'percentage' or 'flat'
    if (coupon.valueType.toLowerCase() == 'percentage') {
      discount = (eligSubtotal * (valueNum / 100)).clamp(0, eligSubtotal);
    } else {
      discount = valueNum.clamp(0, eligSubtotal);
    }

    discountAmount.value = discount;
    hasDiscount.value = discount > 0;
  }

  void clearCoupon() {
    selectedCoupon.value = null;
    discountAmount.value = 0;
    hasDiscount.value = false;
  }

  // -----------------------------
  // Optional: item-level helpers for UI visuals
  // -----------------------------
  bool isCouponActiveAndValid() {
    final c = selectedCoupon.value;
    if (c == null) return false;
    return validateCoupon(c) == null;
  }

  bool isItemDiscounted(CartItem item) {
    final c = selectedCoupon.value;
    if (c == null) return false;
    if (!isCouponActiveAndValid()) return false;
    // With current model, all items are eligible if coupon is valid
    return true;
  }

  double discountedLineTotal(CartItem item) {
    final c = selectedCoupon.value;
    if (c == null || !isCouponActiveAndValid()) return item.lineTotal;

    final eligSubtotal = _eligibleSubtotalForCoupon(c);
    if (eligSubtotal <= 0) return item.lineTotal;

    final line = item.lineTotal;
    final valueNum = _parseDoubleStr(c.value);

    if (c.valueType.toLowerCase() == 'percentage') {
      final lineDiscount = (line * (valueNum / 100)).clamp(0, line);
      return (line - lineDiscount).clamp(0, line);
    } else {
      // Distribute flat discount proportionally across eligible items
      final totalDiscount = discountAmount.value;
      final share = (line / eligSubtotal);
      final lineDiscount = (totalDiscount * share).clamp(0, line);
      return (line - lineDiscount).clamp(0, line);
    }
  }

  // -----------------------------
  // Add to cart
  // -----------------------------
  Future<void> addToCart(String productId, int quantity) async {
    try {
      isLoading.value = true;
      error.value = null;

      final response = await http.post(
        Uri.parse("$baseUrl/cart/add"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          "productId": productId,
          "quantity": quantity,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final newItem = CartItem.fromJson(data['data']);

          if (cart.value != null) {
            final existingIndex = cart.value!.data
                .indexWhere((item) => item.productId == newItem.productId);

            if (existingIndex != -1) {
              final updatedItems = [...cart.value!.data];
              final oldItem = updatedItems[existingIndex];
              updatedItems[existingIndex] = CartItem(
                id: oldItem.id,
                productId: oldItem.productId,
                quantity: (oldItem.quantity ?? 0) + (newItem.quantity ?? 0),
                createdAt: oldItem.createdAt,
                updatedAt: DateTime.now(),
                customerProfileId: oldItem.customerProfileId,
                product: oldItem.product,
              );
              cart.value = CartModel(success: true, data: updatedItems);
            } else {
              final updatedItems = [...cart.value!.data, newItem];
              cart.value = CartModel(success: true, data: updatedItems);
            }
          } else {
            cart.value = CartModel(success: true, data: [newItem]);
          }
        } else {
          error.value = data['message'] ?? "Failed to add to cart";
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

  // -----------------------------
  // Remove from cart (by cart item id, decrement quantity)
  // -----------------------------
  Future<void> removeFromCart(String cartItemId, int quantity) async {
    try {
      isLoading.value = true;
      error.value = null;

      final url = "$baseUrl/cart/remove-from-cart/$cartItemId";
      final body = jsonEncode({"quantity": quantity});

      final response = await http.patch(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
        body: body,
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          if (cart.value != null) {
            final updatedItems = [...cart.value!.data];
            final index = updatedItems.indexWhere((item) => item.id == cartItemId);
            if (index != -1) {
              final currentQuantity = updatedItems[index].quantity ?? 0;
              if (currentQuantity <= quantity) {
                updatedItems.removeAt(index);
              } else {
                updatedItems[index] = CartItem(
                  id: updatedItems[index].id,
                  productId: updatedItems[index].productId,
                  quantity: currentQuantity - quantity,
                  createdAt: updatedItems[index].createdAt,
                  updatedAt: DateTime.now(),
                  customerProfileId: updatedItems[index].customerProfileId,
                  product: updatedItems[index].product,
                );
              }
              cart.value = CartModel(success: true, data: updatedItems);
            }
          }
        } else {
          error.value = data['message'] ?? "Failed to remove from cart";
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

  // -----------------------------
  // Increment / Decrement quantity (server authoritative)
  // -----------------------------
  Future<bool> addToIncrement(String productId, int quantity) async {
    try {
      isLoading.value = true;
      error.value = null;

      final url = "$baseUrl/cart/update-cart";
      final body = jsonEncode({
        "quantity": quantity,
        "productId": productId,
      });

      final response = await http.patch(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          await fetchCart(); // sync latest from server
          return true;
        } else {
          error.value = data['message'] ?? "Failed to update cart";
          return false;
        }
      } else {
        error.value = "Error ${response.statusCode}";
        return false;
      }
    } catch (e) {
      error.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
