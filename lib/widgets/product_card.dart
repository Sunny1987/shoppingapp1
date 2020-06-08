//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    return Container(
      height: MediaQuery.of(context).size.width * 0.5,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.all(10.0),
      child: Card(
        margin: EdgeInsets.all(10.0),
        elevation: 5.0,
        child: Row(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width * 0.5,
              width: 140.0,
              child: Image.network(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10.0),
            Container(
              padding: EdgeInsets.only(top: 10.0, left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.name,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(widget.description),
                  SizedBox(height: 10.0),
                  Text(widget.price),
                ],
              ),
            )

            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(10.0)
          ],
        ),
      ),
    );
  }
}
