import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:testapp1/models/product_model.dart';
import 'package:testapp1/services/main_service.dart';
import 'package:testapp1/widgets/drawer_widget.dart';
import 'package:testapp1/widgets/product_card.dart';
import 'package:testapp1/widgets/searchbar_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List<Product> _products = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: ScopedModelDescendant<MainService>(
      builder: (BuildContext context, Widget child, MainService model) {
        print(model.products);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.settings_power), onPressed: () {})
            ],
          ),
          drawer: MyDrawer(),
          body: ListView(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 150.0,
                  ),
                  Text(
                    'Explore',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              SearchBar(),
              SizedBox(
                height: 10.0,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('sarees').snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (!snapshot.hasData) {
                    return LinearProgressIndicator();
                  } else {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height  ,
                      child: _buildSnapshot(context, snapshot.data.documents)
                      );
                  }
                },
              ),
            ],
          ),
        );
      },
    ));
  }
}

Widget _buildSnapshot(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
  //padding: const EdgeInsets.only(top: 20.0),
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
