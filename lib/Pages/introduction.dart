import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:triapass/Pages/main_page.dart';
import 'package:triapass/main.dart';
import 'package:triapass/src/components.dart';
import 'package:triapass/src/custom_color.dart';

class Introduction extends StatelessWidget {
  final passController = TextEditingController();
  final nameController = TextEditingController();
  Introduction({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SPData().setFalse();
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                TriaBody('\nit can be empty and you can change it later',
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
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                ),
                TriaButton(() {
                  SPData().setNewName(context, newName: nameController.text);
                  SnackBar snackBar = SnackBar(
                    content: Text('${nameController.text} has been saved'),
                    duration: const Duration(seconds: 1),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }, 'save', Icons.save),
              ],
            ),
          ),
          //Fourth page
          PageViewModel(
            image: RichText(
              textAlign: TextAlign.center,
              text: TriaHeader2('Now set \na', children: [
                TriaHeader1(' Passwrod'),
                TriaBody('\nIt is recommended not to leave it empty',
                    color: primaryColor),
              ]),
            ),
            title: '',
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextField(
                  controller: passController,
                  decoration: const InputDecoration(hintText: 'Password'),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  textAlign: TextAlign.center,
                ),
                TriaButton(() {
                  SPData().setNewPass(context, newPass: passController.text);
                  SnackBar snackBar = const SnackBar(
                    content: Text('Password has been saved'),
                    duration: Duration(seconds: 1),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }, 'save', Icons.save),
              ],
            ),
          ),

          //last page
          PageViewModel(
            decoration: const PageDecoration(pageColor: primaryColor),
            image: Image.asset('assets/images/Cat.png'),
            title: '',
            bodyWidget: RichText(
              text: TriaHeader1('Good Lock'),
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
        done: const Text('done'),
        showNextButton: true,
        showBackButton: true,
        onDone: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        },
      ),
    );
  }
}
