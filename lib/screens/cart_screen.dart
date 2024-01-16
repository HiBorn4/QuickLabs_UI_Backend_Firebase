// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:alemeno/providers/test_provider.dart';
import 'package:alemeno/screens/success_screen.dart';
import 'package:alemeno/widgets/cart_card.dart';
import 'package:alemeno/widgets/custom_checkbox.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_sms/flutter_sms.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
// import 'package:provider/provider.dart';

// import '../provider/test_provider.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int totalPrice = 0;
  int totalDiscountedPrice = 0;
  // DateTime selectedDate = DateTime.now();
  // TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider =
        Provider.of<CartProvider>(context); // Access CartProvider
    final testProvider =
        Provider.of<TestProvider>(context); // Access CartProvider

    Color buttonColor = Colors.indigo.shade900;
    final Size screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final double dateWidth = screenWidth * 0.9;
    final double dateHeight = screenHeight * 0.25;

    final double cardWidth = screenWidth * 0.87;
    final double cardHeight = screenHeight * 0.25;

    // void message() async {
    //   final List<String> testTitles =
    //       cartProvider.cart.map((test) => test.testName).toList();
    //   final String message =
    //       'Scheduled tests: ${testTitles.join(', ')}\nDate: ${testProvider.date}\nTime: ${testProvider.time}';

    //   List<String> recipients = [
    //     '9769202347'
    //   ]; // Replace with the destination phone number

    //   try {
    //     String result = await sendSMS(
    //       message: message,
    //       recipients: recipients,
    //     );
    //     print(result);
    //   } catch (error) {
    //     print('Failed to send SMS: $error');
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('My Cart'),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 23,
          right: 23,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ORDER REVIEW
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: Text(
                    'Order Review',
                    style: TextStyle(
                        color: buttonColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // PATHALOGY TESTS
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: cardWidth,
                        height: cardHeight * 0.2,
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Pathology Tests",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      cartProvider.cart.isEmpty
                          ? Container(
                              width: cardWidth,
                              height: screenHeight * 0.2,
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  "Nothing in the Cart",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: cartProvider.cart.length > 2
                                  ? 2 * screenHeight * 0.21
                                  : cartProvider.cart.length *
                                      screenHeight *
                                      0.21,
                              child: ListView.builder(
                                itemCount: cartProvider.cart.length,
                                itemBuilder: (context, index) {
                                  var cartItem = cartProvider.cart[index];

                                  return CartTestCard(
                                    title: cartItem.testName,
                                    price: cartItem.testPrice,
                                    discountedPrice: cartItem.disTestPrice,
                                    addedToCart: cartItem.addedToCart,
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
                // DATE AND TIME
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10,
                  ),
                  child: Container(
                    width: dateWidth,
                    height: screenHeight * 0.1,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.calendar_month_outlined,
                            size: 40,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: dateWidth * 0.8,
                            height: dateHeight * 0.2,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: testProvider.selectedDate,
                                  firstDate: DateTime.now(),
                                  lastDate:
                                      DateTime.now().add(Duration(days: 365)),
                                );
                                if (pickedDate != null &&
                                    pickedDate != testProvider.selectedDate) {
                                  setState(() {
                                    testProvider.selectedDate = pickedDate;
                                  });
                                }
                              },
                              child: Text(
                                  'Select Date: ${DateFormat('yyyy-MM-dd').format(testProvider.selectedDate)}'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Container(
                    width: dateWidth,
                    height: screenHeight * 0.1,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            size: 40,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: dateWidth * 0.8,
                            height: dateHeight * 0.2,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: testProvider.selectedTime,
                                );
                                if (pickedTime != null &&
                                    pickedTime != testProvider.selectedTime) {
                                  setState(() {
                                    testProvider.selectedTime = pickedTime;
                                  });
                                }
                              },
                              child: Text(
                                'Select Time: ${testProvider.selectedTime.format(context)}',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // PAYMENT
            Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.18,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'M.R.P Total',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '₹${cartProvider.getTotalPrice()}',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Discount',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '₹${cartProvider.getTotalPrice() - cartProvider.getTotalDiscountedPrice()}',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Amount to be Paid',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              color: buttonColor,
                            ),
                          ),
                          Text(
                            '₹${cartProvider.getTotalDiscountedPrice()}/-',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              color: buttonColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Total Savings',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '₹${cartProvider.getTotalPrice() - cartProvider.getTotalDiscountedPrice()}/-',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              color: buttonColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // FORMALITY
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 10,
              ),
              child: Container(
                width: dateWidth,
                height: screenHeight * 0.15,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          CustomCheckbox(),
                          SizedBox(
                              width:
                                  10), // Adjust the space between icon and text
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Hard Copy of Reports',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10.50,
                                ),
                              ),
                              SizedBox(
                                width: screenWidth *
                                    0.8, // Adjust as per your requirement
                                child: Text(
                                  'Reports will be delivered within 3-4 working days. Hard copy charges are non-refundable once the reports have been dispatched.',
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 3, // Restrict to 3 lines
                                  overflow: TextOverflow
                                      .ellipsis, // Show ellipsis if text overflows
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '150 per person',
                                style: TextStyle(
                                  fontSize: 10.30,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Implement date choosing, order summary, etc.
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    buttonColor,
                  ), // Button color
                  minimumSize: MaterialStateProperty.all<Size>(
                    Size.fromHeight(screenHeight * 0.06),
                  ), // Button height
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ), // Button border radius
                    ),
                  ),
                ),
                onPressed: () {
                  if (testProvider.isChecked &&
                      !(testProvider.selectedDate == DateTime.now() &&
                          testProvider.selectedTime == TimeOfDay.now())) {
                    // Move to the next page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // Your next page goes here
                        builder: (context) => SuccessScreen(),
                      ),
                    );
                    // message();
                  }
                  if (cartProvider.cart.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Please Add some Tests in your Cart.',
                        ),
                      ),
                    );
                  } else {
                    // Show Snackbar for not selected time or date
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Please Click on the CheckBox.',
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  'Schedule',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
