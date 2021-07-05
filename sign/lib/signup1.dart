import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sign/main.dart';
import 'package:sign/signup2.dart';

class Happen extends StatefulWidget {
  const Happen({Key? key}) : super(key: key);

  @override
  _HappenState createState() => _HappenState();
}

class _HappenState extends State<Happen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SignUp(),
        ),
      ),
    );
  }
}

class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        flex: 1,
        child: Container(
          height: 150,
          color: Colors.deepOrange,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'Sign Up',
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
                'Enter your Credentials to continue',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
      ),
      Expanded(
        flex: 4,
        child: Container(
            /*decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Colors.white,
            ),*/
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
                      decoration: InputDecoration(
                        labelText: 'Email Address',
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
                      decoration: InputDecoration(
                        labelText: 'Phone number',
                        labelStyle: TextStyle(fontSize: 16),
                        hintText: 'Enter your Phone Number',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Phone Number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
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
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'By clicking Sign Up, you agree to our ',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            TextSpan(
                                text: 'Terms of Service',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 16),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {}),
                            TextSpan(
                              text: ' and that you have read our ',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16),
                            ),
                            TextSpan(
                                text: 'Privacy Policy',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('Privacy Policy"');
                                  }),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Container(
                        width: 500,
                        height: 70,
                        child: ElevatedButton(
                          child: Text('Continue'),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp2(
                                          key: _formKey,
                                        )),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Row(
                      children: [
                        Text(
                          'Already have an account',
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
                                  builder: (context) => SignUp2()),
                            );
                          },
                          child: Text(
                            'Login',
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
