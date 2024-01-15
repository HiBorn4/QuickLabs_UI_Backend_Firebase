// import 'package:alemeno/models/package.dart';
import 'package:flutter/material.dart';

import '../models/test.dart';

// ChangeNotifier class to manage the state of the cart
class CartProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<Test> _cart = [];

  // Getter to access the cart
  List<Test> get cart => _cart;

  // Add a test to the cart
  void addToCart(Test test) {
    _cart.add(test);
    notifyListeners();
  }

  // Remove a test from the cart by title
  void removeFromCart(String title) {
    _cart.removeWhere((test) => test.testName == title);
    notifyListeners();
  }

  // Get the total price of tests in the cart
  int getTotalPrice() {
    return _cart.fold(0, (total, test) => total + test.testPrice);
  }

  int getNoOfItems() {
    return _cart.length;
  }

  // Get the total discounted price of tests in the cart
  int getTotalDiscountedPrice() {
    return _cart.fold(0, (total, test) => total + test.disTestPrice);
  }

  // Clear all tests from the cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
