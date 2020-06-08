import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:testapp1/admin/add_product_admin.dart';
import 'package:testapp1/admin/image_capture.dart';
import 'package:testapp1/services/main_service.dart';
import 'package:testapp1/views/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final MainService mainService = MainService();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainService>(
      model: mainService,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
        routes: {
          AddProduct.id: (context) => AddProduct(),
          ImageCapture.id : (context) => ImageCapture()
        },
      ),
    );
  }
}
