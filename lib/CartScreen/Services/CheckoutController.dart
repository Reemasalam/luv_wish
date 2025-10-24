import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:luve_wish/CartScreen/Model/AddressModel.dart';
import 'package:luve_wish/CartScreen/Model/CoupenModel.dart';
// ✅ Import your Coupon model
import 'package:luve_wish/main.dart';

class CheckoutController extends GetxController {
  // ----- Address Variables -----
  var addresses = <AddressModel>[].obs;
  var isLoading = false.obs;
  var error = RxnString();

  // ----- Coupon Variables -----
  var coupons = <Coupon>[].obs;
  var isCouponLoading = false.obs;
  var couponError = RxnString();

  // ======================================================
  // ✅ Fetch Addresses
  // ======================================================
  Future<void> fetchAddresses() async {
    try {
      isLoading.value = true;
      error.value = null;

      final response = await http.get(
        Uri.parse("$baseUrl/addresses"),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final list = (data['data'] as List)
            .map((e) => AddressModel.fromJson(e))
            .toList();
        addresses.assignAll(list);
      } else {
        error.value = "Failed to fetch addresses (${response.statusCode})";
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // ======================================================
  // ✅ Add Address
  // ======================================================
  Future<bool> addAddress(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;
      error.value = null;

      final response = await http.post(
        Uri.parse("$baseUrl/addresses"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        final res = jsonDecode(response.body);
        if (res['success'] == true) {
          await fetchAddresses(); // refresh list safely
          return true;
        } else {
          error.value = res['message'] ?? "Failed to add address";
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

  // ======================================================
  // ✅ Fetch Valid Coupons
  // ======================================================
  Future<void> fetchValidCoupons() async {
    try {
      isCouponLoading.value = true;
      couponError.value = null;

      final response = await http.get(
        Uri.parse("$baseUrl/coupons/valid-coupons"),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        if (body['success'] == true && body['data'] != null) {
          final data = body['data']['data'] as List;
          final couponList = data.map((e) => Coupon.fromJson(e)).toList();
          coupons.assignAll(couponList);
        } else {
          couponError.value = "Invalid response format";
        }
      } else {
        couponError.value = "Failed to fetch coupons (${response.statusCode})";
      }
    } catch (e) {
      couponError.value = e.toString();
    } finally {
      isCouponLoading.value = false;
    }
  }
}
