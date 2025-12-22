import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerapp/secret/keys.dart'; // Ensure secretkey is here

final stripePaymentProvider = Provider((ref) => StripeService());

class StripeService {
  final Dio _dio = Dio();

  Future<void> initPaymentSheet({
    required String amount,
    required String currency,
    required String merchantName,
  }) async {
    try {
      // 1. Payment Intent Create karna
      final paymentIntent = await _createPaymentIntent(amount, currency);

      // 2. Payment Sheet Initialize karna
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // FIX: Spelling 'client_secret' honi chahiye
          paymentIntentClientSecret: paymentIntent['client_secret'], 
          merchantDisplayName: merchantName,
          style: ThemeMode.light,
        ),
      );
    } catch (e) {
      print("Init Error: $e");
      rethrow;
    }
  }

  Future<void> presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print("Present Error: $e");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> _createPaymentIntent(String amount, String currency) async {
    try {
      final body = {
        'amount': (int.parse(amount) * 100).toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      final response = await _dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $secretkey',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}