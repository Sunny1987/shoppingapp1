//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:collection';
//mport 'dart:html';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp1/models/favoutites_model.dart';
import 'package:testapp1/models/product_model.dart';
import 'package:testapp1/models/user_model.dart';
//import 'package:testapp1/models/product_model.dart';
//import 'package:testapp1/pages/product_details.dart';
import 'package:testapp1/pages/product_details_page.dart';
import 'package:testapp1/services/main_service.dart';
//import 'package:testapp1/views/favouriteview.dart';
//import 'package:testapp1/models/product_model.dart';

class ProductCard extends StatefulWidget {
  final String name;
  final String description;
  final String price;
  final String discount;
  final String image;
  final String category;
  final MainService model;
  //static DocumentSnapshot data;

  ProductCard(
      {this.name,
      this.description,
      this.price,
      this.discount,
      this.image,
      this.model,
      this.category});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isFav = false;
  Map<String, Favourites> map;
  String docId = '';
  Map<String, Product> product_map;

  getFav(
    QuerySnapshot snapshot,
    AppUser user,
  ) async {
    //var snapshot = await model.getFavourites(user);

    var docs = snapshot.documents;
    List list =
        docs.map((document) => Favourites.fromSnapshot(document)).toList();

    map = Map.fromIterable(docs,
        key: (doc) => doc.documentID,
        value: (doc) => Favourites.fromSnapshot(doc));

    list.forEach((document) {
      Favourites fav = document;
      if (widget.image == fav.image) {
        if (this.mounted) {
          setState(() {
            _isFav = true;
            //_index = index;
          });
        }
      } else {
        print('Not Fav image');
      }
    });
  }

  getAllDocIds(QuerySnapshot snapshot) {
    var docs = snapshot.documents;

    product_map = Map.fromIterable(docs,
        key: (doc) => doc.documentID,
        value: (doc) => Product.fromSnapshot(doc));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    AppUser user = Provider.of<AppUser>(context);
    print('user from init: ${user.username}');
    final snapshot = await Firestore.instance
        .collection('user_favourites')
        .where('id', isEqualTo: '${user.uid}')
        .getDocuments();

    getFav(snapshot, user);
    print('map from didChangeDependencies: $map');
    map.forEach((key, value) {
      if (value.image == widget.image) {
        setState(() {
          docId = key;
        });
      }
    });

    final prod_snapshots =
        await Firestore.instance.collection('sarees').getDocuments();

    getAllDocIds(prod_snapshots);
    print('prod_map: $product_map');
  }

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<AppUser>(context);

    //print('user : ${user.username}');

    return ScopedModelDescendant<MainService>(
      builder: (BuildContext context, Widget child, MainService model) {
        //getFav(model, user);

        return GestureDetector(
          onTap: () {
            //Navigator.pushNamed(context, ProductDetailPage.id);
            product_map.forEach((key, value) {
              if (value.image == widget.image) {
                setState(() {
                  docId = key;
                });
              }
            });

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                          name: widget.name,
                          description: widget.description,
                          price: widget.price,
                          discount: widget.discount,
                          image: widget.image,
                          isFav: _isFav,
                          model: model,
                          map: map,
                          user: user,
                          docID: docId,
                          category: widget.category,
                        )));
          },
          child: Container(
            margin: EdgeInsets.only(left: 5.0, bottom: 10.0),
            child: ClipRRect(
              //borderRadius: BorderRadius.circular(20.0),

              child: Card(
                child: Container(
                  //padding: EdgeInsets.only(bottom: 10.0),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                      // color: Colors.grey.withOpacity(0.5),
                      image: DecorationImage(
                    image: NetworkImage(widget.image),
                    //fit: BoxFit.cover,
                  )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        //margin: EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ScopedModelDescendant<MainService>(
                              builder: (BuildContext context, Widget child,
                                  MainService model) {
                                return IconButton(
                                  onPressed: () {
                                    print('fav pressed');
                                    // add code toi upload fav data for user
                                    print(widget.image);
                                    print(user.uid);
                                    setState(() {
                                      _isFav = !_isFav;
                                      map.forEach((key, value) {
                                        if (value.image == widget.image) {
                                          docId = key;
                                        }
                                      });
                                    });

                                    model.firestoreAction(
                                        _isFav,
                                        docId,
                                        user.uid,
                                        widget.name,
                                        widget.description,
                                        widget.price,
                                        widget.discount,
                                        widget.image);
                                  },
                                  icon: _isFav
                                      ? Icon(
                                          Icons.favorite,
                                          size: 25.0,
                                        )
                                      : Icon(
                                          Icons.favorite_border,
                                          size: 25.0,
                                        ),
                                  color: Colors.redAccent,
                                );
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                print('cart pressed');
                                map.forEach((key, value) {
                                  if (value.image == widget.image) {
                                    setState(() {
                                      docId = key;
                                    });
                                    
                                  }
                                });
                                model.uploadUserCart(
                                    user.uid,
                                    widget.name,
                                    widget.description,
                                    widget.price,
                                    widget.discount,
                                    '1',
                                    //docId,
                                    widget.image);
                              },
                              icon: Icon(
                                Icons.add_shopping_cart,
                                size: 25.0,
                              ),
                              color: Colors.black54,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 60),
                      Container(
                          //margin: EdgeInsets.only(bottom: 20.0),
                          padding: EdgeInsets.only(left: 10.0),
                          width: MediaQuery.of(context).size.width,
                          height: 60.0,
                          decoration: BoxDecoration(
                              color: Colors.white38.withOpacity(0.7)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  widget.name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.0),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  '₹${widget.price}',
                                  style: TextStyle(
                                      color: Colors.red.shade300,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                // IconButton(
                                //   onPressed: () {},
                                //   icon: Icon(Icons.favorite_border),
                                //   color: Colors.redAccent,
                                // )
                              ]))
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
