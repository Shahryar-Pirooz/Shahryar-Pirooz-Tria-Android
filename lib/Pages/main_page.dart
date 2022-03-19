import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:triapass/main.dart';
import 'package:triapass/password_generate.dart';
import 'package:triapass/src/components.dart';
import 'package:triapass/src/custom_color.dart';

class MainPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _drawerScaffoldKey =
      GlobalKey<ScaffoldState>();
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _drawerScaffoldKey,
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
                        //TODO : change it
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
              if (_drawerScaffoldKey.currentState!.isDrawerOpen) {
                Navigator.pop(context);
              } else {
                _drawerScaffoldKey.currentState!.openDrawer();
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
        body: const TabBarView(children: [
          WithoutName(),
          WithName(),
        ]),
      ),
    );
  }
}

class WithoutName extends StatelessWidget {
  const WithoutName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _name = context.watch<ChangeVal>().name;
    String _domain = '';
    String _code = '';

    return WillPopScope(
      onWillPop: () => exit(0),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TriaHeader2('generate a new password,\n but you ',
                        children: [
                          TriaHeader2('don’t ', color: primaryColor),
                          TriaHeader2('need to '),
                          TriaHeader2('remember ', color: primaryColor),
                          TriaHeader2(' it.')
                        ]),
                  ),
                  const Divider(
                    color: white,
                    height: 32,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Your Code',
                      suffixIcon: IconButton(
                        icon: Icon(
                            Provider.of<VisiblePassword>(context, listen: true)
                                    .isVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                        onPressed: () {
                          Provider.of<VisiblePassword>(context, listen: false)
                              .isVisible = Provider.of<VisiblePassword>(context,
                                      listen: false)
                                  .isVisible
                              ? false
                              : true;
                        },
                      ),
                      labelText: 'Code',
                      border: const OutlineInputBorder(),
                    ),
                    textAlign: TextAlign.center,
                    obscureText:
                        Provider.of<VisiblePassword>(context, listen: true)
                            .isHide,
                    onChanged: (value) => _code = value,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {
                      Provider.of<VisiblePassword>(context, listen: false)
                          .isVisible = false;
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  const Divider(
                    color: white,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'EX:google.com',
                        labelText: 'Domain',
                        border: OutlineInputBorder()),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.url,
                    onChanged: (value) => _domain = value,
                    textInputAction: TextInputAction.done,
                  ),
                  const Divider(
                    color: white,
                    height: 24,
                  ),
                  TriaButton(() {
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

class WithName extends StatelessWidget {
  const WithName({Key? key}) : super(key: key);

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
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Divider(
                    color: white,
                    height: 32,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter Your Name',
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => _name = value,
                  ),
                  const Divider(
                    color: white,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Your Code',
                      suffixIcon: IconButton(
                        icon: Icon(
                            Provider.of<VisiblePassword>(context, listen: true)
                                    .isVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                        onPressed: () {
                          Provider.of<VisiblePassword>(context, listen: false)
                              .isVisible = Provider.of<VisiblePassword>(context,
                                      listen: false)
                                  .isVisible
                              ? false
                              : true;
                        },
                      ),
                      labelText: 'Code',
                      border: const OutlineInputBorder(),
                    ),
                    textAlign: TextAlign.center,
                    obscureText:
                        Provider.of<VisiblePassword>(context, listen: true)
                            .isHide,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => _code = value,
                    onFieldSubmitted: (value) {
                      Provider.of<VisiblePassword>(context, listen: false)
                          .isVisible = false;
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  const Divider(
                    color: white,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'EX:google.com',
                        labelText: 'Domain',
                        border: OutlineInputBorder()),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) => _domain = value,
                  ),
                  const Divider(
                    color: white,
                    height: 32,
                  ),
                  TriaButton(() {
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
