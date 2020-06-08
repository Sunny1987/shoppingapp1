import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:testapp1/services/main_service.dart';

class ImageCapture extends StatefulWidget {
  static const String id = 'ImageCapture';

  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

enum AppState { free, picked, cropped }

class _ImageCaptureState extends State<ImageCapture> {
  File imageFile;
  AppState state;

  Future<Null> _pickImage(ImageSource source) async {
    imageFile = await ImagePicker.pickImage(source: source);

    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
      });
    }
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
    );

    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  void _clearImage() {
    imageFile = null;
    setState(() {
      state = AppState.free;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.camera),
                onPressed: () => _pickImage(ImageSource.camera)),
            IconButton(
                icon: Icon(Icons.photo_library),
                onPressed: () => _pickImage(ImageSource.gallery)),
          ],
        ),
      ),
      body: imageFile != null
          ? Column(
              children: <Widget>[
                imageFile != null ? Image.file(imageFile) : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      child: Icon(Icons.crop),
                      onPressed: () {
                        _cropImage();
                      },
                    ),
                    FlatButton(
                        child: Icon(Icons.refresh),
                        onPressed: () {
                          _clearImage();
                        }),
                    ScopedModelDescendant<MainService>(
                      builder: (BuildContext context, Widget child,
                          MainService model) {
                        return FlatButton(
                            onPressed: () {
                              model.setImageFile(imageFile);
                              Navigator.pop(context);
                            }, child: Icon(Icons.check));
                      },
                    )
                  ],
                ),
              ],
            )
          : Container(),
    );
  }
}
