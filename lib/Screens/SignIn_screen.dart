import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task1/Models/newsinfo.dart';
import 'package:task1/constants/Strings.dart';

class SignIn extends StatelessWidget {
  var email, password;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: new BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: height * 0.15,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Welcome Back!!",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Sign In",
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Column(
                            children: <Widget>[
                              TextField(
                                onChanged: (value) {
                                  email = value;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      borderSide: BorderSide(
                                        color: Colors.pinkAccent.shade400,
                                      ),
                                    ),
                                    labelText: 'Email',
                                    hintText: 'eve.holt@reqres.in'),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextField(
                                onChanged: (value) {
                                  password = value;
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      borderSide: BorderSide(
                                        color: Colors.pinkAccent.shade400,
                                      ),
                                    ),
                                    labelText: 'Password',
                                    hintText: 'cityslicka'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                print(email);
                                var response = await http.post(
                                    Uri.parse(Strings.userSignInUrl),
                                    body: {
                                      "email": email.toString(),
                                      "password": password.toString(),
                                    });
                                print(response.body);
                                var jsonMap = json.decode(response.body);
                                var res = Welcomey.fromJson(jsonMap);
                                if (response.statusCode == 200) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text("Successful Sign In")));
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      "/home", (_) => false);
                                } else if (response.statusCode == 400) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(res.error.toString())));
                                }
                              } catch (Exception) {
                                print('error');
                              }
                              // Navigator.pushNamed(
                              //   context,
                              //   "/home",
                              // );
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Create an account"),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      "/", (_) => false);
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors.orange,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
