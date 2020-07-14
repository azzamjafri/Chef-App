import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:recipe_app/HomePage/login.dart';
import 'package:recipe_app/Service/authentication.dart';
import 'package:recipe_app/colors.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String email = '', password = '', confirmPassword = '', userName = '';
  String error = '';
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      key: _key,
      body: SingleChildScrollView(
        child: new Stack(

          children: <Widget>[

            new Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: new Image.asset('assets/background.png', fit: BoxFit.fill,),
            ),

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    // Login Button
                    Align(

                        child: new FlatButton(onPressed: (){
                          Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => Login()), (route) => false);
                        }, child: new Text('Login', style: TextStyle(color: redColor, fontSize: 23.0,),)),
                      alignment: Alignment.topRight,
                    ),

                    // Center Logo

                    new Container(
                      height: 125.0,
                      width: 125.0,
                      child: new Image.asset('assets/1.png', fit: BoxFit.fill,),
                    ),

                    Padding(padding: EdgeInsets.only(top: 15.0),),

                    new Text('Register', style: TextStyle(color: Colors.black, fontSize: 32.0, letterSpacing: 1.2, fontWeight: FontWeight.bold),),

                    Padding(padding: EdgeInsets.only(top: 22.0),),

                    // User Name field

                    Container(
                      height: 55.0,
                      width: MediaQuery.of(context).size.width / 1.35,
                      child: new TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: BorderSide(color: Colors.grey[200], width: 1.8,),
                          ),

                          prefixIcon: Icon(Icons.person),
                          hintText: 'User Name',
                          fillColor: Colors.white,
                          filled: true,
                        ),

                        onChanged: (val) {
                          setState(() => userName = val);
                        },

                        validator: (val) => val.isEmpty ? 'User name can not be empty' : null,
                      ),
                    ),

                    Padding(padding: EdgeInsets.only(top: 24.0),),
                    // Email Button

                    Container(
                      height: 55.0,
                      width: MediaQuery.of(context).size.width / 1.35,
                      child: new TextFormField(
                        textAlign: TextAlign.center,
                        
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: BorderSide(color: Colors.grey[200], width: 1.8,),
                          ),

                          prefixIcon: Icon(Icons.email),
                          hintText: 'Email',
                          fillColor: Colors.white,
                          filled: true,

                        ),
                        onChanged: (val) {
                          setState(() {
                            val.trim();
                            email = val;
                          });
                        },

                        validator: (val) => val.isEmpty ? 'Enter an email' : null,

                      ),
                    ),

                    Padding(padding: EdgeInsets.only(top: 24.0),),
                    // Password Button

                    Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width / 1.35,
                      child: new TextFormField(

                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),  
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: BorderSide(color: Colors.grey[200], width: 1.8,),
                          ),
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Password',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        obscureText: true,
                        onChanged: (val) {

                          password = val;
                        },

                        validator: (val) => val.length < 6 ? 'Enter a password atleast 6 chars long' : null,
                      ),
                    ),

                    Padding(padding: EdgeInsets.only(top: 24.0),),
                    // Confirm Password Button

                    Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width / 1.35,
                      child: new TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: BorderSide(color: Colors.grey[200], width: 1.8,),
                          ),
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Confirm Password',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            confirmPassword = val;
                          });

                        },
                        validator: (val) => val != password ? 'Passwords doesn\'t match' : null,
                      ),
                    ),

                    // Register Button
                    Padding(padding: EdgeInsets.only(top: 35.0),),

                    Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width / 1.30,
                      child: new FlatButton(onPressed: () async {
                        if(_formKey.currentState.validate()){
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password).then((value) async {

                            var user = await FirebaseAuth.instance.currentUser();
                            print(user.uid + '&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&\n\n');
                            DocumentReference docRef = Firestore.instance.collection('users').document(user.uid);
                            docRef.setData({
                              'name' : userName,
                              'email': email,
                              'uid': docRef.documentID,
                              'favourites': [],
                            });
                          }).then((value) {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);
                          });
                          if(result == null) {
                            (error == '') ?
                            _key.currentState.showSnackBar(SnackBar(content: new Text('Something went wrong, please supply a valid email'), duration: Duration(seconds: 5),))
                            :
                            _key.currentState.showSnackBar(SnackBar(content: new Text(error), duration: Duration(seconds: 5),));
                          }
                          
                        }

                      },
                        child: new Text('Register', style: TextStyle(color: Colors.white, fontSize: 32.0, fontFamily: 'Arial'),),
                        color: redColor,
                        shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                      ),
                    ),

//                  Padding(padding: EdgeInsets.only(bottom: 40.0),),


                  ],
                ),
              ),
            )

          ],

        ),
      ),
    );
  }
}
