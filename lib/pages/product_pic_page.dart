import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ProductPicPage extends StatefulWidget {
  final String image;

  ProductPicPage({this.image});

  @override
  _ProductPicPageState createState() => _ProductPicPageState();
}

class _ProductPicPageState extends State<ProductPicPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.redAccent,
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          backgroundColor: Colors.transparent,
          body: Container(
            margin: EdgeInsets.only(top: 50.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.transparent,
                // backgroundBlendMode: BlendMode.clear,
                image: DecorationImage(
                    image: NetworkImage(widget.image), fit: BoxFit.fill)),
            child: Container(
              height: 50.0,
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.baseline,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.share), onPressed: () => share(context,widget.image),


                  )
                ],
              ),
            ),
            //child: ,
          ),
        ),
      ),
    );
  }

  void share(BuildContext context, String image) {

    Share.share(image);
  }
}
