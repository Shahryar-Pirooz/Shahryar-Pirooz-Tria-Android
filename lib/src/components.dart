// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:triapass/src/custom_color.dart';

class TriaHeader1 extends TextSpan {
  /// This is the first and biggest header. I extended [TextSpan] because I wanted use it in [RichText].
  /// [txt] is main text and required, others variables are not required
  late String txt;
  late Color color;
  TriaHeader1(this.txt, {this.color = black, List<InlineSpan>? children})
      : super(children: children);

  @override
  String? get text => txt;
  @override
  TextStyle? get style => TextStyle(
      color: color,
      fontSize: 36,
      fontFamily: 'MontserratAlternates',
      fontWeight: FontWeight.bold);
}

class TriaHeader2 extends TextSpan {
  /// This is the second and smalles header. I extended [TextSpan] because I wanted use it in [RichText].
  /// [txt] is main text and required, others variables are not required
  late String txt;
  late Color color;
  TriaHeader2(this.txt, {this.color = black, List<InlineSpan>? children})
      : super(children: children);

  @override
  String? get text => txt;
  @override
  TextStyle? get style => TextStyle(
      color: color,
      fontSize: 24,
      fontFamily: 'MontserratAlternates',
      fontWeight: FontWeight.bold);
}

class TriaBody extends TextSpan {
  /// Body text is main text that I use many time. I extended [TextSpan] because I wanted use it in [RichText].
  /// [txt] is main text and required, others are not required.
  late String txt;
  late Color color;
  TriaBody(this.txt, {this.color = black, List<InlineSpan>? children})
      : super(children: children);

  @override
  String? get text => txt;
  @override
  TextStyle? get style =>
      TextStyle(color: color, fontSize: 18, fontFamily: 'MontserratAlternates');
}

class TriaButton extends StatelessWidget {
  /// It is a custom button that includes an icon and text.
  /// All variables of this button except the [onPress], [txt], and [icon]
  /// are optional.
  /// I used [Material] becuase adding color to the [container] is covering over the [inkwell].
  GestureTapCallback onPress;
  String txt;
  IconData icon;
  Color backgroundColor;
  Color textColor;
  Color splashColor;
  TriaButton(this.onPress, this.txt, this.icon,
      {this.textColor = white,
      this.backgroundColor = black,
      this.splashColor = lable,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        color: backgroundColor,
        child: InkWell(
          onTap: onPress,
          splashColor: splashColor,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 3,
                child: Center(
                  child: Icon(
                    icon,
                    color: textColor,
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: RichText(
                  text: TriaBody(txt, color: textColor),
                ),
              ),
            ],
          ),
        ),
      ),
      height: 67,
      width: 164,
      margin: const EdgeInsetsDirectional.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
    );
  }
}
