import 'package:flutter/material.dart';
import 'package:wallet/pages/credit_cards.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      themeMode: ThemeMode.dark,
      routes: {
        '/': (context) => CreditCards(),
      },
    );
  }
}