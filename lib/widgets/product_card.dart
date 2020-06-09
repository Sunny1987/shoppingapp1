//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:testapp1/models/product_model.dart';
//import 'package:testapp1/pages/product_details.dart';
import 'package:testapp1/pages/product_details_page.dart';
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
  @override
  Widget build(BuildContext context) {
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
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(left: 20.0, bottom: 20.0),
        child: ClipRRect(
          //borderRadius: BorderRadius.circular(20.0),
          child: Container(
            //padding: EdgeInsets.only(bottom: 10.0),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
                // color: Colors.grey.withOpacity(0.5),
                image: DecorationImage(
              image: NetworkImage(widget.image),
              fit: BoxFit.cover,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                    // margin: EdgeInsets.only(bottom: 20.0),
                    //padding: EdgeInsets.only(left:10.0),
                    width: MediaQuery.of(context).size.width,
                    height: 60.0,
                    decoration:
                        BoxDecoration(color: Colors.grey.withOpacity(0.7)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            widget.price,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite_border),
                            color: Colors.redAccent,
                          )
                        ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
