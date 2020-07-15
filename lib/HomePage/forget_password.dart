import 'package:flutter/material.dart';
import 'package:recipe_app/HomePage/login.dart';
import 'package:recipe_app/Service/authentication.dart';
import 'package:recipe_app/colors.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();


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
                    height: 65.0,
                    width: MediaQuery.of(context).size.width / 1.35,
                    child: new TextFormField(
                      controller: emailController,
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

//                   Container(
//                     height: 65.0,
//                     width: MediaQuery.of(context).size.width / 1.35,
//                     child: new TextFormField(
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                         suffix: new FlatButton(onPressed: (){

//                           AuthService().resetPassword(emailController.text.trim());

//                         }, child: new Text('Verify Email', style: new TextStyle(color: redColor),)),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(40.0),
//                           borderSide: BorderSide(color: Colors.grey[200], width: 1.8,),

//                         ),

// //                        prefixIcon: Icon(Icons.person),
//                         hintText: 'Enter the OTP',
//                         fillColor: Colors.white,
//                         filled: true,
//                       ),
//                     ),
//                   ),

                  // Padding(padding: EdgeInsets.only(top: 24.0),),


                  // // Password Button

                  // Container(
                  //   height: 65.0,
                  //   width: MediaQuery.of(context).size.width / 1.35,
                  //   child: new TextFormField(
                  //     controller: passwordController,
                  //     textAlign: TextAlign.center,
                  //     decoration: InputDecoration(
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(40.0),
                  //         borderSide: BorderSide(color: Colors.grey[200], width: 1.8,),
                          
                  //       ),
                        
                  //       prefixIcon: Icon(Icons.lock),
                  //       hintText: 'Password',
                  //       fillColor: Colors.white,
                  //       filled: true,
                  //       ),
                  //       obscureText: true,
                  //   ),
                  // ),

                  // Padding(padding: EdgeInsets.only(top: 24.0),),
                  // // Confirm Password Button

                  // Container(
                  //   height: 65.0,
                  //   width: MediaQuery.of(context).size.width / 1.35,
                  //   child: new TextFormField(
                  //     controller: confirmPasswordController,
                  //     textAlign: TextAlign.center,
                  //     decoration: InputDecoration(
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(40.0),
                  //         borderSide: BorderSide(color: Colors.grey[200], width: 1.8,),
                  //       ),
                  //       prefixIcon: Icon(Icons.lock),
                  //       hintText: 'Confirm Password',
                  //       fillColor: Colors.white,
                  //       filled: true,
                  //     ),
                  //     obscureText: true,
                  //   ),
                  // ),

                  // // Register Button
                  // Padding(padding: EdgeInsets.only(top: 35.0),),

                  Container(
                    height: 55.0,
                    width: MediaQuery.of(context).size.width / 1.30,
                    child: new FlatButton(onPressed: (){
                      AuthService().resetPassword(emailController.text.trim()).then((value) => showDialog());
                    },
                      child: Center(child: new Text('Request New Password', style: TextStyle(color: Colors.white, fontSize: 20.0, fontFamily: 'Arial'),)),
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

void showDialog() {
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 300,
          child: SizedBox.expand(child: Scaffold(body: Column(
            children: [
              Center(
                child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 10.0),
                child: Text('Please check your email id, we send you a confirmation link there to reset your password. Create a new password and login again with new password.', style: TextStyle(color: redColor, fontSize: 18.0, fontStyle: FontStyle.italic)),
              )),
              Padding(padding: EdgeInsets.all(35.0)),
              FlatButton(onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false),
                child: Text('Okay !', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)),
                color: redColor,
              )
            ],
          ))),
          margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}


}
