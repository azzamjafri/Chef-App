import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Category/categories.dart';


import 'package:recipe_app/Service/authentication.dart';
import 'package:recipe_app/Subcategories/sub_categories.dart';

import '../colors.dart';



class Cart extends StatefulWidget {
  
  
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  
  List<String> favouriteName;

  


  var _filter = new TextEditingController();
  String _searchText = "";

  final AuthService _auth = new AuthService();

  var Cart;
  // bool isEmpty = true;
  @override
  void initState() {
    // if(favouriteName.isEmpty) isEmpty = true;
  //  print(isEmpty.toString() + ' ))))))))))))))))))))))))');
    
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: new EdgeInsets.all(10.0),
            ),
            title(),
            Padding(
              padding: new EdgeInsets.all(10.0),
            ),
            searchBar(),
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            favouriteTile(),
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[_buildList()],
            ),
            Padding(padding: EdgeInsets.all(8.0),),
          ],
        ),
      ),
    );
  }



  Widget _buildList() {
    
    // if(favouriteName.isEmpty) return Center(child: Text('No  Items  In  Cart  Yet', style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, letterSpacing: 2.0)));
    
    
    
     
    var streamData = Firestore.instance.collection('users').document(user.uid).collection('cart').snapshots();
    // var streamData = Firestore.instance.collection('categories').where('name', whereIn: favourites).snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: streamData,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error : ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: new Container(
                child: CircularProgressIndicator(),
              ),
            );
          default:
            final int count = snapshot.data.documents.length;
            // if(count == 0) print('000000000000000');
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: count,
              itemBuilder: (_, int index) {
                final DocumentSnapshot document =
                    snapshot.data.documents[index];

                return Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0.0),
                  child: GestureDetector(
                    
                    onTap: () => Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                SubCategory(document.documentID))),
                    child: new Card(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0)),
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              ClipRRect(
                                
                                child: Container(
                                  height: 110.0,
                                  width: MediaQuery.of(context).size.width / 2.2,
                                  child: Image.network(document['image'], fit: BoxFit.fill, scale: 5.0)),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(35.0),
                                    topRight: Radius.circular(35.0)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  child: GestureDetector(
                                    onTap: () {
                                      },
                                    child: Image.asset(
                                      'assets/redHeart.png',
                                      color: redColor
                                          
                                    ),
                                  ),
                                  alignment: Alignment.topRight,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12.0),
                          ),
                          Center(
                            child: Text(
                              // filtered_names[index]['name'],
                              document['name'],
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
        }
      },
    );
  }

  searchBar() {
    return Container(
      height: 55.0,
      width: MediaQuery.of(context).size.width / 1.2,
      child: new TextField(
        controller: _filter,
        decoration: new InputDecoration(
            hintText: 'Search',
            suffixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            )),
        onChanged: (val) {
          _filter.addListener(() {
            if (_filter.text.isEmpty) {
              setState(() {
                _searchText = "";
                // filtered_names = names;
              });
            } else {
              setState(() {
                _searchText = capitalize(_filter.text);
              });
            }
          });
        },
      ),
    );
  }

  favouriteTile() {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: new Container(
//              alignment: Alignment.centerLeft,
          height: 45.0,
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
            color: redColor,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Center(
              child: new Text(
            'Cart',
            style: TextStyle(color: Colors.white),
          )),
        ),
      ),
    );
  }

  title() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Container(
            height: 35.0,
            width: MediaQuery.of(context).size.width / 4.2,
            decoration: BoxDecoration(
              color: redColor,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
                child: FlatButton(
              child: new Text(
                'Back',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
               Navigator.pop(context);
              },
            )),
          ),
        ),
        new Spacer(),
        new Container(
          height: 100.0,
          width: 100.0,
          child: Image.asset(
            'assets/1.png',
          ),
        ),
        new Spacer(),
        // IconButton(icon: Icon(Icons.add_shopping_cart), onPressed: (){}),
        GestureDetector(
          onTap: () {
            
            favouriteName.forEach((element) => print(element + " :)"));
            setState(() {
              favouriteName = List.of(HashSet.from(favouriteName));  
            });
          },
          child: Container(
              child: Image.asset(
            'assets/heart.png',
            
            color: redColor,
            fit: BoxFit.fill,
          )),
        ),
      ],
    );
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
