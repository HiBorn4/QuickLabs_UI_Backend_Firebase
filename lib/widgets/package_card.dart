// ignore_for_file: prefer_const_constructors, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/test.dart';
import '../providers/cart_provider.dart';
import '../providers/test_provider.dart';

class packageCard extends StatefulWidget {
  String packageName;
  int noOfTests;
  List<String> deepTests;
  int packagePrice;
  int disPackagePrice;
  bool addedToCart;

  packageCard(this.packageName, this.noOfTests, this.deepTests,
      this.packagePrice, this.disPackagePrice, this.addedToCart,
      {super.key});

  @override
  State<packageCard> createState() => _popularPackageCardState();
}

class _popularPackageCardState extends State<packageCard> {
  @override
  Widget build(BuildContext context) {
    final cartProvider =
        Provider.of<CartProvider>(context); // Access CartProvider
    final testProvider =
        Provider.of<TestProvider>(context); // Access TestProvider
    Color mainColor = Colors.indigo.shade900;

    final Size screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(0, 0, 0, 1)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'assets/bottle.png',
                      width: screenHeight * 0.085,
                    ),
                    Image.asset(
                      'assets/safe.png',
                      width: screenHeight * 0.09,
                    ),
                  ],
                ),
                Text(
                  widget.packageName,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Includes 92 tests',
                  style: TextStyle(
                    fontSize: 10.50,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // ListView.builder(
                //   itemCount: widget.deepTests.length,
                //   itemBuilder: (context, index) {
                //     return Row(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           '•',
                //           style: TextStyle(
                //             fontSize: 10.50,
                //             fontFamily: 'Inter',
                //             fontWeight: FontWeight.w400,
                //           ),
                //         ),
                //         SizedBox(
                //             width:
                //                 1), // Adjust spacing between bullet point and text
                //         Expanded(
                //           child: Text(
                //             widget.deepTests[index],
                //             style: TextStyle(
                //               fontSize: 10.50,
                //               fontFamily: 'Inter',
                //               fontWeight: FontWeight.w400,
                //             ),
                //           ),
                //         ),
                //       ],
                //     );
                //   },
                // ),
                Text(
                  'View more',
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 10,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                    // Add other text styles if needed
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '₹${widget.packagePrice}/-',
                      style: TextStyle(
                        color: Color(0xFF1BA9B5),
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.35,
                      child: ElevatedButton(
                        onPressed: () {
                          if (widget.addedToCart) {
                            // If already added, show a message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('You have already added the test'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            // If not added, add it to the cart
                            cartProvider.addToCart(
                              Test(
                                testName: widget.packageName,
                                noOfTests: widget.noOfTests,
                                testPrice: widget.packagePrice,
                                disTestPrice: widget.packagePrice,
                                addedToCart: true,
                              ),
                            );
                            setState(() {
                              testProvider
                                  .changePackageAddedToCart(widget.packageName);
                            });
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                            if (widget.addedToCart == true) {
                              return Color(0xFF1BA9B5);
                            } else if (widget.addedToCart == false) {
                              return mainColor;
                            } else {
                              return Colors.grey;
                            }
                          }),
                          minimumSize: MaterialStateProperty.all<Size>(
                            Size.fromHeight(screenHeight * 0.045),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        child: Text(
                          widget.addedToCart == true
                              ? 'Added to Cart'
                              : (widget.addedToCart == false
                                  ? 'Add to Cart'
                                  : 'Adding to Cart'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
