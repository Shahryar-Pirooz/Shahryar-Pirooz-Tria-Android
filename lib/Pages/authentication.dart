import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triapass/src/components.dart';
import 'package:triapass/src/custom_color.dart';

import '../main.dart';
import 'main_page.dart';

class Authentication extends StatelessWidget {
  final TextEditingController _passController = TextEditingController();
  Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _savedPass = Provider.of<ChangeVal>(context, listen: false).pass;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                  textAlign: TextAlign.center,
                  text: TriaBody('Please authenticate\nto start ',
                      children: [TriaBody('Tria', color: primaryColor)])),
              const Divider(
                color: white,
              ),
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Password",
                    suffixIcon: IconButton(
                        onPressed: () => Provider.of<VisiblePassword>(context,
                                    listen: false)
                                .isVisible =
                            Provider.of<VisiblePassword>(context, listen: false)
                                    .isVisible
                                ? false
                                : true,
                        icon: Icon(
                            Provider.of<VisiblePassword>(context, listen: true)
                                    .isVisible
                                ? Icons.visibility_off
                                : Icons.visibility))),
                obscureText:
                    Provider.of<VisiblePassword>(context, listen: true).isHide,
                controller: _passController,
              ),
              const Divider(
                color: white,
              ),
              TriaButton(() {
                var _bytes =
                    utf8.encode(_passController.text); // data being hashed
                var _hashPass = sha256.convert(_bytes);
                if (_hashPass.toString() == _savedPass) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainPage()));
                } else {
                  SnackBar snackBar =
                      const SnackBar(content: Text('Try again'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }, 'UNLOCK', Icons.lock_open)
            ],
          ),
        ),
      ),
    );
  }
}
