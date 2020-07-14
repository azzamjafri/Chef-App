import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Service/authentication.dart';

import 'colors.dart';

void main(){
  runApp(Recipe());
}

class Recipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Recipe',
        theme: ThemeData(
          primarySwatch: redColor,
          visualDensity: VisualDensity.adaptivePlatformDensity
        ),
        home: AuthService().handleAuth(),
      ),
    );
  }
}

