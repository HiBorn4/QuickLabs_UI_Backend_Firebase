// ignore_for_file: prefer_const_constructors, must_b
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/test.dart';
import '../providers/cart_provider.dart';
import '../providers/test_provider.dart';

// ignore: camel_case_types, must_be_immutable
class testCard extends StatefulWidget {
  String title;
  int noOfTests;
  int price;
  int discountedPrice;
  bool added;

  testCard(
      this.title, this.noOfTests, this.price, this.discountedPrice, this.added,
      {super.key});

  @override
  State<testCard> createState() => _testCardState();
}

// ignore: camel_case_types
class _testCardState extends State<testCard> {
  @override
  Widget build(BuildContext context) {
    final testProvider =
        Provider.of<TestProvider>(context); // Access TestProvider
    final cartProvider =
        Provider.of<CartProvider>(context); // Access CartProvider
    Color mainColor = Colors.indigo.shade900;

    final Size screenSize = MediaQuery.of(context).size;
    // final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Card(
      shadowColor: Colors.white,
      color: Colors.white,
      margin: EdgeInsets.only(
        top: 10,
        bottom: 4,
        left: 14,
        right: 14,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey, width: 1), // Grey border
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              height: screenHeight * 0.045,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, top: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          left: 5.0,
                        ),
                        child: Text(
                          'Includes ${widget.noOfTests} Tests',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/shield.png',
                        width: 30,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(
                      'Get Reports in 24 hours',
                      style: TextStyle(
                        fontSize: 9,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(
                          '₹${widget.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: mainColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          widget.discountedPrice.toString(),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.added) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('You have already added the test'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        cartProvider.addToCart(
                          Test(
                            testName: widget.title,
                            noOfTests: widget.noOfTests,
                            testPrice: widget.price,
                            disTestPrice: widget.discountedPrice,
                            addedToCart: true,
                          ),
                        );
                        setState(() {
                          testProvider.changeAddedToCart(widget.title);
                        });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
                        if (widget.added == true) {
                          return Color(0xFF1BA9B5);
                        } else if (widget.added == false) {
                          return mainColor;
                        } else {
                          return Colors.grey;
                        }
                      }),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size.fromHeight(screenHeight * 0.045),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    child: Text(
                      widget.added == true
                          ? 'Added to Cart'
                          : (widget.added == false
                              ? 'Add to Cart'
                              : 'Adding to Cart'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // View Details action
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size.fromHeight(screenHeight * 0.045),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                            color: mainColor, // Blue border color
                            width: 1, // Border width
                          ),
                        ),
                      ),
                    ),
                    child: Text(
                      'View Details',
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Other content...
          ],
        ),
      ),
    );
  }
}
