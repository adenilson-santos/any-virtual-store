import 'package:any_virtual_store/tiles/product_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection('products').getDocuments(),
        builder: (context, snapshot) {
          if(!snapshot.hasData)
            return Center(child: CircularProgressIndicator(),);
          else
            return ListView(
              children: ListTile.divideTiles(
                tiles: snapshot.data.documents.map((doc) => ProductTile(doc) ).toList(),
                color: Colors.grey[500],
              ).toList(),
            );
        },
      )
    );
  }
}