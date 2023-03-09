import 'package:flutter/material.dart';
import 'package:my_quotes_app/views/Motevational_quotes.dart';
import 'package:my_quotes_app/views/alber_quotes.dart';
import 'package:my_quotes_app/views/love_quotes.dart';
import 'package:my_quotes_app/views/swami_vivekanad_quotes.dart';
import 'Views/Home_Page.dart';


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        'LoveQuotes': (context) => const LoveQuotes(),
        'SwamiVivekanand': (context) => const SwamiVivekanand(),
        'Albert_Quotes': (context) => const Albert_Quotes(),
        'Motevational_Quotes': (context) => const Motevational_Quotes(),
      },
    ),
  );
}
