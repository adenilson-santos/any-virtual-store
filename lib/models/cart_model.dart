import 'package:any_virtual_store/datas/cart_product.dart';
import 'package:any_virtual_store/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {

  UserModel user;

  List<CartProduct> products = [];

  bool isLoading = false;

  CartModel(this.user){
    if(user.isLoggedIn()) {
      _loadCartItems();
    }
  }

  static CartModel of(BuildContext context) =>
         ScopedModel.of<CartModel>(context);

  void addCartitem(CartProduct cartProduct) {
    products.add(cartProduct);

    Firestore.instance
             .collection('users')
             .document(user.firebaseUser.uid)
             .collection('cart')
             .add(cartProduct.toMap()).then(
               (doc) {
                 cartProduct.id = doc.documentID;
               }
             );

    notifyListeners();
  }

  void removeCartitem(CartProduct cartProduct) {
    Firestore.instance
             .collection('users')
             .document(user.firebaseUser.uid)
             .collection('cart')
             .document(cartProduct.id)
             .delete();

    products.remove(cartProduct);
    notifyListeners();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity --;
    updateFirestoreCart(cartProduct);
    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity ++;
    updateFirestoreCart(cartProduct);
    notifyListeners();
  }

  void updateFirestoreCart(CartProduct cartProduct) {
    Firestore.instance
             .collection('users')
             .document(user.firebaseUser.uid)
             .collection('cart')
             .document(cartProduct.id)
             .updateData(cartProduct.toMap());
  }

  void _loadCartItems(){
    Future<QuerySnapshot> query = Firestore.instance
                                   .collection('users')
                                   .document(user.firebaseUser.uid)
                                   .collection('cart')
                                   .getDocuments();
  
    query.then((data) {
      products = data.documents.map((doc) => CartProduct.fromDocument(doc)).toList();
      notifyListeners();
    });
  }


}