import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:provider/provider.dart';
import 'package:testapp1/models/product_model.dart';
//import 'package:testapp1/models/user_model.dart';
//import 'package:testapp1/widgets/product_card.dart';
import 'package:testapp1/widgets/product_card_horizontal.dart';

class ProductListHorizontalView extends StatefulWidget {
  final String category;
  final String docId;
  ProductListHorizontalView({this.category, this.docId});

  @override
  _ProductListHorizontalViewState createState() =>
      _ProductListHorizontalViewState();
}

class _ProductListHorizontalViewState extends State<ProductListHorizontalView> {
  @override
  Widget build(BuildContext context) {
    //print('index:${widget.index}');

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('sarees')
          .where('category', isEqualTo: '${widget.category}')
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

  Widget _buildSnapshot(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot
          .where((element) => element.documentID != widget.docId)
          .map((data) => _callProductCard(data))
          .toList(),
    );

    // return GridView.count(
    // crossAxisCount: 2,
    // children: snapshot.map((data) => _callProductCard(data)).toList(),
    //   );
  }

  Widget _callProductCard(DocumentSnapshot data) {
    final product = Product.fromSnapshot(data);
    return ProductCardHorizontal(
      name: product.name,
      description: product.description,
      price: product.price,
      discount: product.discount,
      image: product.image,
      category: product.category,
      //product: product,
      docID: widget.docId,
    );
    // } else {
    //   return null;
    // }
    //}
  }
}
