import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/controllers/cart_controller.dart';
import 'package:getx_sqflite/creds.dart';
import 'package:getx_sqflite/views/success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool loading = false;

  setLoading(bool val) {
    setState(() {
      loading = val;
    });
  }

  final controller = Get.put(CartController());

  void intializeStripe() async {
    Stripe.publishableKey = stripePK;
    Stripe.instance.applySettings();
  }

  pay() async {
    setLoading(true);
    try {
      final token = await Stripe.instance.createToken(
        CreateTokenParams.card(
          params: CardTokenParams(
            currency: 'usd',
          ),
        ),
      );
      // USE token id to pass token to your backend service to finish payment intent.
      print(token.id);
      setLoading(false);
      Get.to(() => SuccessScreen());
    } catch (e) {
      log(e.toString(), error: e, name: 'Payment error');
    }
  }

  @override
  void initState() {
    intializeStripe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            _buildOrderSummary(),
            SizedBox(height: 20),
            _buildForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 50,
              color: Colors.black12,
              spreadRadius: 12,
            )
          ],
        ),
        child: Column(
          children: [
            CardFormField(),
            SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                icon: Icon(Icons.credit_score_outlined),
                onPressed: pay,
                label: loading
                    ? CupertinoActivityIndicator(color: Colors.white)
                    : Text("Pay"),
              ),
            )
          ],
        ),
      );

  Container _buildOrderSummary() {
    final items = controller.cartItems;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 50,
            color: Colors.black12,
            spreadRadius: 12,
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          ...items
              .map(
                (item) => _buildOrderRow(
                  name: item.name,
                  price: item.price,
                ),
              )
              .toList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${items.fold(0, (prev, e) => (e.price + prev))}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOrderRow({String? name, price}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('\$$price'),
        ],
      ),
    );
  }
}
