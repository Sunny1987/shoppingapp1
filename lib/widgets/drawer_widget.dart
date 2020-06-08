import 'package:flutter/material.dart';
import 'package:testapp1/admin/add_product_admin.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AddProduct.id);
            },
            child: ListTile(
              leading: Icon(Icons.add),
              title: Text('Add a Product'),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.shopping_basket),
              title: Text('Order History'),
            ),
          ),
        ],
      ),
    );
  }
}