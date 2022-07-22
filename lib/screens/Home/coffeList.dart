import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kofee_with_code/models/brew.dart';
import 'package:kofee_with_code/screens/Home/brew_tile.dart';
import 'package:provider/provider.dart';

class coffeList extends StatefulWidget {
  const coffeList({Key? key}) : super(key: key);

  @override
  State<coffeList> createState() => _coffeListState();
}

class _coffeListState extends State<coffeList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);
    brews.forEach((brew) {
      print(brew.name);
      print(brew.sugars);
      print(brew.strength);
    });
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context,index){
        return BrewTile(brew : brews[index]);
      },
    );
  }
}
