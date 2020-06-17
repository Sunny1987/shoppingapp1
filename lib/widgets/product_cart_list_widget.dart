import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';
//import 'package:testapp1/models/product_model.dart';
import 'package:testapp1/models/user_cart_model.dart';
import 'package:testapp1/models/user_model.dart';
import 'package:testapp1/widgets/cart_item_widget.dart';
//import 'package:testapp1/models/user_model.dart';
//import 'package:testapp1/widgets/product_card.dart';

class ProductCartListView extends StatefulWidget {
  // final AppUser user;
  // ProductCartListView({this.user});

  @override
  _ProductCartListViewState createState() => _ProductCartListViewState();
}

class _ProductCartListViewState extends State<ProductCartListView> {
  @override
  Widget build(BuildContext context) {
    //print('index:${widget.index}');
    AppUser user = Provider.of<AppUser>(context);
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('user_cart')
          .where('id', isEqualTo: '${user.uid}')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          return SpinKitCubeGrid(
            color: Colors.grey,
          );
        } else {
          return Container(
              padding: EdgeInsets.only(right: 10.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: _buildSnapshot(context, snapshot.data.documents));
        }
      },
    );
  }
}

Widget _buildSnapshot(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _callProductCard(data)).toList(),
  );

  // return GridView.count(
  // crossAxisCount: 2,
  // children: snapshot.map((data) => _callProductCard(data)).toList(),
  //   );
}

Widget _callProductCard(DocumentSnapshot data) {
  final cart = Cart.fromSnapshot(data);

  return CartItem(
    name: cart.name,
    //description: cart.description,
    price: cart.price,
    discount: cart.discount,
    image: cart.image,
   // category: product.category,
   quantity: cart.quantity,
    
  );
}
