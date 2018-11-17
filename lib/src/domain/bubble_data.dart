library domain.bubble_data;

import 'dart:convert';
import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:corona_core/corona_core.dart';

part 'bubble_data.g.dart';

abstract class BubbleData implements TearOffAndValueObjectSchema {
  int get offsetLeft;
  int get offsetRight;
  int get tweenTo;
  int get hueRotate;
  String get animationDelay;
  String get animationDuration;
  String get src;
  double get opacity;
}
