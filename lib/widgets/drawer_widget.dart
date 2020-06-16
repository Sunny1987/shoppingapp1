//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:testapp1/admin/add_product_admin.dart';
import 'package:testapp1/models/user_model.dart';
import 'package:testapp1/services/main_service.dart';
import 'package:testapp1/views/blouseview.dart';
import 'package:testapp1/views/favouriteview.dart';
import 'package:testapp1/views/sareeview.dart';
import 'package:testapp1/views/topview.dart';
import 'package:testapp1/views/trouserview.dart';
//import 'package:testapp1/pages/favourite_page.dart';
//import 'package:testapp1/views/favourite.dart';
//import 'package:testapp1/services/main_service.dart';

class MyDrawer extends StatefulWidget {
  // final MainService model;
  // MyDrawer({this.model});
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  AppUser user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(user.uid);
    user = Provider.of<AppUser>(context);
    print(user.username);

    return Drawer(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ListView(
          children: <Widget>[
            Conditional.single(
              context: context,
              conditionBuilder: (BuildContext context) =>
                  (user.username == 'Madhu_Admin') ||
                  (user.username == 'Sunny_Admin'),
              widgetBuilder: (BuildContext context) =>
                  AdminDrawerWidgets(user: user),
              fallbackBuilder: (BuildContext context) =>
                  UserDrawerWidgets(user: user),
            ),
          ],
        ),
      ),
    );
  }
}

class UserDrawerWidgets extends StatefulWidget {
  const UserDrawerWidgets({
    Key key,
    @required this.user,
  }) : super(key: key);

  final AppUser user;

  @override
  _UserDrawerWidgetsState createState() => _UserDrawerWidgetsState();
}

class _UserDrawerWidgetsState extends State<UserDrawerWidgets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //User widgets...
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              '${widget.user.username}',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
        //Divider(color: Colors.grey),

        // user tools...
        Container(
          //padding: EdgeInsets.symmetric(horizontal: 55.0),
          child: ExpansionTile(
            leading: Icon(
              Icons.category,
              color: Colors.blueAccent,
            ),
            title: Text('Categories'),
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, SareePage.id);
                  },
                  child: ListTile(
                    //leading: Icon(Icons.arrow_upward, color: Colors.blueAccent),
                    title: Text('Sarees'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, TopPage.id);
                  },
                  child: ListTile(
                    //leading: Icon(Icons.arrow_upward, color: Colors.blueAccent),
                    title: Text('Tops'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, BlousePage.id);
                  },
                  child: ListTile(
                    //leading: Icon(Icons.arrow_upward, color: Colors.blueAccent),
                    title: Text('Blouse'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, TrouserPage.id);
                  },
                  child: ListTile(
                    //leading: Icon(Icons.arrow_upward, color: Colors.blueAccent),
                    title: Text('Trousers'),
                  ),
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            leading: Icon(Icons.shopping_basket, color: Colors.blueAccent),
            title: Text('Order History'),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Favourite()));
          },
          child: ListTile(
            leading: Icon(Icons.favorite, color: Colors.blueAccent),
            title: Text('My Favourites'),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            leading: Icon(Icons.home, color: Colors.blueAccent),
            title: Text('My billing Address'),
          ),
        ),
        // ScopedModelDescendant<MainService>(
        //   builder: (BuildContext context, Widget child, MainService model) {
        //     return InkWell(
        //       onTap: () {
        //         model.signOut();
        //       },
        //       child: ListTile(
        //         leading: Icon(Icons.home, color: Colors.blueAccent),
        //         title: Text('Sign Out'),
        //       ),
        //     );
        //   },
        // ),

      ],
    );
  }
}

class AdminDrawerWidgets extends StatefulWidget {
  const AdminDrawerWidgets({
    Key key,
    @required this.user,
  }) : super(key: key);

  final AppUser user;

  @override
  _AdminDrawerWidgetsState createState() => _AdminDrawerWidgetsState();
}

class _AdminDrawerWidgetsState extends State<AdminDrawerWidgets> {
  //bool _isCatClicked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //Admin widgets...
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              '${widget.user.username}',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
        Divider(color: Colors.grey),

        //Admin tools...
        Container(
          //padding: EdgeInsets.symmetric(horizontal: 55.0),
          child: ExpansionTile(
            leading: Icon(
              Icons.cloud,
              color: Colors.blueAccent,
            ),
            title: Text('Admin Actions'),
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AddProduct.id);
                },
                child: ListTile(
                  leading: Icon(Icons.add, color: Colors.blueAccent),
                  title: Text('Add a Product'),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  leading: Icon(Icons.change_history, color: Colors.blueAccent),
                  title: Text('Update a Product'),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  leading: Icon(Icons.clear, color: Colors.blueAccent),
                  title: Text('Delete a Product'),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  leading: Icon(Icons.arrow_upward, color: Colors.blueAccent),
                  title: Text('Upload History'),
                ),
              )
            ],
          ),
        ),

        // user tools...
        Container(
          //padding: EdgeInsets.symmetric(horizontal: 55.0),
          child: ExpansionTile(
            leading: Icon(
              Icons.category,
              color: Colors.blueAccent,
            ),
            title: Text('Categories'),
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, SareePage.id);
                  },
                  child: ListTile(
                    //leading: Icon(Icons.arrow_upward, color: Colors.blueAccent),
                    title: Text('Sarees'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, TopPage.id);
                  },
                  child: ListTile(
                    //leading: Icon(Icons.arrow_upward, color: Colors.blueAccent),
                    title: Text('Tops'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, BlousePage.id);
                  },
                  child: ListTile(
                    //leading: Icon(Icons.arrow_upward, color: Colors.blueAccent),
                    title: Text('Blouse'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, TrouserPage.id);
                  },
                  child: ListTile(
                    //leading: Icon(Icons.arrow_upward, color: Colors.blueAccent),
                    title: Text('Trousers'),
                  ),
                ),
              )
            ],
          ),
        ),

        InkWell(
          onTap: () {},
          child: ListTile(
            leading: Icon(Icons.shopping_basket, color: Colors.blueAccent),
            title: Text('Order History'),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Favourite()));
          },
          child: ListTile(
            leading: Icon(Icons.favorite, color: Colors.blueAccent),
            title: Text('My Favourites'),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            leading: Icon(Icons.home, color: Colors.blueAccent),
            title: Text('My billing Address'),
          ),
        ),
        // ScopedModelDescendant<MainService>(
        //   builder: (BuildContext context, Widget child, MainService model) {
        //     return InkWell(
        //       onTap: () {
        //         model.signOut();
        //       },
        //       child: ListTile(
        //         leading: Icon(Icons.home, color: Colors.blueAccent),
        //         title: Text('Sign Out'),
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }
}
