import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:store/ARABIC/add.dart';
import 'package:store/ENGLESH/add-E.dart';
import 'package:store/main.dart';
import 'package:store/api.dart';
import 'package:store/ENGLESH/regester-E.dart';

class LLoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFF101010),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                'login',
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
              ),
            ),
            IconButton(
              icon: Icon(Icons.language),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
        backgroundColor: Color(0xFFFF9900),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* Column(
               children:[ 
                ClipOval(
                child: Image.network(
                 "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQutbYSVM8htDYIBc0Jk82VspnTEQWLfIsHQ&usqp=CAU",
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 90),
              ClipOval(
                child: Image.network(
                 "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSX92zVU4cGIfY-yh2inljA5Ri58_1Hx1Rn3nAGOMcf-mESxMPctjresNouQlw83yBAtyA&usqp=CAU",
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
               ]
             ),*/
              SizedBox(
                  width:
                      100), // إضافة هذه التعليمة لتحديد المسافة بين الصورة والكرت
              Center(
                child: Card(
                  elevation: 5,
                  color: Color(0xFF151515),
                  shadowColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    width: screenSize.width * 0.3,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-Zcx59i60flL2d_9yGji_dfKIZrEXYIPWBA&usqp=CAU",
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                                  ),
                                );
                              }
                            },
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(height: 40),
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
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                      'Please fill out all fields',
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    backgroundColor: Colors.red),
                              );
                            } else {
                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddMedicinePage()));
                              _login(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFB800),
                            shadowColor: Colors.yellow,
                          ),
                          child: Text(
                            'login',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("I don't have an account already?",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RRegisterPage()),
                                );
                              },
                              icon: Icon(Icons.arrow_back),
                              color: const Color(0xFFFF9900),
                              iconSize: 30.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width:
                      100), // إضافة هذه التعليمة لتحديد المسافة بين الكرت والصورة
            ],
          ),
        ),
      ),
    );
  }

  void _login(context) async {
    var email = emailController.text;
    var password = passwordController.text;

    var data = {'email': email, 'password': password};

    var res = await Network().auth(data, '/login/');
    if (res.statusCode == 200) {
      // good connection
      var response = jsonDecode(res.body);
      if (response['error'] == true) {
        _showMessage(context, response['message']);
      } else {
        MyApp.token = response['access_token'];
        MyApp.email = email;
        MyApp.name = response['user']['name'];
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AAddMedicinePage()));
      }
    } else {
      if (res.statusCode == 422) {
        _showMessage(context, jsonDecode(res.body)['message']);
      } else {
        _showMessage(context, "Invalid Connection");
      }
    }
  }

  _showMessage(context, msg) {
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
