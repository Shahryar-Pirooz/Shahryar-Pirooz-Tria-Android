import 'package:flutter/material.dart';
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
    String name = context.watch<ChangeVal>().name;
    String code = context.watch<ChangeVal>().code;
    String domain = '';

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
              text: TriaBody('generate a new password,\n but you ', children: [
                TriaBody('don’t ', color: primaryColor),
                TriaBody('need to '),
                TriaBody('remember ', color: primaryColor),
                TriaBody(' it.')
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
              domain = domainController.text;
              Map<String, String> stringMap = {
                'name': name,
                'code': code,
                'domain': domain
              };
            }, 'copy', Icons.copy)
          ],
        ),
      ),
    );
  }
}
