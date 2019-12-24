import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_data.dart';

class CartProduct {

  String id;
  String category;
  String product_id;
  String quantity;
  String size;

  ProductData productData;

  CartProduct.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    category = document.data['category'];
    product_id = document.data['product_id'];
    quantity = document.data['quantity'];
    size = document.data['size'];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "product_id": product_id,
      "quantity": quantity,
      "size": size,
      "product": productData.toResumeMap(),
    };
  }

}