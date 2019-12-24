import 'package:any_virtual_store/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();

  final _addressController = TextEditingController();

  final _passController = TextEditingController();

  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Criar Conta'),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if(model.isLoading)
            return Center(child: CircularProgressIndicator(),);
          else
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Nome Completo'
                    ),
                    validator: (text) {
                      if(text.isEmpty) return 'Nome invalido!';
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'E-mail'
                    ),
                    validator: (text) {
                      if(text.isEmpty || !text.contains('@')) return 'E-mail invalido!';
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                    ),
                    obscureText: true,
                    validator: (text) {
                      if(text.isEmpty || text.length < 6) return 'Senha Invalida!';
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      hintText: 'Endereco'
                    ),
                    validator: (text) {
                      if(text.isEmpty) return 'Endereco invalido!';
                    },
                  ),
                  SizedBox(height: 16.0,),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text(
                        'Criar Conta',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if(_formKey.currentState.validate()) {
                          Map<String, dynamic> userData = {
                            "name": _nameController.text,
                            "email": _emailController.text,
                            "address": _addressController.text,
                          };

                          model.signUp(
                            userData: userData,
                            pass: _passController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail,
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            );
        },
      )
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: 
        Text(
          'Usuario criado com sucesso!'
        ), 
        backgroundColor: Colors.blueAccent, 
        duration: Duration(seconds: 2)
      ),
    );
      
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: 
        Text(
          'Erro ao criar usuario!'
        ), 
        backgroundColor: Colors.redAccent, 
        duration: Duration(seconds: 2)
      ),
    );
  }
}