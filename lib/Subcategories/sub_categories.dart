import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:recipe_app/ProductDetails/product_details.dart';
import 'package:recipe_app/colors.dart';

// String category;
String docId;

class SubCategory extends StatefulWidget {
  String reference;
  SubCategory(String document) {
    reference = document;

  }

  @override
  _SubCategoryState createState() => _SubCategoryState(reference);
}

class _SubCategoryState extends State<SubCategory> {
  
  _SubCategoryState(String docx) {
    docId = docx;
    // print(docId + ' **********************************');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: new EdgeInsets.all(30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                //BackButton

                Align(
                  child: FlatButton(
                    child: Icon(Icons.keyboard_backspace,
                        size: 40, color: Colors.grey[500]),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  alignment: Alignment.topLeft,
                ),
                //Heading
                Text(
                  "Category Topic",
                  style: TextStyle(
                    color: Colors.red[800],
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            _getList(),
          ],
        ),
      ),
    );
  }

  _getList() {
    
    if(docId == null) return Center(child: Text('No Data here :)'));
    return StreamBuilder<QuerySnapshot>(
      
      stream: Firestore.instance
          .collection('categories')
          .document('$docId')
          .collection('dishes')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        
        if (!snapshot.hasData) return Column(children: [
          Center(child: Text('Fetching Data .....', style: TextStyle(fontSize: 17.0, fontStyle: FontStyle.italic)), heightFactor: 15.0,),
          Center(child: CircularProgressIndicator()),
        ],);

        final int count = snapshot.data.documents.length;
        if (count == 0)
          return Center(
            child: new Text(
              'No items in this category :)',
              style: TextStyle(fontSize: 18.5, fontWeight: FontWeight.bold),
            ),
            heightFactor: 10.0,
          );

        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: count,
          itemBuilder: (_, int index) {
            final DocumentSnapshot document = snapshot.data.documents[index];

            return Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        
                        child: Image.network(document['images'][0], fit: BoxFit.cover, width: 115, height: 130.0,),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0)),
                      ),
                      SizedBox(width: 8.5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                          ),
                          Text("${document['name']}",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w800),
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 10)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Ingredients",
                                style: TextStyle(
                                    color: redColor, fontSize: 15.0),
                              ),
                              SizedBox(
                                width: (MediaQuery.of(context).size.width / 2 - 120),
                              ),
                              Text(
                                "Qty",
                                style: TextStyle(
                                  color: redColor,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 10)),
                          Row(
                            children: <Widget>[
                              Text(
                                "${document['ingredient_names'][0]}",
                                // ingredients[index],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(
                                width: (MediaQuery.of(context).size.width / 3 - 100),
                              ),
                              Text(
                                "${document['ingredients_qty'][0]}",
                                // quantity[index],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 12.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 90.0, top: 15.0)),
                              GestureDetector(
                                child: Text(
                                  "View More",
                                  style: TextStyle(
                                      color: redColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.end,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ProductDetails(document)));
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.0),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
          },
        );
      },
    );
  }
}
