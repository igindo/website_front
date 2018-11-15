import 'dart:async';

import 'package:build_config/build_config.dart';
import 'package:build_runner/build_runner.dart';

import 'package:igindo_home/builder.dart';

Future<BuildResult> main(List<String> args) async => build([
      new BuilderApplication.forBuilder(
          'domain', [coronaBuilder], (PackageNode node) => node.isRoot,
          hideOutput: false,
          defaultGenerateFor:
              const InputSet(include: const <String>['lib/src/domain/*.dart']))
    ], deleteFilesByDefault: true);
