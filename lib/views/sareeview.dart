// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
//import 'package:testapp1/models/product_model.dart';
import 'package:testapp1/services/main_service.dart';
import 'package:testapp1/widgets/drawer_widget.dart';
// import 'package:testapp1/widgets/product_card.dart';
import 'package:testapp1/widgets/product_list_widget.dart';
import 'package:testapp1/widgets/searchbar_widget.dart';

class SareePage extends StatefulWidget {
  static const String id = 'SareePage';

  @override
  _SareePageState createState() => _SareePageState();
}

class _SareePageState extends State<SareePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: ScopedModelDescendant<MainService>(
      builder: (BuildContext context, Widget child, MainService model) {
        print(model.products);
        return RefreshIndicator(
          onRefresh: () {
            setState(() {
              
            });
            return Future.delayed(Duration(milliseconds: 3000));
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red,
              elevation: 0.0,
              // leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: null),
              actions: <Widget>[
                //IconButton(icon: Icon(Icons.arrow_back), onPressed: null),

                IconButton(
                    icon: Icon(Icons.settings_power),
                    onPressed: () {
                      model.signOut();
                    })
              ],
            ),
            drawer: MyDrawer(),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 140,
                    ),
                    Text(
                      'Sarees',
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
                  height: 20.0,
                ),
                Expanded(
                  child: ProductListView(
                    category: 'Saree',
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        );
      },
    ));
  }
}
