import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:store/api.dart';
import 'logine -E.dart';

class RRegisterPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF101010),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  'Register',
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.left,
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          backgroundColor: Color(0xFFFF9900),
        ),
        body: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 400.0,
              maxHeight: 500.0, // الارتفاع الأقصى للـ Container
            ),
            child: Container(
              constraints: BoxConstraints(maxWidth: 400.0),
              child: Card(
                elevation: 5,
                color: Color(0xFF151515),
                shadowColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          prefixIcon:
                              Icon(Icons.person, color: Color(0xFFFF9900)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          alignLabelWithHint: true,
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true, // تمكين التلوين
                          fillColor: Colors.white, // تعيين لون التلوين
                          floatingLabelBehavior: FloatingLabelBehavior
                              .never, // منع رفع النص عند التركيز
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 20),

                      /*  TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'رقم الجوال',
                prefixIcon: Icon(Icons.phone, color: Colors.black),
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                alignLabelWithHint: true,
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),*/

                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon:
                              Icon(Icons.email, color: Color(0xFFFF9900)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          alignLabelWithHint: true,
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true, // تمكين التلوين
                          fillColor: Colors.white, // تعيين لون التلوين
                          floatingLabelBehavior: FloatingLabelBehavior
                              .never, // منع رفع النص عند التركيز
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Passowrd',
                          prefixIcon:
                              Icon(Icons.lock, color: Color(0xFFFF9900)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          alignLabelWithHint: true,
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true, // تمكين التلوين
                          fillColor: Colors.white, // تعيين لون التلوين
                          floatingLabelBehavior: FloatingLabelBehavior
                              .never, // منع رفع النص عند التركيز
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Passowrd',
                          prefixIcon:
                              Icon(Icons.lock, color: Color(0xFFFF9900)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          alignLabelWithHint: true,
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true, // تمكين التلوين
                          fillColor: Colors.white, // تعيين لون التلوين
                          floatingLabelBehavior: FloatingLabelBehavior
                              .never, // منع رفع النص عند التركيز
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (passwordController.text !=
                              confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Passwords do not match',
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(fontSize: 20.0)),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else if (nameController.text.isEmpty ||
                              emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please fill out all fields',
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(fontSize: 20.0)),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            _register(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFFB800),
                          shadowColor: Colors.yellow,
                          minimumSize: Size(30, 40),
                        ),
                        child: Text("Register",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void _register(context) async {
    var name = nameController.text;
    var email = emailController.text;
    var password = passwordController.text;

    var data = {
      'name': name,
      'email': email,
      'password': password,
    };

    var res = await Network().auth(data, '/store/register/');
    if (res.statusCode == 200 || res.statusCode == 201) {
      // good connection
      var response = jsonDecode(res.body);
      if (response['error'] == true) {
        _showMessage(context, response['message']);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LLoginPage()),
        );
      }
    } else {
      if (res.statusCode == 422) {
        _showMessage(context, jsonDecode(res.body)['message']);
      } else {
        print(res.statusCode);
        _showMessage(context, "Invalid Connection");
      }
    }
  }

  _showMessage(context, msg) {
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
