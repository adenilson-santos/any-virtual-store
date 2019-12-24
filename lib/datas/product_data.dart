import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  List   images, sizes;
  String id, category, title, description;
  double price;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id          = snapshot.documentID;
    title       = snapshot.data['title'];
    sizes       = snapshot.data['sizes'];
    price       = snapshot.data['price'] + 0.0;
    images      = snapshot.data['images'];
    description = snapshot.data['description'];
  }

  Map<String, dynamic> toResumeMap() {
    return {
      "title": title,
      "description": description,
      "price": price,
    };
  }

}