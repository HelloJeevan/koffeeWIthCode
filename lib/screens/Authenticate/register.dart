// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:kofee_with_code/services/auth.dart';
import 'package:kofee_with_code/shared/constants.dart';
import 'package:kofee_with_code/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
 Register({ required this.toggleView });
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = "";
  String password = "";
  String eror = '';
  Widget build(BuildContext context) {
    return loading?Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      
      appBar: AppBar(
        backgroundColor: Colors.brown,
        elevation: 0.0,
        title: Text('Sign up to KWC'),
        actions: <Widget>[
          FlatButton.icon(onPressed: (){
            widget.toggleView();
          }, icon: Icon(Icons.person) , label: Text('Sign in') )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
          children: <Widget>[
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: textInputDecoration .copyWith(hintText: 'Enter Email' ),
              validator: (val) => val!.isEmpty?'Enter an Email': null,
              onChanged: (val){
                setState(() {
                  email = val;
                });
              },
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              decoration:  textInputDecoration .copyWith(hintText: 'Enter Password' ),
              validator: (val) => val!.length<6?'Enter a valid Password': null,
              obscureText: true,
              onChanged: (val){
                setState(() {
                  password = val;
                });
              },
            ),
            SizedBox(height: 20.0,),
            RaisedButton(
              
              color: Colors.pink[400],
              child: Text(
                'Register',
                style : TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if(_formKey.currentState!.validate()){
                  setState(() {
                    loading = true;
                  });
                  dynamic result =await _auth.registerWithEmailAndPassword(email, password);
                  if(result==null){
                    setState(() {
                      eror = 'please enter detailes';
                      loading = false;
                    });
                  }
                }
                
              },
              ),
              SizedBox(height: 12.0,),
              Text(eror,style: TextStyle(color: Colors.red,fontSize: 14.0), ),
          ],
        )),
      ),
    ); 
  }
}