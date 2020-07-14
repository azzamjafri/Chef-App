import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/Model/category_model.dart';

class DatabaseServices {

  
  final CollectionReference categoryCollection = Firestore.instance.collection('categories');
  var user;
  List<CategoryData> _categoryListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return CategoryData(
       name: doc.data['name'] ?? '',
        image: doc.data['image'] ?? '',
        isFavourite: false,
      );
    }).toList();
  }

  Stream<List<CategoryData>> get cats {
    return categoryCollection.snapshots()
      .map(_categoryListFromSnapShot);
  }

  getCurrentUserId() async {
    await FirebaseAuth.instance.currentUser().then((value) {
      return value.uid;
    });
  }

  
}