import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Introduction extends StatelessWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Title of first page",
            body:
                "Here you can write the description of the page, to explain someting...",
            image: Center(
              child: SvgPicture.asset('assets/images/Locked.svg'),
            ),
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
