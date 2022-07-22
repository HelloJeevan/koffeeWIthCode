import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kofee_with_code/services/auth.dart';
import 'package:kofee_with_code/shared/constants.dart';
import 'package:kofee_with_code/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
 SignIn({ required this.toggleView });
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String Password = "";
  String eror ='';
  
  Widget build(BuildContext context) {
    return loading?Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      
      appBar: AppBar(
        backgroundColor: Colors.brown,
        elevation: 0.0,
        title: Text('Sign In to KWC'),
        actions: <Widget>[
          FlatButton.icon(onPressed: (){
            widget.toggleView();
          }, icon: Icon(Icons.person) , label: Text('Register') )
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
              decoration:  textInputDecoration .copyWith(hintText: 'Enter Email' ),
              validator: (val) => val!.isEmpty?'Enter an Email': null,
              onChanged: (val){
                setState(() {
                  email = val;
                });
              },
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: textInputDecoration .copyWith(hintText: 'Enter Password' ),
              validator: (val) => val!.length<6?'Enter a valid Password': null,
              obscureText: true,
              onChanged: (val){
                setState(() {
                  Password = val;
                });
              },
            ),
            SizedBox(height: 20.0,),
            RaisedButton(
              
              color: Colors.pink[400],
              child: Text(
                'Sign In',
                style : TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if(_formKey.currentState!.validate()){
                  setState(() {
                    loading = true;
                  });
                  dynamic result =await _auth.signInWithEmailAndPassword(email, Password);
                  if(result==null){
                    setState(() {
                      loading = false;
                      eror = 'Invalid Credetials';
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