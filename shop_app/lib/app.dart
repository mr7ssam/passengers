import 'package:flutter/material.dart';
import 'package:p_design/p_design.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        title: 'Passengers Shop',
        useInheritedMediaQuery: true,
        theme: lightTheme,
        home: const Scaffold(
            body: Center(
                child: Text(
          'Passengets',
          style: TextStyle(package: 'p_design', fontFamily: 'LexendDeca'),
        ))),
      ),
    );
  }
}
