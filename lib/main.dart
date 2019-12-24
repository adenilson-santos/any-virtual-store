import 'package:any_virtual_store/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/user_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: 'Any Virtual Store',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color.fromARGB(255, 4, 125, 142),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
