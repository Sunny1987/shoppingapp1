//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:testapp1/admin/image_capture.dart';
import 'package:testapp1/services/main_service.dart';

class AddProduct extends StatefulWidget {
  static const String id = 'AddProduct';

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String name, description, price, discount,category= 'Saree';
  GlobalKey<FormState> _globalFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainService>(
      builder: (BuildContext context, Widget child, MainService model) {
        return SafeArea(
          child: model.isLoading?
            SpinKitChasingDots():
            Scaffold(
            key: _scaffoldStateKey,
            body: ListView(
              children: <Widget>[
                SizedBox(height: 20.0),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 130.0,
                    ),
                    Text(
                      'Add Product',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Form(
                      key: _globalFormKey,
                      child: ListView(
                        children: <Widget>[
                          ScopedModelDescendant<MainService>(
                            builder: (BuildContext context, Widget child,
                                MainService model) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ImageCapture.id);
                                  },
                                  child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 90.0),
                                      height: 190.0,
                                      width: 40.0,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          image: DecorationImage(
                                              image: model.imageFile != null
                                                  ? FileImage(model.imageFile)
                                                  : AssetImage(
                                                      "assets/images/images.jpg"),
                                              fit: BoxFit.cover))));
                            },
                          ),
                          SizedBox(height: 20.0),
                          _buildTextField(
                            'Saree Name',
                          ),
                          _buildTextField(
                            'Saree Description',
                          ),
                         _dropDownData(),
                          _buildTextField(
                            'Saree price',
                          ),
                          _buildTextField(
                            'Saree discount',
                          ),
                          SizedBox(height: 20.0),
                          ScopedModelDescendant<MainService>(
                            builder: (BuildContext context, Widget child,
                                MainService model) {
                              return GestureDetector(
                                onTap: () {
                                  onSubmitUpload(model);
                                },
                                child: UploadButton(
                                  bText: 'Upload',
                                ),
                              );
                            },
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onSubmitUpload(MainService model) async {
    if (_globalFormKey.currentState.validate()) {
      _globalFormKey.currentState.save();
      print('Name: $name');
      print('Description: $description');
      print('price: $price');
      print('discount: $discount');
      print('upload pressed');
      print('category: $category');

      //call the firebase method
      var status = await model.uploadAllDataToFirebase(
          model.imageFile, name, description, price, discount,category);

      if (status) {
        SnackBar snackBar =
            SnackBar(content: Text("Product item successfully added."));
        _scaffoldStateKey.currentState.showSnackBar(snackBar);
        Navigator.pop(context);
      } else {
        SnackBar snackBar =
            SnackBar(content: Text("Product item upload failed."));
        _scaffoldStateKey.currentState.showSnackBar(snackBar);
      }
    }
  }

  Widget _buildTextField(String sareeText) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: sareeText,
        ),
        maxLines: 1,
        keyboardType:
            (sareeText == 'Saree price') || (sareeText == 'Saree discount')
                ? TextInputType.number
                : TextInputType.text,
        validator: (String value) {
          //var errorMsg = '';
          if (value.isEmpty && sareeText == 'Saree Name') {
            return 'Saree name cannot be empty';
          }
          if (value.isEmpty && sareeText == 'Saree Description') {
            return 'Saree Description cannot be empty';
          }
          if (value.isEmpty && sareeText == 'Saree price') {
            return 'Saree price cannot be empty';
          }
          //return errorMsg;
        },
        onSaved: (String value) {
          if (sareeText == 'Saree Name') {
            name = value.trim();
          }
          if (sareeText == 'Saree Description') {
            description = value.trim();
          }
          if (sareeText == 'Saree price') {
            price = value.trim();
          }
          if (sareeText == 'Saree discount') {
            discount = value.trim();
          }
        },
      ),
    );
  }

  Widget _dropDownData(){

    //String category1 = 'Sarees';
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      child: DropdownButton<String>(
        value: category,
        items: <String>['Saree','Blouse','Trouser','Top'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
              );
        }).toList(), 
        icon: Icon(Icons.arrow_downward),
        iconSize: 20.0,
        elevation: 10,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 18.0
        ),
      //   underline: Container(
      //   height: 2,
      //   color: Colors.grey,
      // ),
        onChanged: (String newvalue) {
          setState(() {
            category = newvalue;
          });
            
        }),
    );
  }

}

class UploadButton extends StatelessWidget {
  final String bText;
  UploadButton({this.bText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      height: 60.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), color: Colors.grey),
      child: Center(
          child: Text(
        bText,
        style: TextStyle(
            color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
      )),
    );
  }
}
