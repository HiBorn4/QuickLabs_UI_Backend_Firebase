// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/test_provider.dart';

class CustomCheckbox extends StatefulWidget {
  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    final testProvider =
        Provider.of<TestProvider>(context); // Access TestProvider
    final Size screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return GestureDetector(
      onTap: () {
        setState(() {
          testProvider.isChecked = !testProvider.isChecked;
        });
      },
      child: Container(
        width: screenWidth * 0.035,
        height: screenHeight * 0.035,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
          color: testProvider.isChecked ? Colors.blue.shade900 : Colors.white,
        ),
        child: testProvider.isChecked
            ? Icon(
                Icons.check,
                color: Colors.white,
                size: 11,
              )
            : SizedBox(), // Empty container when not checked
      ),
    );
  }
}
