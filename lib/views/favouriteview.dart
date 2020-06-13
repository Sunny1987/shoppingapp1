import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp1/models/user_model.dart';
import 'package:testapp1/widgets/favourite_list_widget.dart';
// import 'package:testapp1/widgets/favourite_list_widget%20copy.dart';
// import 'package:testapp1/widgets/favourite_list_widget%20copy.dart';
// import 'package:testapp1/widgets/product_list_widget.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {


  @override
  Widget build(BuildContext context) {
     AppUser user = Provider.of<AppUser>(context);
     print('user in fav: ${user.uid}');
     
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 110,
              ),
              Center(
                child: Text(
                  'My Favourites',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: MyFavouriteListView(
              uid: user.uid
            ),
          ),
        ],
      )),
    );
  }
}
