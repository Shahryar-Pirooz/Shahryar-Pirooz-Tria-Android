// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:triapass/src/custom_color.dart';

class TriaHeader1 extends TextSpan {
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
