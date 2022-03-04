import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triapass/Pages/authentication.dart';
import 'package:triapass/src/custom_color.dart';

import 'Pages/introduction.dart';
import 'Pages/main_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChangeVal()),
        ChangeNotifierProvider(create: (_) => ChangeDrawerIcon())
      ],
      child: const Preload(),
    ),
  );
}

class ChangeVal with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isFirst = true;
  String _name = '';
  String _pass = '';

  bool get isFirst => _isFirst;
  String get name => _name;
  String get pass => _pass;

  void saveIsFirst(bool b) {
    _isFirst = b;
    notifyListeners();
  }

  void saveName(String text) {
    _name = text;
    notifyListeners();
  }

  void savePass(String text) {
    _pass = text;
    notifyListeners();
  }
}

class ChangeDrawerIcon with ChangeNotifier, DiagnosticableTreeMixin {
  IconData _icon = Icons.menu;

  IconData get icon => _icon;

  set icon(IconData icon) {
    _icon = icon;
    notifyListeners();
  }
}

class Preload extends StatelessWidget {
  const Preload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SPData().initProviderData(context);
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: primaryColor,
          fontFamily: 'MontserratAlternates',
        ),
        home: FutureBuilder<bool>(
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data) {
                return Introduction();
              } else {
                return Authentication();
              }
            } else {
              return Container(
                color: white,
              );
            }
          },
          future: SPData().initProviderData(context),
        ));
  }
}

class SPData {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> _isFirst;
  late Future<String> _name;
  late Future<String> _pass;

  Future<void> setNewName(BuildContext context, {String newName = ''}) async {
    final prefs = await _prefs;
    final name = prefs.getString('name') ?? newName;
    _name = prefs.setString('name', name).then((bool success) => name);
    Provider.of<ChangeVal>(context, listen: false).saveName(await _name);
  }

  Future<void> setNewPass(BuildContext context, {String newPass = ''}) async {
    final prefs = await _prefs;
    final pass = prefs.getString('pass') ?? newPass;
    _pass = prefs.setString('pass', pass).then((bool success) => pass);
    Provider.of<ChangeVal>(context, listen: false).savePass(await _pass);
  }

  Future<void> setFalse() async {
    final prefs = await _prefs;
    prefs.setBool("isFirst", false).then((bool success) => false);
  }

  Future<bool> initProviderData(BuildContext context) async {
    final prefs = await _prefs;
    final name = prefs.getString('name') ?? '';
    final pass = prefs.getString('pass') ?? '';
    final isFirst = prefs.getBool('isFirst') ?? true;
    _isFirst =
        prefs.setBool('isFirst', isFirst).then((bool success) => isFirst);

    Provider.of<ChangeVal>(context, listen: false).saveName(name);
    Provider.of<ChangeVal>(context, listen: false).savePass(pass);
    Provider.of<ChangeVal>(context, listen: false).saveIsFirst(await _isFirst);

    return _isFirst;
  }
}
