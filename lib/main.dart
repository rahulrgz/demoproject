import 'package:demoproject/feature/botnav.dart';
import 'package:demoproject/feature/homepage.dart';
import 'package:flutter/material.dart';

import 'core/global_variable/global_variable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return const MaterialApp(
      home: BottomNav(),
      debugShowCheckedModeBanner: false,
    );
  }
}
