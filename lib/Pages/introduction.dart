import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triapass/main.dart';
import 'package:triapass/src/components.dart';
import 'package:triapass/src/custom_color.dart';

class SetFalseIsFirst {
  final _prefs = SharedPreferences.getInstance();
  Future<void> setFalse() async {
    final prefs = await _prefs;
    prefs.setBool("isFirst", false).then((bool success) => false);
  }
}

class Introduction extends StatelessWidget {
  const Introduction({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SetFalseIsFirst().setFalse();
    TextEditingController codeController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          //first page
          PageViewModel(
            image: Image.asset('assets/images/Locked.png'),
            title: "",
            bodyWidget: Center(
                child: RichText(
              textAlign: TextAlign.center,
              text: TriaHeader1('Forget your old passwords and use', children: [
                TriaHeader1('Tria', color: primaryColor),
                TriaHeader1('.')
              ]),
            )),
          ),
          //second page
          PageViewModel(
            title: "Why Tria",
            bodyWidget: Center(
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TriaBody('Tria', color: primaryColor, children: [
                      TriaBody(' is full free forever.'),
                      TriaBody('\n\nEasy to use.', color: lable),
                      TriaBody('\n\nTria', color: primaryColor),
                      TriaBody(' never saves your passwords.'),
                      TriaBody('\n\nYou can use strong password anywhere.',
                          color: lable),
                      TriaBody('\n\nYou can even use'),
                      TriaBody(' Tria', color: primaryColor),
                      TriaBody(' offline.')
                    ]))),
            image: Image.asset('assets/images/Searching.png'),
          ),
          //Third page
          PageViewModel(
            image: RichText(
              textAlign: TextAlign.center,
              text: TriaHeader2('At first we need\na', children: [
                TriaHeader1(' NAME'),
                TriaHeader2(' and\nyour'),
                TriaHeader1('CODE'),
                TriaBody(
                    '\nthey can be empty and you can change them form setting any time',
                    color: primaryColor),
              ]),
            ),
            title: '',
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Name'),
                  textAlign: TextAlign.center,
                ),
                TextField(
                  controller: codeController,
                  decoration: const InputDecoration(hintText: 'Code'),
                  obscureText: true,
                  textAlign: TextAlign.center,
                ),
                TriaButton(() {}, 'save', Icons.save)
              ],
            ),
          )
        ],
        next: const Icon(
          Icons.navigate_next,
          color: lable,
        ),
        back: const Icon(
          Icons.navigate_before,
          color: lable,
        ),
        showNextButton: true,
        showBackButton: true,
        done: const TestPage(),
        onDone: () => const TestPage(),
      ),
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
