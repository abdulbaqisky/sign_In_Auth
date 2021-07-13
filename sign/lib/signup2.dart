import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SignUp2 extends StatefulWidget {
  const SignUp2({Key? key}) : super(key: key);

  @override
  _SignUp2State createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  final _formKey = GlobalKey<FormState>();
  String _currentItemSelected = 'Gender';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Info',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 150,
                  color: Colors.deepOrange,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'User Info',
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
                        'Additional information',
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          DropdownButton(
                            items:
                                <String>['Male', 'Female'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValueSelected) {
                              setState(() {
                                this._currentItemSelected = newValueSelected!;
                              });
                            },
                            hint: Text('Gender'),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          DropdownButton(
                              items: <String>['Male', 'Female']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              hint: Text('Date of Birth'),
                              onTap: () async {
                                showDatePicker(
                                    context: context,
                                    initialDate: new DateTime.now(),
                                    firstDate: new DateTime(1900),
                                    lastDate: new DateTime(2100));
                              }),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 70.0),
                            child: Container(
                              width: 500,
                              height: 70,
                              child: ElevatedButton(
                                child: Text(
                                  'Proceed',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text('Processing Data')));
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
