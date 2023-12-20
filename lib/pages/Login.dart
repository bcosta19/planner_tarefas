import 'package:flutter/material.dart';
import 'package:planner_tarefas/controller/LoginController.dart';
import '../model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:planner_tarefas/pages/DashBoard.dart';

class Login extends StatefulWidget{

  const Login({super.key});
  static const String routeName = "/login";

  String getRouteName(){
    return routeName;
  }

  @override
  State<Login> createState() => _LoginState();
}

enum LoginStatus {notSignIn, signIn}

class _LoginState extends State<Login>{
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String? _username, _password;
  int? user_id;
  
  final _formKey = GlobalKey<FormState>();
  late LoginController controller;
  var value;


  _LoginState(){
    this.controller = LoginController();
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      preferences.setInt("value", 0);
      _loginStatus = LoginStatus.notSignIn;
    });
  }
  
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      value = preferences.getInt("value");
      print(value);
      _loginStatus = (value == 1) ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  _submit() async{

    final form = _formKey.currentState;

    if(form!.validate()){
      form.save();
      try{
        User user = await controller.getLogin(_username!, _password!);
        
        if (user.id != -1){
          savePref(1, user.username, user.password);
          user_id = user.id!;
          _loginStatus = LoginStatus.signIn;
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuário não registrado!'))
          );
        }
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))
        );
      }
    }
  }

  savePref(int value, String user, String pass) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      preferences.setInt("value", value);
      preferences.setString("user", user);
      preferences.setString("pass", pass);
    });
  }

  @override
  void initState(){
    super.initState();
    getPref();
  }
  
  @override
  Widget build(BuildContext context) {
  
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
            appBar: AppBar(
              title: Text("Login Page"),
            ),
            body: Container(
              child: Center(
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              onSaved: (newValue) => _username = newValue,
                              decoration: InputDecoration(
                                labelText: "Username",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              onSaved: (newValue) => _password = newValue,
                              decoration: InputDecoration(
                                labelText: "Password",
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          )
                        ]
                      ,)
                    ),
                    ElevatedButton(
                      onPressed: _submit, 
                      child: Text("Login"),
                      
                    )
                  
                  ],
                ),
              ),
            ),
          );
        case LoginStatus.signIn:
          return DashBoard(user_id!);
    }
    
  }

}