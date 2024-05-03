import 'package:flutter/material.dart';
import 'package:tesk/features/bottom_nav_bar/bottom_nav_bar.dart';

void main() => runApp(
      const MyApp(), // Wrap your app
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      home: BottomBarScreen(),
    );
  }
}
