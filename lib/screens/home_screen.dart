// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:alemeno/screens/cart_screen.dart';
import 'package:alemeno/screens/yet_to_be_updated.dart';
import 'package:alemeno/widgets/package_card.dart';
import 'package:alemeno/widgets/test_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/test_provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Color mainColor = Colors.indigo.shade900;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final testProvider =
        Provider.of<TestProvider>(context); // Access TestProvider
    final cartProvider =
        Provider.of<CartProvider>(context); // Access CartProvider

    final Size screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            'Logo',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              CircleAvatar(
                radius: 9,
                child: Consumer<TestProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    return Text(
                      cartProvider.getNoOfItems().toString(),
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 23,
                    color: Colors.blue.shade900,
                  ),
                  onPressed: () {
                    // Add your shopping cart action here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15.0,
            right: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Popular Lab Tests',
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.07,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => YTBUScreen(),
                          ),
                        );
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'View more',
                          style: TextStyle(
                            color: mainColor,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600,
                            // Add other text styles if needed
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.01,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 15,
                          color: mainColor,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.52,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: testProvider.tests.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.87,
                  ),
                  itemBuilder: (context, index) {
                    return testCard(
                      testProvider.tests[index].testName,
                      testProvider.tests[index].noOfTests,
                      testProvider.tests[index].testPrice,
                      testProvider.tests[index].disTestPrice,
                      testProvider.tests[index].addedToCart,
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  left: 14.0,
                  bottom: 15,
                ),
                child: Text(
                  'Popular Packages',
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0, right: 13),
                child: SizedBox(
                  height: screenHeight * 0.271,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: testProvider.packages.length,
                    itemExtent: screenWidth *
                        0.85, // Adjust this value as needed for the distance between items
                    itemBuilder: (context, index) {
                      // List<dynamic> packageData = testProvider.packages[index];

                      return Padding(
                        padding: const EdgeInsets.only(
                          right:
                              8.0, // Adjust this value for spacing between items
                        ),
                        child: packageCard(
                          testProvider.packages[index].packageName,
                          testProvider.packages[index].noOfTests,
                          testProvider.packages[index].deepTests,
                          testProvider.packages[index].packagePrice,
                          testProvider.packages[index].disPackagePrice,
                          testProvider.packages[index].addedToCart,
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Add more customCard widgets or modify the structure as needed
            ],
          ),
        ),
      ),
    );
  }
}
