import 'package:flutter/material.dart';
import 'package:recipe_app/colors.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

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
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  // Login Button

                  // Center Logo

                  new Container(
                    height: 125.0,
                    width: 125.0,
                    child: new Image.asset('assets/1.png', fit: BoxFit.fill,),
                  ),

                  Padding(padding: EdgeInsets.only(top: 15.0),),

                  new Text('Forget Password', style: TextStyle(color: Colors.black, fontSize: 32.0, letterSpacing: 1.2, fontWeight: FontWeight.bold),),

                  Padding(padding: EdgeInsets.only(top: 22.0),),




                  // Email Button

                  Container(
                    height: 45.5,
                    width: MediaQuery.of(context).size.width / 1.35,
                    child: new TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(color: Colors.grey[200], width: 1.8,),
                        ),

                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                        fillColor: Colors.white,
                        filled: true,

                      ),
                    ),
                  ),

                  Padding(padding: EdgeInsets.only(top: 24.0),),

                  Container(
                    height: 45.5,
                    width: MediaQuery.of(context).size.width / 1.35,
                    child: new TextField(

                      
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        suffix: new FlatButton(onPressed: (){}, child: new Text('Resend OTP', style: new TextStyle(color: redColor),)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(color: Colors.grey[200], width: 1.8,),

                        ),

//                        prefixIcon: Icon(Icons.person),
                        hintText: 'Enter the OTP',
                        fillColor: Colors.white,
                        filled: true,


                      ),
                    ),
                  ),

                  Padding(padding: EdgeInsets.only(top: 24.0),),


                  // Password Button

                  Container(
                    height: 45.5,
                    width: MediaQuery.of(context).size.width / 1.35,
                    child: new TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(color: Colors.grey[200], width: 1.8,),
                          
                        ),
                        
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Password',
                        fillColor: Colors.white,
                        filled: true,
                        
                      ),
                    ),
                  ),

                  Padding(padding: EdgeInsets.only(top: 24.0),),
                  // Confirm Password Button

                  Container(
                    height: 45.5,
                    width: MediaQuery.of(context).size.width / 1.35,
                    child: new TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: BorderSide(color: Colors.grey[200], width: 1.8,),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Confirm Password',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),

                  // Register Button
                  Padding(padding: EdgeInsets.only(top: 35.0),),

                  Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width / 1.30,
                    child: new FlatButton(onPressed: (){},
                      child: new Text('Register', style: TextStyle(color: Colors.white, fontSize: 32.0, fontFamily: 'Arial'),),
                      color: redColor,
                      shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                    ),
                  ),

//                  Padding(padding: EdgeInsets.only(bottom: 40.0),),


                ],
              ),
            )

          ],

        ),
      ),
    );
  }
}
