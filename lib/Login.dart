import 'package:flutter/material.dart';

class Login extends StatefulWidget{

  const Login({super.key});
  String get routeName => "/login";

  String getRouteName(){
    return this.routeName;
  }

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login>{
  @override
  Widget build(BuildContext context){
    return Placeholder();
  }
}