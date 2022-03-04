import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/src/provider.dart';
import 'package:triapass/main.dart';
import 'package:triapass/password_generate.dart';
import 'package:triapass/src/components.dart';
import 'package:triapass/src/custom_color.dart';

class MainPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      GlobalKey<ScaffoldState>();
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _name = Provider.of<ChangeVal>(context, listen: false).name;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _drawerscaffoldkey,
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
          elevation: 1,
          backgroundColor: blurBlack,
          child: ListView(
            children: [
              DrawerHeader(
                  child: RichText(
                text: TriaHeader2('Hi \n\t',
                    color: white,
                    children: [TriaHeader1(_name, color: primaryColor)]),
              )),
              TriaMenuItem('Change Name', () {}, Icons.person),
              TriaMenuItem('Change Code', () {}, Icons.lock),
              TriaMenuItem('About Tria', () {}, Icons.info),
            ],
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(context.watch<ChangeDrawerIcon>().icon),
            onPressed: () {
              if (_drawerscaffoldkey.currentState!.isDrawerOpen) {
                Navigator.pop(context);
              } else {
                _drawerscaffoldkey.currentState!.openDrawer();
              }
            },
          ),
          automaticallyImplyLeading: false,
          backgroundColor: black,
          foregroundColor: primaryColor,
          shadowColor: lable,
          elevation: 10,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.web_stories,
                ),
              ),
              Tab(
                icon: Icon(Icons.privacy_tip_rounded),
              )
            ],
            labelColor: primaryColor,
            indicatorColor: primaryColor,
            unselectedLabelColor: lable,
          ),
        ),
        body: TabBarView(children: [
          ByDomain(),
          ByName(),
        ]),
      ),
    );
  }
}

class ByDomain extends StatelessWidget {
  final _domainController = TextEditingController();
  final _codeController = TextEditingController();

  ByDomain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SPData().initProviderData(context);
    String _name = context.watch<ChangeVal>().name;
    String _domain = '';
    String _code = '';
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
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(hintText: 'Code'),
                    textAlign: TextAlign.center,
                    controller: _codeController,
                    obscureText: true,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: 'Domain'),
                    textAlign: TextAlign.center,
                    controller: _domainController,
                    keyboardType: TextInputType.url,
                  ),
                ],
              ),
            ),
            TriaButton(() {
              _domain = _domainController.text;
              _code = _codeController.text;
              Map<String, String> stringMap = {
                'name': _name.toLowerCase(),
                'code': _code,
                'domain': _domain.toLowerCase()
              };
              String _pass = passwordGenerator(stringMap);
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

class ByName extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _domainController = TextEditingController();

  ByName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _name = '';
    String _code = '';
    String _domain = '';
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(hintText: 'Name'),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                controller: _nameController,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(hintText: 'Code'),
                obscureText: true,
                textAlign: TextAlign.center,
                controller: _codeController,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(hintText: 'Domain'),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.url,
                controller: _domainController,
              ),
            ),
            TriaButton(() {
              _name =
                  _nameController.text == '' ? 'tria' : _nameController.text;
              _code =
                  _codeController.text == '' ? 'tria' : _codeController.text;
              _domain = _domainController.text == ''
                  ? 'tria'
                  : _domainController.text;
              Map<String, String> stringMap = {
                'name': _name.toLowerCase(),
                'code': _code.toLowerCase(),
                'domain': _domain.toLowerCase()
              };
              String _pass = passwordGenerator(stringMap);
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
