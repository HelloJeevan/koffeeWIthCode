import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kofee_with_code/models/brew.dart';
import 'package:kofee_with_code/screens/Home/coffeList.dart';
import 'package:kofee_with_code/services/auth.dart';
import 'package:kofee_with_code/services/services.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>?>.value (
      initialData: [],
      value: databaseService(uid: '').coffee,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: Text('Kofee With Code'),
          elevation: 0.0,
          backgroundColor: Colors.brown,
          actions: <Widget>[
            FlatButton.icon(onPressed:()async {
              await _auth.signOut();
            },
             icon : Icon(Icons.person),
              label: Text('logout') ),
          ],
        ),
        body: coffeList(),
      ),
    );
  }
}