import 'package:flutter/material.dart';
import 'package:testapp1/models/favoutites_model.dart';
import 'package:testapp1/models/user_model.dart';
import 'package:testapp1/pages/homepage_page.dart';
import 'package:testapp1/services/main_service.dart';
import 'package:testapp1/views/blouseview.dart';
import 'package:testapp1/views/sareeview.dart';
import 'package:testapp1/views/topview.dart';
import 'package:testapp1/views/trouserview.dart';
import 'package:testapp1/widgets/drawer_widget.dart';
import 'package:testapp1/widgets/product_list_horiziontal_widget.dart';

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
  final String category;
  final String docID;

  ProductDetailPage(
      {this.name,
      this.description,
      this.price,
      this.discount,
      this.image,
      this.isFav,
      this.map,
      this.model,
      this.user,
      this.docID,
      this.category});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool _isFav = false;
  String docId ='';

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
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, HomePageScreen.id);
                },
                child: Center(child: Text('Mother\s Collection',style: TextStyle(
                  fontSize:18.0,
                ),))),
            SizedBox(width: 60.0),
            IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
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
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                            ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Similar Products',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () {
                        if (widget.category == 'Saree') {
                          Navigator.pushNamed(context, SareePage.id);
                        }
                        if (widget.category == 'Blouse') {
                          Navigator.pushNamed(context, BlousePage.id);
                        }
                        if (widget.category == 'Top') {
                          Navigator.pushNamed(context, TopPage.id);
                        }
                        if (widget.category == 'Trouser') {
                          Navigator.pushNamed(context, TrouserPage.id);
                        }
                      },
                      child: Text('More..',
                          style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                padding: EdgeInsets.all(20.0),
                width: MediaQuery.of(context).size.width,
                height: 250.0,
                child: ProductListHorizontalView(
                  category: widget.category,
                  docId: widget.docID,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
