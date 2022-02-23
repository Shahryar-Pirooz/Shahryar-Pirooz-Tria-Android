import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:triapass/main.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SPData().initProviderData(context);
    String name = context.watch<ChangeVal>().name;
    String code = context.watch<ChangeVal>().code;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Text('$name , $code'),
      ),
    );
  }
}
