import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  final String image;
  final String name;
  final String quantity;
  final String price;
  final String discount;

  CartItem({this.image, this.name, this.price, this.discount, this.quantity});

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.width * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.image),
          ),
          title: Text(widget.name),
          subtitle: Text(widget.price),
          trailing: Container(
            height: 50.0,
            width: 150.0,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(icon: Icon(Icons.add), onPressed: () {}),
                Text('${widget.quantity.toString()}'),
                //SizedBox(height: 10.0),
                IconButton(icon: Icon(Icons.remove), onPressed: () {}),
                //IconButton(icon: Icon(Icons.remove), onPressed: () {})
              ],
            ),
          ),
          //NetworkImage(widget.image),
        ),
      ),
    );
  }
}
