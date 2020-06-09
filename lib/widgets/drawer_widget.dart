import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp1/admin/add_product_admin.dart';
import 'package:testapp1/models/user_model.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    print(user.uid);
   // print(Firestore.instance.collection('users').where('uid',isEqualTo: '${user.uid}').limit(1));

    Firestore.instance.collection('users').where('uid',isEqualTo: '${user.uid}').getDocuments().then((value){
      value.documents.map((e) {
        print(e.data['username']);
        });
      });
    
 // print(value);
    // Firestore.instance.collection('users').document('${user.uid}').get().then(
    //     (DocumentSnapshot) =>
    //         print(DocumentSnapshot.documentID));

    //getname();
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                'Sabyasachi Roy',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          Divider(color: Colors.grey),
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
          ),
          Divider(color: Colors.grey),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.shopping_basket, color: Colors.blueAccent),
              title: Text('Order History'),
            ),
          ),
          InkWell(
            onTap: () {},
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
        ],
      ),
    );
  }
}
