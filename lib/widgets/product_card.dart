//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:testapp1/models/favoutites_model.dart';
import 'package:testapp1/models/user_model.dart';
//import 'package:testapp1/models/product_model.dart';
//import 'package:testapp1/pages/product_details.dart';
import 'package:testapp1/pages/product_details_page.dart';
import 'package:testapp1/services/main_service.dart';
import 'package:testapp1/views/favouriteview.dart';
//import 'package:testapp1/models/product_model.dart';

class ProductCard extends StatefulWidget {
  final String name;
  final String description;
  final String price;
  final String discount;
  final String image;
  //static DocumentSnapshot data;

  ProductCard(
      {this.name, this.description, this.price, this.discount, this.image});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isFav = false;

  // getFav(
  //   MainService model,
  //   AppUser user,
  // ) {
  //   //bool _isFav;
  //   list = model.getFavourites(user).map((snapshot) =>
  //       snapshot.documents
  //           .map((document) => Favourites.fromSnapshot(document))
  //           .toList());
  //   print('list : $list');
  //   list.forEach((element) {
  //     element.forEach((data) {
  //       //print('data : ${data.name}');
  //       if (widget.image == data.image) {
  //         setState(() {
  //           _isFav = true;
  //         });
  //       }
  //     });
  //   });
  // }



  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<AppUser>(context);

    return ScopedModelDescendant<MainService>(
      builder: (BuildContext context, Widget child, MainService model) {
       // getFav(model, user);
        return GestureDetector(
          onTap: () {
            //Navigator.pushNamed(context, ProductDetailPage.id);
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
                                    model.uploadUserFavourites(
                                        user.uid,
                                        widget.name,
                                        widget.description,
                                        widget.price,
                                        widget.discount,
                                        widget.image);

                                    setState(() {
                                      _isFav = !_isFav;
                                    });
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
                              },
                              icon: Icon(
                                Icons.shopping_cart,
                                size: 25.0,
                              ),
                              color: Colors.redAccent,
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
