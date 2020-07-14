import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Category/favourites_list.dart';

import 'package:recipe_app/HomePage/login.dart';
import 'package:recipe_app/Service/authentication.dart';
import 'package:recipe_app/Subcategories/sub_categories.dart';

import '../colors.dart';

// filteredNames, searchText, name

String currentDocId;

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  var _filter = new TextEditingController();
  String _searchText = "";

  final AuthService _auth = new AuthService();

  var favouriteName;
  var user;
  @override
  void initState() {
    
    favouriteName = new List<String>();
    print(Firestore.instance.collection('categories').snapshots());
    getDocId();
    
    super.initState();
  }

  getDocId() async {
    user =  await FirebaseAuth.instance.currentUser();
    // print('User - ' + user.uid);
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

            categoryTile(),

            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[_buildList()],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    // if (_searchText.isNotEmpty) {
    //   List tempList = new List();
    //   for (var i in filtered_names) {
    //     if (i['name'].toLowerCase().contains(_searchText.toLowerCase()))
    //       tempList.add(i);
    //   }
    //   filtered_names = tempList;
    // }

    // DO NOT TOUCH  request.time < timestamp.date(2020, 7, 8);

    var streamData;
    if (_searchText == "")
      streamData = Firestore.instance.collection('categories').snapshots();
    else {
      streamData = Firestore.instance
          .collection('categories')
          .orderBy('name')
          .startAt([_searchText])
          .snapshots();
    }

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
                    
                    onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => SubCategory(document.documentID))),
                    child: new Card(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0)),
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              ClipRRect(
                                // child: Image.asset('assets/category_images/bagel.jpg',fit: BoxFit.fill,),
                                child: Container(
                                  height: 110.0,
                                  width: MediaQuery.of(context).size.width / 2.2,
                                  child: Image.network(document['image'], fit: BoxFit.fill,)),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(35.0),
                                    topRight: Radius.circular(35.0)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  child: GestureDetector(
                                    onTap: () {

                                      Firestore.instance.collection('users').document(user.uid).updateData({
                                        'favourites': FieldValue.arrayUnion([document['name']]),
                                      });
                                      print('adding category....');
                                      setState(() {
                                        // favouriteName.contains(document['name']) ?
                                        // favouriteName.remove(document['name'])
                                        // :
                                        // favouriteName.add(document['name']);  
                                      });
                                      
                                    },
                                    child: Image.asset(
                                      favouriteName.contains(document['name']) ?
                                      'assets/redHeart.png' :
                                      'assets/heart.png',
                                      color: redColor,
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

  categoryTile() {
    return Padding(
      padding: const EdgeInsets.only(left : 35.0, right: 35.0),
      child: Row(
        children: [
          new Container(
            height: 45.0,
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
              color: redColor,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
                child: new Text(
              'Category',
              style: TextStyle(color: Colors.white),
            )),
          ),
          Spacer(),
          
          new Container(
            height: 45.0,
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
              color: redColor,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
                child: new Text(
              'Notifications',
              style: TextStyle(color: Colors.white),
            )),
          ),
        ],
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
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _auth.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    new MaterialPageRoute(builder: (context) => Login()),
                    (route) => false);
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
        IconButton(icon: Icon(Icons.add_shopping_cart), onPressed: (){}),
        GestureDetector(
          onTap: () async {

            getFavouriteList();
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

    getFavouriteList() async {
    var user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('users').document(user.uid).get().then((value) {
      favouriteName = value.data['favourites'];
      favouriteName.forEach((el) => print(el));
    }).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => new Favourites(List.of(HashSet.from(favouriteName)))));
    });
    // favouriteName =  doc['favourites'];
  }
}
