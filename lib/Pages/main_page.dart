import 'dart:io';
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _drawerscaffoldkey,
        // resizeToAvoidBottomInset: false,
        drawer: Drawer(
          elevation: 1,
          backgroundColor: blurBlack,
          child: ListView(
            children: [
              DrawerHeader(
                  child: RichText(
                text: TriaHeader2('Hi \n\t', color: white, children: [
                  TriaHeader1(
                      Provider.of<ChangeVal>(context, listen: true).name,
                      color: primaryColor)
                ]),
              )),
              TriaMenuItem('Change Name', () {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      TextEditingController _controller =
                          TextEditingController();
                      return AlertDialog(
                        title: const Text('Change Name'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextField(
                                controller: _controller,
                                decoration:
                                    const InputDecoration(hintText: 'Name ?'),
                              ),
                              TriaButton(() {
                                SPData().setNewName(context,
                                    newName: _controller.text);
                                SnackBar snackBar = SnackBar(
                                  content: Text(
                                      '${_controller.text} has been saved'),
                                  duration: const Duration(seconds: 1),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pop(context);
                              }, 'Save', Icons.save)
                            ],
                          ),
                        ),
                      );
                    });
              }, Icons.person),
              TriaMenuItem('Change Password', () {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      TextEditingController _controller =
                          TextEditingController();
                      return AlertDialog(
                        title: const Text('Change Password'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextField(
                                controller: _controller,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    hintText: 'New Password'),
                              ),
                              TriaButton(() {
                                SPData().setNewPass(context,
                                    newPass: _controller.text);
                                SnackBar snackBar = const SnackBar(
                                  content: Text('Password has been saved'),
                                  duration: Duration(seconds: 1),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pop(context);
                              }, 'Save', Icons.save)
                            ],
                          ),
                        ),
                      );
                    });
              }, Icons.lock),
              TriaMenuItem('About Tria', () {
                Widget aboutMe = RichText(
                  text: TriaBody(''' Hello world,
    
    This is Shahryar, the developer of Tria. Passwords are so important in the modern world, but the majority of people use a simple password or use the same password for all accounts. So I created Tria to help them.
    
    Tria is a modern password generator that creates the same password by the same input data, but Tria never saves any password and just uses hash (HMAC/SHA256) to create your passwords. I tried to set all the standards for creating a strong password in Tria, such as:
    
    > At least 8 characters.
    > A mixture of both uppercase and lowercase letters.
    > A mixture of letters and numbers.
    > Inclusion of at least one special character, e.g., ! @ # ? ].
    
    If you like Tria you can support me by sharing Tria with your friends or donating! ''',
                      children: [
                        TriaBody(
                            '\n\nUrl: https://Tirapass.web.app\n\nLicense: GNU General Public License v3.0\n\nversion: 0.1.0',
                            color: lable)
                      ]),
                );
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: RichText(
                          text: TriaHeader2('About Tria', color: primaryColor),
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [aboutMe],
                          ),
                        ),
                      );
                    });
              }, Icons.info),
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
                icon: Icon(Icons.web_asset),
              ),
              Tab(
                icon: Icon(Icons.security),
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
    return WillPopScope(
      onWillPop: () => exit(0),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: RichText(
                    textAlign: TextAlign.center,
                    text: TriaHeader2('generate a new password,\n but you ',
                        children: [
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
          ),
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
    return WillPopScope(
      onWillPop: () => exit(0),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: IntrinsicHeight(
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
                    _name = _nameController.text == ''
                        ? 'tria'
                        : _nameController.text;
                    _code = _codeController.text == ''
                        ? 'tria'
                        : _codeController.text;
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
          ),
        ),
      ),
    );
  }
}
