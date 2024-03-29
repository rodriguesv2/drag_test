import 'package:drag_test/pages/drag_drop_merge_page.dart';
import 'package:drag_test/pages/giphy_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DragDropMergePage(title: 'Bla bla bla'),
    );
  }
}
