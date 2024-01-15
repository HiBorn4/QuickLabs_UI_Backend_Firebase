// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/test_provider.dart';

// ignore: camel_case_types
class CartTestCard extends StatelessWidget {
  final String title;
  final int price;
  final int discountedPrice;
  final bool addedToCart;

  const CartTestCard({
    super.key,
    required this.title,
    required this.price,
    required this.discountedPrice,
    required this.addedToCart,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor = Colors.indigo.shade900;

    final Size screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final double cardWidth = screenWidth * 0.91;
    final double cardHeight = screenHeight * 0.197;

    return Card(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
          border: Border.all(
            color: Colors.grey, // Set the desired border color
          ),
        ),
        width: cardWidth,
        height: cardHeight,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 9,
            right: 25,
            left: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '₹$price/-',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            discountedPrice.toString(),
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: screenWidth * 0.4,
                    child: ElevatedButton(
                      onPressed: () {
                        // Remove action
                        final cartProvider =
                            Provider.of<CartProvider>(context, listen: false);
                        cartProvider.removeFromCart(title);
                        final testProvider =
                            Provider.of<TestProvider>(context, listen: false);
                        testProvider.changeTestAddedToCartToFalse(title);
                        testProvider.changePackageAddedToCartToFalse(title);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.white), // Button color
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size.fromHeight(
                                screenHeight * 0.045)), // Button height
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            side:
                                BorderSide(color: buttonColor), // Outline color
                            borderRadius: BorderRadius.circular(
                                1000), // Button border radius
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete, color: buttonColor), // Icon color
                          SizedBox(width: 8),
                          Text(
                            'Remove',
                            style: TextStyle(
                              color: buttonColor, // Text color
                              fontSize: 16, // Text size
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        // Upload prescription action
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.white), // Button color
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size.fromHeight(
                                screenHeight * 0.045)), // Button height
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            side:
                                BorderSide(color: buttonColor), // Outline color
                            borderRadius: BorderRadius.circular(
                                1000), // Button border radius
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.file_upload_outlined,
                              color: buttonColor), // Icon color
                          SizedBox(width: 8),
                          Text(
                            'Upload prescription (optional)',
                            style: TextStyle(
                              color: buttonColor, // Text color
                              fontSize: 16, // Text size
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
