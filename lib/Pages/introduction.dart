import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:triapass/src/components.dart';
import 'package:triapass/src/custom_color.dart';

class Introduction extends StatelessWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "",
            bodyWidget: Center(
                child: RichText(
              textAlign: TextAlign.center,
              text: TriaHeader1('Forget your old passwords and use', children: [
                TriaHeader1('Tria', color: primaryColor),
                TriaHeader1('.')
              ]),
            )),
            image: Image.asset('assets/images/Locked.png'),
          ),
          PageViewModel(
            title: "Forget your old passwords and use Tria",
            body: '',
            image: Image.asset('assets/images/Searching.png'),
          ),
          PageViewModel(
            title: "Why Tria?",
            bodyWidget: const Center(),
            image: Image.asset('assets/images/Locked.png'),
          ),
        ],
        done: const TestPage(),
        onDone: () => const TestPage(),
        next: const TestPage(),
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
