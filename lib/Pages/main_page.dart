import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/src/provider.dart';
import 'package:triapass/main.dart';
import 'package:triapass/password_generate.dart';
import 'package:triapass/src/components.dart';
import 'package:triapass/src/custom_color.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(
              text: 'by domain',
            ),
            Tab(
              text: 'by name',
            )
          ]),
        ),
        body: TabBarView(children: [
          ByDomain(),
          ByDomain(),
        ]),
      ),
    );
  }
}

class ByDomain extends StatelessWidget {
  final domainController = TextEditingController();
  final nameController = TextEditingController();
  final codeController = TextEditingController();

  ByDomain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SPData().initProviderData(context);
    String _name = context.watch<ChangeVal>().name;
    String _code = context.watch<ChangeVal>().code;
    String _domain = '';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: RichText(
              textAlign: TextAlign.center,
              text:
                  TriaHeader2('generate a new password,\n but you ', children: [
                TriaHeader2('don’t ', color: primaryColor),
                TriaHeader2('need to '),
                TriaHeader2('remember ', color: primaryColor),
                TriaHeader2(' it.')
              ]),
            )),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(hintText: 'Domain'),
                textAlign: TextAlign.center,
                controller: domainController,
              ),
            ),
            TriaButton(() {
              _domain = domainController.text;
              Map<String, String> stringMap = {
                'name': _name.toLowerCase(),
                'code': _code.toLowerCase(),
                'domain': _domain.toLowerCase()
              };
              String _pass = passwordGenerator(stringMap);
              // Provider.of<FillPasswrd>(context, listen: false).passwrd = _pass;
              SnackBar snackBar = SnackBar(
                content: Text(_pass),
                action: SnackBarAction(
                    label: 'Copy',
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: _pass));
                    }),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }, 'Generate', Icons.password)
          ],
        ),
      ),
    );
  }
}
