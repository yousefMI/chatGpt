import 'package:chat_gpt/screens/home/dio_helper.dart';
import 'package:chat_gpt/screens/home/view.dart';
import 'package:flutter/material.dart';

void main() {
  DioHelper.initDio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
     // darkTheme: ThemeData.dark(),
      theme: ThemeData.dark(),
      home:  HomeScreen(),
    );
  }

}

