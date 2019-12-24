import 'package:any_virtual_store/tabs/home_tab.dart';
import 'package:any_virtual_store/tabs/products_tab.dart';
import 'package:any_virtual_store/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
       Scaffold(
         body: HomeTab(),
         drawer: CustomDrawer(_pageController),
       ),
       Scaffold(
         appBar: AppBar(
           title: Text('Produtos'),
           centerTitle: true,
         ),
         drawer: CustomDrawer(_pageController),
         body: ProductsTab()
       ),
       Scaffold(
         appBar: AppBar(
           title: Text('Encontre uma Loja'),
           centerTitle: true,
         ),
         drawer: CustomDrawer(_pageController),
         body: ProductsTab()
       ),
       Scaffold(
         appBar: AppBar(
           title: Text('Meus pedidos'),
           centerTitle: true,
         ),
         drawer: CustomDrawer(_pageController),
         body: ProductsTab()
       ),
      ],
    );
  }
}