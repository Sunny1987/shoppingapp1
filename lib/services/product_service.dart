import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter/foundation.dart';
//import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:testapp1/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import '../data/product_data.dart';

class ProductService extends Model {
  List<Product> _products = [];
  File _imageFile;
  bool _isLoading = false;

  List<Product> get products {
    return _products;
  }

  bool get isLoading {
    return _isLoading;
  }

  Stream<QuerySnapshot> fetchProducts()  {
    // _products = my_products;
    // print(_products);
    // print(my_products);

    Stream<QuerySnapshot> snapshot =
         Firestore.instance.collection('sarees').snapshots();
         notifyListeners();

    return snapshot;
  }


  void setImageFile(File image) {
    _imageFile = image;
    notifyListeners();
  }

  File get imageFile {
    return _imageFile;
  }

  Future<bool> uploadAllProductDataToFirebase(File imageFile, String name,
      String description, String price, String discount, String category) async {
    //call uploadImage function
    _isLoading = true;

    print(imageFile);
    print(name);
    print(_isLoading);

    var imageLocation = await uploadImage(imageFile);
    var status = await uploadProductToDatabase(
        imageLocation, name, description, price, discount,category);
    _isLoading = false;
    if (status) {
      //_isLoading = false;
      return Future.value(true);
    } else {
      //_isLoading = false;
      return Future.value(false);
    }
  }

  Future<String> uploadImage(File imageFile) async {
    try {
      //make image number random
      int randomNumber = Random().nextInt(100000);
      String imageLocation = '/images/image${randomNumber}.jpg';

      //upload image to firebase
      final StorageReference storageReference =
          FirebaseStorage().ref().child(imageLocation);
      final StorageUploadTask uploadTask = storageReference.putFile(imageFile);
      await uploadTask.onComplete;
      return Future.value(imageLocation);
    } catch (e) {
      print(e.toString());
      return Future.value(null);
    }
  }

  Future<bool> uploadProductToDatabase(var imageLocation, String name,
      String description, String price, String discount,String category) async {
    try {
      // imageLocation.then((str) async{
      var ref = await FirebaseStorage().ref().child(imageLocation);
      var imageString = await ref.getDownloadURL();

      await Firestore.instance.collection('sarees').document().setData({
        'name': name,
        'description': description,
        'category': category,
        'price': price,
        'discount': discount,
        'imageurl': imageString,
        'createdAt' : FieldValue.serverTimestamp()
      });
      // });

      return Future.value(true);
    } catch (e) {
      print(e.message);

      return Future.value(false);
    }
  }


}
