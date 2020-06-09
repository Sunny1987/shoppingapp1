import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:testapp1/models/product_model.dart';
import 'package:testapp1/widgets/product_card.dart';

class ProductListView extends StatefulWidget {
  
  final String category;
  ProductListView({this.category});

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  Widget build(BuildContext context) {
    //print('index:${widget.index}');
   
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('sarees')
          .where('category',isEqualTo: '${widget.category}')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          return SpinKitPouringHourglass(color: Colors.grey,
            
          );
        } else {
          return Container(
              width: MediaQuery.of(context).size.width * 0.9,
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
}

Widget _callProductCard(DocumentSnapshot data) {
  final product = Product.fromSnapshot(data);

  return ProductCard(
    name: product.name,
    description: product.description,
    price: product.price,
    discount: product.discount,
    image: product.image,
  );
}
