import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/package.dart';
import '../models/test.dart';

// ChangeNotifier class to manage the state of tests
class TestProvider extends ChangeNotifier {
  final List<List<dynamic>> rawTests = [
    ['Thyroid Profile', 3, 1900, 1500, false],
    ['Blood Profile', 5, 2500, 2000, false],
    ['Urine Profile', 2, 1400, 1000, false],
    ['Genetic Profile', 1, 1000, 800, false],
  ];
  List<List<dynamic>> rawPackages = [
    [
      'Basic Package',
      5,
      ['Test1', 'Test2', 'Test3', 'Test4', 'Test5'],
      10000,
      10000,
      false
    ],
    [
      'Standard Package',
      10,
      [
        'TestA',
        'TestB',
      ],
      2000,
      2000,
      false
    ],
    [
      'Premium Package',
      15,
      ['TestX', 'TestY', 'TestZ'],
      5000,
      5000,
      false
    ],
  ];
  late List<Package> _packages;
  late List<Test> _tests;
  bool isChecked = false;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  TestProvider() {
    _tests = createTestInstances(rawTests);
    _packages = createPackageInstances(rawPackages);
    isChecked = false;
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
  }

  // Getter to access the list of tests
  List<Test> get tests => _tests;
  List<Package> get packages => _packages;
  String get date {
    // ignore: unnecessary_null_comparison
    if (selectedDate == null) return '';
    return DateFormat('d MMMM yyyy').format(selectedDate);
  }

  String get time {
    // ignore: unnecessary_null_comparison
    if (selectedTime == null) return '';
    return DateFormat('h:mm a').format(
      DateTime(
        2022,
        1,
        1,
        selectedTime.hour,
        selectedTime.minute,
      ),
    );
  }

  void changeAddedToCart(String title) {
    for (var test in _tests) {
      if (test.testName == title) {
        test.addedToCart = true;
        notifyListeners(); // Notify listeners to update the UI
        return;
      }
    }
  }

  void changePackageAddedToCart(String title) {
    for (var package in _packages) {
      if (package.packageName == title) {
        package.addedToCart = true;
        notifyListeners(); // Notify listeners to update the UI
        return;
      }
    }
  }

  void changeTestAddedToCartToFalse(String title) {
    for (var test in _tests) {
      if (test.testName == title) {
        test.addedToCart = false;
        notifyListeners(); // Notify listeners to update the UI
        return;
      }
    }
  }

  // Method to search for a package by title and change its addedToCart status to false
  void changePackageAddedToCartToFalse(String title) {
    for (var package in _packages) {
      if (package.packageName == title) {
        package.addedToCart = false;
        notifyListeners(); // Notify listeners to update the UI
        return;
      }
    }
  }

  void changeCheckBoxBool(String title) {
    isChecked = true;
    notifyListeners();
    return;
  }
}
