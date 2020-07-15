import 'package:flutter/material.dart';
import 'package:recipe_app/Category/categories.dart';
import 'package:recipe_app/HomePage/forget_password.dart';
import 'package:recipe_app/HomePage/registration.dart';
import 'package:recipe_app/Service/authentication.dart';
import 'package:recipe_app/colors.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email = "";
  String password='';
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  final AuthService _auth = new AuthService();
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

                    // Register Button
                    Align(

                      child: new FlatButton(onPressed: (){
                        Navigator.push(context, new MaterialPageRoute(builder: (context) => Register()));
                      }, child: new Text('Register', style: TextStyle(color: redColor, fontSize: 23.0,),)),
                      alignment: Alignment.topRight,
                    ),

                    // Center Logo

                    new Container(
                      height: 125.0,
                      width: 125.0,
                      child: new Image.asset('assets/1.png', fit: BoxFit.fill,),
                    ),

                    Padding(padding: EdgeInsets.only(top: 15.0),),

                    new Text('Login', style: TextStyle(color: Colors.black, fontSize: 32.0, letterSpacing: 1.2, fontWeight: FontWeight.bold),),

                    Padding(padding: EdgeInsets.only(top: 22.0),),

                    // User Name field
                    

                    // Email Button

                    Container(
                      height: 70.0,
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
                            
                            email = val;
                            
                          });
                        },

                        validator: (val) => val.isEmpty ? 'Enter an email' : null,
                        
                      ),
                    ),

                    Padding(padding: EdgeInsets.only(top: 24.0),),
                    // Password Button

                    Container(
                      height: 65.0,
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
                          setState(() => password = val);
                        },

                        validator: (val) => val.length < 6 ? 'Enter a password atleast 6 chars long' : null,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 18.0),),
                    Align(
                        alignment: Alignment.centerRight,
                      child: new FlatButton(onPressed: (){
                        Navigator.push(context, new MaterialPageRoute(builder: (context) => ForgetPassword()));
                      },
                      child: new Text('Forget Password?', style: TextStyle(color: redColor, ),),),
                    ),


                    // Register Button
                    Padding(padding: EdgeInsets.only(top: 35.0),),

                    Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width / 1.30,
                      child: new FlatButton(onPressed: () async {

                        if(_formKey.currentState.validate()){
                          email = email.trim();
                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                          if(result == null) {
                            _key.currentState.showSnackBar(SnackBar(content: new Text('Something went wrong, please check credentials'),));
                          }else{

                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Category()), (route) => false);
                          }
                        }

                      },
                        child: new Text('Login', style: TextStyle(color: Colors.white, fontSize: 32.0, fontFamily: 'Arial'),),
                        color: redColor,
                        shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                      ),

                    ),

                // Padding(padding: EdgeInsets.only(bottom: 40.0),),

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
