import 'package:flutter/material.dart';
import 'package:kofee_with_code/models/user.dart';
import 'package:kofee_with_code/screens/Authenticate/authenticate.dart';
import 'package:kofee_with_code/screens/Home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<objUser?>(context);
    print(user);
    if(user==null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}