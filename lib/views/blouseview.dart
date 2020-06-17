// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:testapp1/models/favoutites_model.dart';
import 'package:testapp1/models/user_model.dart';
import 'package:testapp1/pages/homepage_page.dart';
import 'package:testapp1/pages/product_cart.dart';
//import 'package:testapp1/models/product_model.dart';
import 'package:testapp1/services/main_service.dart';
import 'package:testapp1/style/mystrings.dart';
import 'package:testapp1/widgets/drawer_widget.dart';
// import 'package:testapp1/widgets/product_card.dart';
import 'package:testapp1/widgets/product_list_widget.dart';
import 'package:testapp1/widgets/searchbar_widget.dart';

class BlousePage extends StatefulWidget {
  static const String id = 'BlousePage';

  @override
  _BlousePageState createState() => _BlousePageState();
}

class _BlousePageState extends State<BlousePage>
    with SingleTickerProviderStateMixin {
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
  void didChangeDependencies() async {
    super.didChangeDependencies();
    AppUser user = Provider.of<AppUser>(context);
    final snapshot = await Firestore.instance
        .collection('user_cart')
        .where('id', isEqualTo: '${user.uid}')
        .getDocuments();
    num count = await getUserCartCount(snapshot, user);
    setState(() {
      _count = count;
    });
    print('cart count: $_count');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: ScopedModelDescendant<MainService>(
      builder: (BuildContext context, Widget child, MainService model) {
        print(model.products);
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
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
                      appTitle,
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
                      'Blouses',
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
                SearchBar(
                  searchText: 'Search for a blouse',
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: ProductListView(
                    category: 'Blouse',
                  ),
                )
              ],
            ),
          ),
        );
      },
    ));
  }
}
