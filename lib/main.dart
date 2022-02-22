import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Enter your username",
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Enter your password",
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createAlbum,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> createAlbum() async {
    http.Response response = await http.post(
      Uri.parse('https://rest-prod.immedia-semi.com/api/v5/account/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "unique_id": "12345678-9012-3456-7890-123456789001",
        "password": "Polizia@87",
        "email": "monti.cecilia@gmail.com"
      }),
    );
    log('data: ${response.statusCode} - ${response.body}');

//     {
//    "account":{
//       "account_id":43467,
//       "user_id":43467,
//       "client_id":233662,
//       "client_trusted":false,
//       "new_account":false,
//       "tier":"e007",
//       "region":"eu",
//       "account_verification_required":false,
//       "phone_verification_required":false,
//       "client_verification_required":true,
//       "require_trust_client_device":false,
//       "country_required":false,
//       "verification_channel":"phone",
//       "user":{
//          "user_id":43467,
//          "country":"IT"
//       },
//       "amazon_account_linked":false
//    },
//    "auth":{
//       "token":"LgUIbHO7BfAvGmDr-0Wj4w"
//    },
//    "phone":{
//       "number":"+39******3099",
//       "last_4_digits":"3099",
//       "country_calling_code":"39",
//       "valid":true
//    },
//    "verification":{
//       "email":{
//          "required":false
//       },
//       "phone":{
//          "required":true,
//          "channel":"sms"
//       }
//    },
//    "lockout_time_remaining":0,
//    "force_password_reset":false,
//    "allow_pin_resend_seconds":90
// }
  }
}
