import 'package:flutter/material.dart';
import 'package:flutter_application_banana/pages/register_page.dart';
import 'package:flutter_application_banana/utils/color.dart';
import 'package:flutter_application_banana/widgets/btn_widget.dart';
import 'package:flutter_application_banana/widgets/herder_container.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

 final username = TextEditingController();
 final password = TextEditingController();

  void checkLogin(String username, String password) async {
    var url = Uri.parse('http://10.0.2.2/login/login.php');
    var response = await http.post(url, body: {
      'username': username,
      'password': password,
    });
    var data = jsonDecode(response.body);
    if (data == "Fail") {
      
      print("Login Fail");
      return;
    } else {
      print("Login Success");
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer(""),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _textInput(hint: "username", icon: Icons.email, controller: username,obscureText: false),
                    _textInput(hint: "password", icon: Icons.vpn_key,controller: password,obscureText: true),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          onClick: () {
                            checkLogin(username.text, password.text);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => RegPage()));
                          },
                          btnText: "LOGIN",
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Don't have an account ? ",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: "Registor",
                            
                            style: TextStyle(color: Colors.black)),
                      ]),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textInput({controller, hint, icon , obscureText}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
          
        ),
      ),
    );
  }
}
