import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:testapp1/admin/add_product_admin.dart';
import 'package:testapp1/admin/image_capture.dart';
//import 'package:testapp1/pages/authentication_page.dart';
import 'package:testapp1/pages/homepage_page.dart';
import 'package:testapp1/pages/product_details_page.dart';
import 'package:testapp1/services/auth_service.dart';
import 'package:testapp1/services/main_service.dart';
import 'package:testapp1/views/blouseview.dart';
import 'package:testapp1/views/sareeview.dart';
import 'package:testapp1/views/topview.dart';
import 'package:testapp1/views/trouserview.dart';
import './views/wrapper.dart';
//import 'package:testapp1/views/homepage.dart';

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
      child: MultiProvider(
        providers: [
          StreamProvider.value(value: AuthService().user),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Wrapper(),
          routes: {
            AddProduct.id: (context) => AddProduct(),
            ImageCapture.id: (context) => ImageCapture(),
            SareePage.id: (context) => SareePage(),
            TopPage.id: (context) => TopPage(),
            BlousePage.id: (context) => BlousePage(),
            TrouserPage.id: (context) => TrouserPage(),
            ProductDetailPage.id: (context) => ProductDetailPage(),
            HomePageScreen.id: (context) => HomePageScreen()
          },
        ),
      ),
    );
  }
}
