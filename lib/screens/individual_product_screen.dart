import 'package:any_virtual_store/datas/cart_product.dart';
import 'package:any_virtual_store/datas/product_data.dart';
import 'package:any_virtual_store/models/cart_model.dart';
import 'package:any_virtual_store/models/user_model.dart';
import 'package:any_virtual_store/screens/cart_screen.dart';
import 'package:any_virtual_store/screens/login_screen.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class IndividualProductScreen extends StatefulWidget {
  final ProductData product;

  IndividualProductScreen(this.product);

  @override
  _IndividualProductScreenState createState() => _IndividualProductScreenState(product);
}

class _IndividualProductScreenState extends State<IndividualProductScreen> {
  final ProductData product;
  String selectedSize;

  _IndividualProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    final UserModel currentUser = UserModel.of(context);

    final CartModel currentCart = CartModel.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.8,
            child: Carousel(
              images: product.images.map((url) => Image.network(url) ).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 16.0,),
                Text(
                  'Tamanho',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.3,
                    ),
                    children: product.sizes.map((size) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(
                              color: selectedSize == size ? primaryColor : Colors.grey[500], 
                              width: 2.0
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(size),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16.0,),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: selectedSize != null ? () {
                      if(currentUser.isLoggedIn()) {
                        CartProduct cartProduct = CartProduct();

                        cartProduct.size        = selectedSize;  
                        cartProduct.quantity    = 1;  
                        cartProduct.productId   = product.id; 
                        cartProduct.category    = product.category;
                        cartProduct.productData = product;

                        currentCart.addCartitem(cartProduct);

                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CartScreen())
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginScreen())
                        );
                      }
                    } : null,
                    child: Text(
                      currentUser.isLoggedIn() ? 'Adicionar ao Carrinho' : 'Fazer login.',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0,),
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}