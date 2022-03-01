import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triapass/src/custom_color.dart';

import 'Pages/introduction.dart';
import 'Pages/main_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChangeVal()),
      ],
      child: const MainConfig(),
    ),
  );
}

class ChangeVal with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isFirst = true;
  String _name = '';
  String _code = '';

  bool get isFirst => _isFirst;
  String get name => _name;
  String get code => _code;

  void saveIsFirst(bool b) {
    _isFirst = b;
    notifyListeners();
  }

  void saveName(String text) {
    _name = text;
    notifyListeners();
  }

  void saveCode(String text) {
    _code = text;
    notifyListeners();
  }
}

class MainConfig extends StatelessWidget {
  const MainConfig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                return MainPage();
              }
            } else {
              return Container(
                color: white,
              );
            }
          },
          future: SPData().setIsFirst(context),
        ));
  }
}

class SPData {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> _isFirst;
  late Future<String> _name;
  late Future<String> _code;

  Future<bool> setIsFirst(BuildContext context) async {
    final prefs = await _prefs;
    final isFirst = prefs.getBool('isFirst') ?? true;
    _isFirst =
        prefs.setBool('isFirst', isFirst).then((bool success) => isFirst);
    Provider.of<ChangeVal>(context, listen: false).saveIsFirst(await _isFirst);
    return _isFirst;
  }

  Future<void> setNewName(BuildContext context, {String newName = ''}) async {
    final prefs = await _prefs;
    final name = prefs.getString('name') ?? newName;
    _name = prefs.setString('name', name).then((bool success) => name);
    Provider.of<ChangeVal>(context, listen: false).saveName(await _name);
  }

  Future<void> setNewCode(BuildContext context, {String newCode = ''}) async {
    final prefs = await _prefs;
    final code = prefs.getString('code') ?? newCode;
    _code = prefs.setString('code', code).then((bool success) => code);
    Provider.of<ChangeVal>(context, listen: false).saveCode(await _code);
  }

  Future<void> setFalse() async {
    final prefs = await _prefs;
    prefs.setBool("isFirst", false).then((bool success) => false);
  }

  Future<void> initProviderData(BuildContext context) async {
    final prefs = await _prefs;
    final name = prefs.getString('name') ?? '';
    final code = prefs.getString('code') ?? '';
    Provider.of<ChangeVal>(context, listen: false).saveName(name);
    Provider.of<ChangeVal>(context, listen: false).saveCode(code);
  }
}
