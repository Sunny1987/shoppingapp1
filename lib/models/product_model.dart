import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String name;
  String description;
  String price;
  String discount;
  String image;
  DocumentReference refernce;

  Product({this.name, this.description, this.price, this.discount, this.image});

  Product.fromMap(Map<String, dynamic> map, {this.refernce})
      : name = map['name'],
        description = map['description'],
        price = map['price'],
        discount = map['discount'],
        image = map['imageurl'];

  Product.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, refernce: snapshot.reference);
}
