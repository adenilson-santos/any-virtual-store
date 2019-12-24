import 'package:any_virtual_store/datas/cart_product.dart';
import 'package:any_virtual_store/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {

  UserModel user;

  List<CartProduct> products = [];

  CartModel(this.user);

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

}