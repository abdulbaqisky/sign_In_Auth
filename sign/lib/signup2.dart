import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sign/loggedIn.dart';

class SignUp2 extends StatefulWidget {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;

  SignUp2(
      {Key? key,
      required this.fullName,
      required this.email,
      required this.phoneNumber,
      required this.password})
      : super(key: key);

  @override
  _SignUp2State createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  //final _formKey = GlobalKey<FormState>();
  String genderSelected = 'male';
  bool dateChosen = false;
  DateTime selectedDate = DateTime.now();
  DateTime _dateTime = DateTime.now();
  String dateValue = "";

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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 40, 25, 0),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              DropdownButton<String>(
                                value: genderSelected,
                                underline: Container(
                                  height: 2,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                                items: <String>['male', 'female']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValueSelected) {
                                  setState(() {
                                    genderSelected = newValueSelected!;
                                  });
                                },
                                hint: Text('Gender'),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDatePicker(
                                          currentDate: _dateTime,
                                          context: context,
                                          initialDate: _dateTime,
                                          firstDate: DateTime(1970),
                                          lastDate: DateTime(2025))
                                      .then(
                                    (date) {
                                      setState(() {
                                        dateValue =
                                            "${_dateTime.month.toString().padLeft(2, '0')}-${_dateTime.day.toString().padLeft(2, '0')}-${_dateTime.year.toString().padLeft(2, '0')}";
                                        _dateTime = date!;
                                        dateChosen = true;
                                      });
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        trailing: Icon(Icons.arrow_drop_down),
                                        leading: Text(
                                          !dateChosen
                                              ? 'Date of Birth'
                                              : "${_dateTime.month.toString().padLeft(2, '0')}-${_dateTime.day.toString().padLeft(2, '0')}-${_dateTime.year.toString().padLeft(2, '0')}",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 70.0),
                                child: Container(
                                  width: 500,
                                  height: 70,
                                  child: ElevatedButton(
                                    child: Text(
                                      'Proceed',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    onPressed: () async {
                                      print(widget.fullName);
                                      print(widget.email);
                                      print(widget.phoneNumber);
                                      print(widget.password);
                                      print(genderSelected);
                                      print(dateValue);
                                      try {
                                        var headers = {
                                          'Content-Type': 'application/json'
                                        };
                                        var request = http.Request(
                                            'POST',
                                            Uri.parse(
                                                'https://dev.hareo.com.ng/api/v1/auth/register/user/'));
                                        request.body = json.encode({
                                          "name": "${widget.fullName}",
                                          "email": "${widget.email}",
                                          "phone": "${widget.phoneNumber}",
                                          "password": "${widget.password}",
                                          "sex": "$genderSelected",
                                          "dob": "$dateValue"
                                        });
                                        request.headers.addAll(headers);

                                        http.StreamedResponse response =
                                            await request.send();

                                        if (response.statusCode == 200) {
                                          print(await response.stream
                                              .bytesToString());
                                          SnackBar(
                                            content: Text(
                                                'User successfully registered'),
                                          );
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignedIn()),
                                          );
                                        } else {
                                          SnackBar(
                                            backgroundColor: Colors.blue,
                                            content:
                                                Text('Invalid data request'),
                                          );
                                          print(response.reasonPhrase);
                                        }
                                      } catch (e) {
                                        print(e);
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
