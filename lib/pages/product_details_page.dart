import 'package:flutter/material.dart';
import 'package:testapp1/models/favoutites_model.dart';
import 'package:testapp1/models/user_model.dart';
import 'package:testapp1/services/main_service.dart';
import 'package:testapp1/widgets/drawer_widget.dart';

class ProductDetailPage extends StatefulWidget {
  static const String id = 'ProductDetailPage';
  final String name;
  final String description;
  final String price;
  final String discount;
  final String image;
  final bool isFav;
  final MainService model;
  final Map<String, Favourites> map;
  final AppUser user;

  ProductDetailPage(
      {this.name,
      this.description,
      this.price,
      this.discount,
      this.image,
      this.isFav,
      this.map,
      this.model,
      this.user});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool _isFav = false;
  String docId = '';

  @override
  void initState() {
    super.initState();
    if (widget.isFav == true) {
      _isFav = true;
    } else {
      _isFav = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.settings_power), onPressed: () {})
          ],
        ),
        drawer: MyDrawer(),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20.0),
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.image), fit: BoxFit.fill)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      child: Text(
                    widget.name,
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                  )),
                  Container(
                    child: Text(
                        '₹${int.parse(widget.price) + int.parse(widget.discount)}',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 16.0,
                            color: Colors.grey)),
                  ),
                  Container(
                      child: Text(
                    '₹${widget.price}',
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  )),
                ],
              ),
              Divider(
                height: 20.0,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Text('Quantity'),
                  ),
                  Container(
                    width: 150.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.add), onPressed: () {}),
                        //SizedBox(height: 10.0),
                        Text('0'),
                        //SizedBox(height: 10.0),
                        IconButton(icon: Icon(Icons.remove), onPressed: () {})
                      ],
                    ),
                  )
                ],
              ),
              Divider(
                height: 20.0,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 170.0,
                    child: FlatButton(
                      onPressed: () {},
                      color: Colors.red,
                      child: Text(
                        'Buy',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
                  IconButton(
                      icon: _isFav
                          ? Icon(Icons.favorite,color: Colors.red,)
                          : Icon(Icons.favorite_border,color: Colors.red,),
                      onPressed: () {
                        setState(() {
                          _isFav = !_isFav;
                          widget.map.forEach((key, value) {
                            if (value.image == widget.image) {
                              docId = key;
                            }
                          });
                        });

                        widget.model.firestoreAction(
                            _isFav,
                            docId,
                            widget.user.uid,
                            widget.name,
                            widget.description,
                            widget.price,
                            widget.discount,
                            widget.image);
                      })
                ],
              ),
              Divider(
                height: 20.0,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: Text('Product Description',
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(child: Text(widget.description)),
              Divider(
                height: 20.0,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: Text('Similar Products',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
