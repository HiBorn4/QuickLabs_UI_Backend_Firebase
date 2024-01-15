import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:alemeno/providers/test_provider.dart'; // Import TestProvider
import 'package:alemeno/providers/cart_provider.dart'; // Import CartProvider
import 'package:alemeno/screens/home_screen.dart';
// import 'package:alemeno/screens/cart_screen.dart';
import 'package:alemeno/screens/success_screen.dart';

void main() {
  runApp(
    // await Firebase.initializeApp();
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => TestProvider()), // Provide TestProvider
        ChangeNotifierProvider(
            create: (context) => CartProvider()), // Provide CartProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        HomePage.routeName: (ctx) => const HomePage(),
        SuccessScreen.routeName: (ctx) => SuccessScreen(),
      },
    );
  }
}
