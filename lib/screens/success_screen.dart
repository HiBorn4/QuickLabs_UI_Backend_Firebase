// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, unused_import

import 'package:alemeno/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/test_provider.dart';

class SuccessScreen extends StatefulWidget {
  static const routeName = '/success';

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  Color buttonColor = Colors.indigo.shade900;

  @override
  Widget build(BuildContext context) {
    final testProvider =
        Provider.of<TestProvider>(context); // Access TestProvider
    final cartProvider =
        Provider.of<CartProvider>(context); // Access CartProvider
    final Size screenSize = MediaQuery.of(context).size;
    final double boxWidth = screenSize.width * 0.88;
    final double boxHeight = screenSize.height * 0.53;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.whatshot,
          color: Colors.white,
        ),
        title: Text('Success'),
        // centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'Settings',
                  child: Text('Settings'),
                ),
                PopupMenuItem(
                  value: 'Help',
                  child: Text('Help'),
                ),
                // Add more menu items as needed
              ];
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: boxWidth,
                    height: boxHeight,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/calendar.png', // Replace with your image path
                            width: boxWidth * 0.6,
                            height: boxHeight * 0.6,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Lab tests have been scheduled successfully, You will receive a mail of the same. ',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            '${testProvider.date} | ${testProvider.time}',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    buttonColor), // Button color
                minimumSize: MaterialStateProperty.all<Size>(
                    Size.fromHeight(boxHeight * 0.13)), // Button height
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Button border radius
                  ),
                ),
              ),
              onPressed: () {
                // Handle the button press here
                cartProvider.clearCart();
                Navigator.pushNamed(context, HomePage.routeName);
              },
              child: Text(
                'Back to Home',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
