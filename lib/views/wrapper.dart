import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:testapp1/models/user_model.dart';
import 'package:testapp1/pages/authentication_page.dart';
import 'package:testapp1/pages/homepage_page.dart';
import 'package:testapp1/services/main_service.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    print('user: $user');
    return user == null
        ? AuthenticatePage()
        : ScopedModelDescendant<MainService>(
            builder: (BuildContext context, Widget child, MainService model) {
              return HomePageScreen(model: model,);
            },
          );
  }
}
