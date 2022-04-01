import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:triapass/Pages/main_page.dart';
import 'package:triapass/main.dart';
import 'package:triapass/src/components.dart';
import 'package:triapass/src/custom_color.dart';

class Introduction extends StatelessWidget {
  final _controllerName = TextEditingController();
  final _controllerPassword = TextEditingController();

  Introduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SPData().setFalse();
    String imagePath = "assets/images";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IntroductionScreen(
        pages: [
          //first page
          PageViewModel(
            image: SvgPicture.asset('$imagePath/Locked.svg'),
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
            image: SvgPicture.asset('$imagePath/Searching.svg'),
          ),
          //Third page
          PageViewModel(
            image: RichText(
              textAlign: TextAlign.center,
              text: TriaHeader2('At first we need\na', children: [
                TriaHeader1(' NAME'),
                TriaBody('\nYou can always change your name later',
                    color: primaryColor),
              ]),
            ),
            title: '',
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter a name',
                    border: OutlineInputBorder(),
                    labelText: "Name",
                  ),
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.done,
                  controller: _controllerName,
                  onSubmitted: (value) => saveName(context, value),
                ),
                const Divider(),
                TriaButton(() => saveName(context, _controllerName.text),
                    'Save', Icons.save)
              ],
            ),
          ),
          //Fourth page
          PageViewModel(
            image: RichText(
              textAlign: TextAlign.center,
              text: TriaHeader2('Now set \na', children: [
                TriaHeader1(' Password'),
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
                  decoration: InputDecoration(
                      hintText: 'Authentication',
                      labelText: 'Authentication',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                          icon: Icon(Provider.of<VisiblePassword>(context,
                                      listen: true)
                                  .isVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            Provider.of<VisiblePassword>(context, listen: false)
                                .isVisible = Provider.of<VisiblePassword>(
                                        context,
                                        listen: false)
                                    .isVisible
                                ? false
                                : true;
                          })),
                  keyboardType: TextInputType.text,
                  obscureText:
                      Provider.of<VisiblePassword>(context, listen: false)
                          .isHide,
                  textAlign: TextAlign.center,
                  onSubmitted: (value) => savePassword(context, value),
                ),
                const Divider(),
                TriaButton(
                    () => savePassword(context, _controllerPassword.text),
                    'Save',
                    Icons.save)
              ],
            ),
          ),

          //last page
          PageViewModel(
            decoration: const PageDecoration(pageColor: primaryColor),
            image: SvgPicture.asset('$imagePath/Cat.svg'),
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

  void savePassword(BuildContext context, String value) {
    SPData().setNewPass(context, newPass: value);
    SnackBar snackBar = const SnackBar(
      content: Text('Password has been saved'),
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void saveName(BuildContext context, String value) {
    SPData().setNewName(context, newName: value);
    SnackBar snackBar = SnackBar(
      content: Text('$value has been saved'),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
