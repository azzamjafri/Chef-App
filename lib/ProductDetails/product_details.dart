import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/colors.dart';

class ProductDetails extends StatefulWidget {
  DocumentSnapshot data;
  ProductDetails(DocumentSnapshot d) {
    this.data = d;
  }

  @override
  _ProductDetailsState createState() => _ProductDetailsState(data);
}

class _ProductDetailsState extends State<ProductDetails> {
  DocumentSnapshot data;
  int steps;
  int count = 1;
  int image_count;
  _ProductDetailsState(var d) {
    this.data = d;

    // print(data['name'].toString() + "*************");
  }

  @override
  void initState() {
    steps = data['preparation_steps_count'];
    image_count = data['images'].length;
    // print(image_count.toString() + "*************");
    super.initState();
  }

  final carouselController = PageController();

  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: new Stack(
          children: <Widget>[
            imageCarousel(),
            Positioned(
              child: bottom(),
              top: MediaQuery.of(context).size.height / 2.7,
            ),
            Positioned(
              child: title(),
              top: 30.0,
            ),
          ],
        ),
      ),
    );
  }

  bottom() {
    return ExpandableNotifier(
      child: Card(
        elevation: 15.0,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0),
            topLeft: Radius.circular(40.0),
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40.0),
              topLeft: Radius.circular(40.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(35.0),
            child: columnContents(),
          ),
        ),
      ),
    );
  }

  columnContents() {
    return SingleChildScrollView(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            '${data['name']}',
            style: new TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
          // INGREDIENTS
          new Row(
            children: <Widget>[
              redText('Ingredients'),
              Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 4)),
              redText('Qty'),
            ],
          ),

          for (int i = 0; i < data['ingredient_names'].length; i++)
            new Row(
              children: <Widget>[
                blackText(data['ingredient_names'][i]),
                Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 5)),
                blackText(data['ingredients_qty'][i]),
              ],
            ),

          Padding(padding: EdgeInsets.only(top: 18.5)),

          Row(
            children: <Widget>[
              // redText('Garlic Confit'),
              redText(data['preparationstep' + count.toString() + '_title']),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 2.0)),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              for (int i = 0;
                  i <
                      data['preparationstep' +
                              count.toString() +
                              '_ingredient_names']
                          .length;
                  i++)
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.only(top: 1.5),
                    child: blackText(data['preparationstep' +
                        count.toString() +
                        '_ingredient_names'][i]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.5),
                    child: blackText(data['preparationstep' +
                        count.toString() +
                        '_ingredients_qty'][i]),
                  ),
                ]),
            ],
          ),

          Padding(padding: EdgeInsets.only(top: 18.5)),

          Row(
            children: <Widget>[
              redText('Method'),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 2.0)),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              for (int i = 0;
                  i <
                      data['preparationstep' + count.toString() + '_methods']
                          .length;
                  i++)
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.only(top: 1.5),
                    child: blackText('- ' +
                        data['preparationstep' + count.toString() + '_methods']
                            [i]),
                  ),
                ]),
            ],
          ),

          Padding(padding: EdgeInsets.only(top: 18.5)),

          ScrollOnExpand(
            scrollOnExpand: true,
            scrollOnCollapse: false,
            child: Expandable(
              collapsed: viewMoreWidget(),
              expanded: expandedWidget(),
              theme: const ExpandableThemeData(
                tapBodyToCollapse: true,
                tapBodyToExpand: true,
              ),
            ),
          ),
          // HEADING
        ],
      ),
    );
  }

  viewMoreWidget() {
    return new Column(
      children: <Widget>[
        SizedBox(
          height: 12.0,
        ),
        Builder(
          builder: (context) {
            var controller = ExpandableController.of(context);
            return Container(
              height: 45.0,
              width: MediaQuery.of(context).size.width / 1.30,
              child: new Container(
                height: 45.0,
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  color: redColor,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: FlatButton(
                  onPressed: () {
                    controller.toggle();
                  },
                  child: Center(
                      child: new Text(
                    'View More',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }

  expandedWidget() {
    int i = count + 1;

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate((steps - 1) * 4, (index) {
        if (index % 4 == 1)
          return Row(
            children: <Widget>[
              redText(data['preparationstep' + i.toString() + '_title']),
            ],
          );
        else if (index % 4 == 2) {
          return Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              for (int j = 0;j <data['preparationstep' +i.toString() + '_ingredient_names'].length;j++) TableRow(children: [
                  Padding(
                    padding: EdgeInsets.only(top: 1.5),
                    child: blackText(data['preparationstep' +
                        i.toString() +
                        '_ingredient_names'][j]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.5),
                    child: blackText(data['preparationstep' +
                        i.toString() +
                        '_ingredients_qty'][j]),
                  ),
                ]),
            ],
          );
        } else if (index % 4 == 3) {
          return Row(
            children: <Widget>[
              redText('Method'),
            ],
          );
        } else {
          return Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              for (int j = 0;j < data['preparationstep' + i.toString() + '_methods'].length; j++)
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.only(top: 1.5),
                    child: blackText('- ' +
                        data['preparationstep' + i.toString() + '_methods'][j]),
                  ),
                ]),
            ],
          );
        }
      }),
    );

    // return new Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [

    //     Padding(padding: EdgeInsets.only(top: 18.5)),

    //     Padding(padding: EdgeInsets.only(top: 2.0)),

    //     Padding(padding: EdgeInsets.only(top: 18.5)),

    //     Padding(padding: EdgeInsets.only(top: 2.0)),

    //     SizedBox(
    //       height: 20.0,
    //     ),
    //     redText('Presentation'),
    //     for(int i=0; i<data['presentation'].length; i++) blackText(data['presentation'][i]),
    //     SizedBox(
    //       height: 20.0,
    //     ),
    //   ],
    // );
  }

  title() {
    return new Row(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 10.0)),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            'assets/backk.png',
          ),
        ),
        GestureDetector(
          onTap: () {
            // Firestore.instance.collection('users').document(user.uid).updateData({'favourites': FieldValue.arrayUnion([document['name']]),});
          },
          child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 1.8)),
        ),
        Image.asset('assets/heart.png'),
      ],
    );
  }

  imageCarousel() {
    return new Container(
      height: MediaQuery.of(context).size.height / 2.2,
      child: new Carousel(
        images: [
          for (int i = 0; i < image_count; i++)
            Image.network(
              data['images'][i],
              fit: BoxFit.fill,
            ),
        ],
        boxFit: BoxFit.fill,
        autoplayDuration: Duration(seconds: 10),
        autoplay: true,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        animationDuration: Duration(seconds: 1),
        dotSize: 7.0,
        dotBgColor: Colors.transparent,
        dotVerticalPadding: 50.0,
      ),
    );
  }

  blackText(String txt, [double size = 15.1]) {
    return new Text('$txt', style: new TextStyle(fontWeight: FontWeight.w500));
  }

  redText(String txt, [double size = 15.0]) {
    return new Text(
      "$txt",
      style: TextStyle(
          color: redColor, fontSize: size, fontWeight: FontWeight.w400),
    );
  }
}
