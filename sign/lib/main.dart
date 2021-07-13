import 'dart:convert';
import 'package:sign/loggedIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sign/signup1.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

void main() {
  runApp(MyApp());
}

String email = "";
String password = "";
bool showSpinner = false;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign In',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SafeArea(
            child: MyHomePage(),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        flex: 1,
        child: Container(
          color: Colors.deepOrange,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                'Welcome Back',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
      ),
      Expanded(
        flex: 4,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 40, 25, 0),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email address',
                            labelStyle: TextStyle(fontSize: 16),
                            hintText: 'Enter your Email',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          onChanged: (value) {
                            password = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(fontSize: 16),
                            hintText: 'Enter your Password',
                            suffixIcon: Icon(Icons.visibility_off_rounded),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Remember me',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 40),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepOrange,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          child: Container(
                            width: 500,
                            height: 70,
                            child: ElevatedButton(
                                child: Text('Log in'),
                                onPressed: () async {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  var headers = {
                                    'Content-Type': 'application/json'
                                  };
                                  var request = http.Request(
                                      'POST',
                                      Uri.parse(
                                          'https://dev.hareo.com.ng/api/v1/auth/login/'));
                                  request.body = json.encode({
                                    "email": "$email",
                                    "password": "$password"
                                  });
                                  request.headers.addAll(headers);

                                  http.StreamedResponse response =
                                      await request.send();

                                  if (response.statusCode == 200) {
                                    setState(() {
                                      showSpinner = false;
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignedIn(),
                                      ),
                                    );

                                    print(
                                        await response.stream.bytesToString());
                                  } else {
                                    print(response.reasonPhrase);
                                  }
                                }),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Divider(
                                thickness: 4.0,
                              ),
                            ),
                            Text("Or Connect with"),
                            Expanded(
                              child: Divider(thickness: 4.0),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.facebook,
                                color: Colors.blue,
                                size: 36,
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Icon(
                                Icons.g_translate_sharp,
                                color: Colors.red,
                                size: 36,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        Row(
                          children: [
                            Text(
                              'Don\'t have an account',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Happen()),
                                );
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    ]);
  }
}

/*
Navigator.push(
_MyHomePageState().context,
MaterialPageRoute(builder: (context) => SignedIn()),
);*/
