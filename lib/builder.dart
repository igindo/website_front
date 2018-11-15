import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:corona/src/builder/class_generator.dart' show ClassGenerator;

Builder coronaBuilder(BuilderOptions options) =>
    new PartBuilder(<Generator>[const ClassGenerator()]);
