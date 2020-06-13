import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:testapp1/models/favoutites_model.dart';
// import 'package:testapp1/models/product_model.dart';
import 'package:testapp1/widgets/product_card.dart';

class MyFavouriteListView extends StatefulWidget {
  
  final String uid;
  MyFavouriteListView({this.uid});

  @override
  _MyFavouriteListViewState createState() => _MyFavouriteListViewState();
}

class _MyFavouriteListViewState extends State<MyFavouriteListView> {
  @override
  Widget build(BuildContext context) {
    //print('index:${widget.index}');

   
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('user_favourites')
          .where('id',isEqualTo: '${widget.uid}')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          return SpinKitCubeGrid(color: Colors.grey,
            
          );
        } else {
          return Container(
            padding: EdgeInsets.only(right:10.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: _buildSnapshot(context, snapshot.data.documents));
        }
      },
    );
  }
}

Widget _buildSnapshot(BuildContext context, List<DocumentSnapshot> snapshot) {
  // return ListView(
  //   padding: const EdgeInsets.only(top: 20.0),
  //   children: snapshot.map((data) => _callProductCard(data)).toList(),
  // );

  return GridView.count(
    crossAxisCount: 2,
    children: snapshot.map((data) => _callProductCard(data)).toList(),
    
    );
}

Widget _callProductCard(DocumentSnapshot data) {
  final favourites = Favourites.fromSnapshot(data);

  return ProductCard(
    name: favourites.name,
    description: favourites.description,
    price: favourites.price,
    discount: favourites.discount,
    image: favourites.image,
  );
}
