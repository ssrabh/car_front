import 'package:flutter/material.dart';
import 'package:s_car/screens/devices/desktop_home.dart';
import 'package:s_car/screens/devices/mobile_home.dart';
import 'package:s_car/widgets/responsive_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Care',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ResponsiveLayout(desktop: DeskTopHome(), mobile: MobileHome()),
    );
  }
}
