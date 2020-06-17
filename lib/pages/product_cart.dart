import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp1/models/favoutites_model.dart';
import 'package:testapp1/models/user_cart_model.dart';
import 'package:testapp1/models/user_model.dart';
import 'package:testapp1/pages/homepage_page.dart';
import 'package:testapp1/style/mystrings.dart';
import 'package:testapp1/widgets/cart_item_widget.dart';
import 'package:testapp1/widgets/product_cart_list_widget.dart';
import 'package:testapp1/widgets/product_list_widget.dart';

class ProductCart extends StatefulWidget {
  @override
  _ProductCartState createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  getUserCartCount(
    QuerySnapshot snapshot,
    AppUser user,
  ) async {
    //var snapshot = await model.getFavourites(user);

    var docs = await snapshot.documents;
    List list = docs.map((document) => Cart.fromSnapshot(document)).toList();

    return list.length;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    // AppUser user = Provider.of<AppUser>(context);

    // final snapshot = await Firestore.instance
    //     .collection('user_cart')
    //     .where('id', isEqualTo: '${user.uid}')
    //     .getDocuments();
    // num count = await getUserCartCount(snapshot, user);
    // // setState(() {
    //   _count = count;
    // });
    // print('cart count: $_count');
  }

  @override
  Widget build(BuildContext context) {
    //AppUser user = Provider.of<AppUser>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 0.0,
          actions: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, HomePageScreen.id);
                },
                child: Center(
                    child: Text(
                  'Cart',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ))),
            SizedBox(width: 200.0),
          ],
        ),
        body: ProductCartListView(),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Card(
            child: Container(
              //padding: EdgeInsets.only(right: 10.0),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Center(
                        child: Text(
                      'Rs 200',
                      style: TextStyle(fontSize: 18.0),
                    )),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 200.0,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            blurRadius: 2.0,
                            offset: Offset(-2.0, 3.0),
                            color: Colors.grey),
                      ], color: Colors.redAccent),
                      child: Center(
                          child: Text(
                        'Check Out',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
