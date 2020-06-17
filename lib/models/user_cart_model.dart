import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  String name;
  String description;
  String price;
  String discount;
  String image;
  String quantity;
  //String category;
  DocumentReference refernce;

  Cart({
    this.name, 
    this.description,
    this.price,
    this.discount,
    this.quantity,
    this.image,
    //this.category
    });

  Cart.fromMap(Map<String, dynamic> map, {this.refernce})
      : name = map['name'],
        description = map['description'],
        price = map['price'],
        discount = map['discount'],
        quantity = map['quantity'],
        //category = map['category'],
        image = map['image'];

  Cart.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, refernce: snapshot.reference);
}
