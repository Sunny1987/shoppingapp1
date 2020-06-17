import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:testapp1/models/favoutites_model.dart';
import 'package:testapp1/models/user_model.dart';
import 'package:testapp1/pages/homepage_page.dart';
import 'package:testapp1/pages/product_cart.dart';
import 'package:testapp1/pages/product_pic_page.dart';
import 'package:testapp1/services/main_service.dart';
import 'package:testapp1/style/mystrings.dart';
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
  String docId = '';
  int _quantity = 0;
  num _count = 0;

  getUserCartCount(
    QuerySnapshot snapshot,
    AppUser user,
  ) async {
    //var snapshot = await model.getFavourites(user);

    var docs = await snapshot.documents;
    List list =
        docs.map((document) => Favourites.fromSnapshot(document)).toList();

    return list.length;
  }

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
  void didChangeDependencies() async{
    super.didChangeDependencies();
    AppUser user = Provider.of<AppUser>(context);
    final snapshot = await Firestore.instance
        .collection('user_cart')
        .where('id', isEqualTo: '${user.uid}')
        .getDocuments();
    num count  = await getUserCartCount(snapshot,user);
    setState(() {
      _count = count;
    });
    print('cart count: $_count');
    
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
                child: Center(
                    child: Text(
                  '$appTitle',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ))),
            SizedBox(width: 60.0),
            Stack(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductCart()));
                    }),
                Positioned(
                  right: 7,
                  top: 5,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: new BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$_count',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 8,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            )
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
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductPicPage(
                            image: widget.image,
                          )));
                },
                child: Container(
                  padding: EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 20.0),
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.image), fit: BoxFit.fill)),
                ),
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
                        IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                _quantity = _quantity + 1;
                              });
                            }),
                        //SizedBox(height: 10.0),
                        Text('$_quantity'),
                        //SizedBox(height: 10.0),
                        IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                _quantity = _quantity - 1;
                              });
                            })
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
                  ScopedModelDescendant<MainService>(
                    builder: (BuildContext context, Widget child,
                        MainService model) {
                      return IconButton(
                          icon: Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            model.uploadUserCart(
                                widget.user.uid,
                                widget.name,
                                widget.description,
                                widget.price,
                                widget.discount,
                                _quantity == 0 ? '1' : '$_quantity',
                                //docId,
                                widget.image);
                          });
                    },
                  ),
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
