import 'package:any_virtual_store/datas/product_data.dart';
import 'package:any_virtual_store/screens/individual_product_screen.dart';
import 'package:flutter/material.dart';

class IndividualProductTile extends StatelessWidget {
  final String type;
  final ProductData product;
  
  IndividualProductTile(this.type, this.product);

  Widget renderGridItems(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 0.8,
          child: Image.network(
            product.images[0],
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "R\$ ${product.price}",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget renderListItems(context) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Image.network(
            product.images[0],
            fit: BoxFit.cover,
            height: 250.0,
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "R\$ ${product.price}",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => IndividualProductScreen(product)));
      },
      child: Card(
        child: type == 'grid' ?
                renderGridItems(context) :
                renderListItems(context),
      ),
    );
  }
}