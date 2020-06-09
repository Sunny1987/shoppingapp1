import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:testapp1/services/main_service.dart';
import 'package:testapp1/views/blouseview.dart';
import 'package:testapp1/views/sareeview.dart';
import 'package:testapp1/views/topview.dart';
import 'package:testapp1/views/trouserview.dart';
import 'package:testapp1/widgets/drawer_widget.dart';

class HomePageScreen extends StatefulWidget {
  static const String id = 'HomePage';
  final MainService model;
  HomePageScreen({this.model});
  

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.settings_power), onPressed: () {
              widget.model.signOut();
            })
          ],
        ),
        drawer: MyDrawer(),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 50.0, top: 20.0),
              child: Text(
                'Indian Saree Variety',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SareePage.id);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10.0, right: 40.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    //padding: EdgeInsets.only(left: 10.0),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                        // color: Colors.grey.withOpacity(0.5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5.0,
                              offset: Offset(5.0, 5.0)),
                        ],
                        image: DecorationImage(
                          image: AssetImage('assets/images/saree.jpg'),
                          fit: BoxFit.cover,
                        )),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration:
                          BoxDecoration(color: Colors.grey.withOpacity(0.5)),
                      child: Center(
                        child: Text(
                          "Sarees",
                          style: TextStyle(
                              color: Colors.white60,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, TopPage.id);
              },
              child: Container(
                margin: EdgeInsets.only(left: 40.0, right: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    //padding: EdgeInsets.only(left: 10.0),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                        //color: Colors.grey.withOpacity(0.3),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5.0,
                              offset: Offset(5.0, 5.0)),
                        ],
                        image: DecorationImage(
                          image: AssetImage('assets/images/tops.jpg'),
                          fit: BoxFit.cover,
                        )),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration:
                          BoxDecoration(color: Colors.grey.withOpacity(0.5)),
                      child: Center(
                        child: Text(
                          "Tops",
                          style: TextStyle(
                              color: Colors.white60,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),

            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, BlousePage.id);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10.0, right: 40.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    //padding: EdgeInsets.only(left: 10.0),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                        //color: Colors.grey.withOpacity(0.3),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5.0,
                              offset: Offset(5.0, 5.0)),
                        ],
                        image: DecorationImage(
                          image: AssetImage('assets/images/blouse.jpg'),
                          fit: BoxFit.cover,
                        )),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration:
                          BoxDecoration(color: Colors.grey.withOpacity(0.5)),
                      child: Center(
                        child: Text(
                          "Blouse",
                          style: TextStyle(
                              color: Colors.white60,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),

            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, TrouserPage.id);
              },
              child: Container(
                margin: EdgeInsets.only(left: 40.0, right: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    //padding: EdgeInsets.only(left: 10.0),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                        //color: Colors.grey.withOpacity(0.3),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5.0,
                              offset: Offset(5.0, 5.0)),
                        ],
                        image: DecorationImage(
                          image: AssetImage('assets/images/trouser_1.jpg'),
                          fit: BoxFit.cover,
                        )),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration:
                          BoxDecoration(color: Colors.grey.withOpacity(0.5)),
                      child: Center(
                        child: Text(
                          "Trousers",
                          style: TextStyle(
                              color: Colors.white60,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
