import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triapass/src/custom_color.dart';

import 'Pages/introduction.dart';
import 'Pages/mainpage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SaveData()),
      ],
      child: const MainConfig(),
    ),
  );
}

class SaveData with ChangeNotifier, DiagnosticableTreeMixin {
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
                return const Introduction();
              } else {
                return const MainPage();
              }
            } else {
              return Container(
                color: white,
              );
            }
          },
          future: SPData().spIsFirst(context),
        ));
  }
}

class SPData {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> _isFirst;
  late Future<String> _name;
  late Future<String> _code;

  Future<bool> spIsFirst(BuildContext context) async {
    final prefs = await _prefs;
    final isFirst = prefs.getBool('isFirst') ?? true;
    _isFirst =
        prefs.setBool('isFirst', isFirst).then((bool success) => isFirst);
    Provider.of<SaveData>(context, listen: false).saveIsFirst(await _isFirst);
    return _isFirst;
  }

  Future<void> spName(BuildContext context) async {
    final prefs = await _prefs;
    final name = prefs.getString('name') ?? '';
    _name = prefs.setString('name', name).then((bool success) => name);
    context.watch<SaveData>().saveName(await _name);
  }

  Future<void> spCode(BuildContext context) async {
    final prefs = await _prefs;
    final code = prefs.getString('code') ?? '';
    _code = prefs.setString('code', code).then((bool success) => code);
    context.watch<SaveData>().saveCode(await _code);
  }
}
