import 'package:any_virtual_store/models/user_model.dart';
import 'package:any_virtual_store/screens/login_screen.dart';
import 'package:any_virtual_store/tiles/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController _pageController;

  CustomDrawer(this._pageController);

  Widget _buildDrawerBack() => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 239, 136, 191),
          Color.fromARGB(255, 0, 89, 169),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        'Gocase\nBrasil',
                        style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold, color: Colors.white,),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Ola, ' + (model.isLoggedIn() ? model.userData['name'] : ''),
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white,),
                              ),
                              GestureDetector(
                                child: Text(
                                  model.isLoggedIn() ? 'Sair' : 'Entre ou cadastre-se >',
                                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor,),
                                ),
                                onTap: () {
                                  if(model.isLoggedIn()) {
                                    model.signOut();
                                  } else {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => LoginScreen())
                                    );
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, 'Inicio', _pageController, 0),
              DrawerTile(Icons.list, 'Produtos', _pageController, 1),
              DrawerTile(Icons.location_on, 'Encontre uma loja', _pageController, 2),
              DrawerTile(Icons.playlist_add_check, 'Meus pedidos', _pageController, 3),
            ],
          )
        ],
      )
    );
  }
}