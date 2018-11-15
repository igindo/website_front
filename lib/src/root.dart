import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart' as router show Location;
import 'package:angular_router/angular_router.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

@Component(
    changeDetection: ChangeDetectionStrategy.Stateful,
    directives: const <dynamic>[routerDirectives, coreDirectives],
    pipes: const <dynamic>[commonPipes],
    encapsulation: ViewEncapsulation.Emulated,
    providers: const <dynamic>[
      routerProviders,
      const ValueProvider.forToken(appBaseHref, '/'),
      const ClassProvider(LocationStrategy, useClass: HashLocationStrategy)
    ],
    selector: 'root',
    template: r'''
      <label>Hi there!</label>
    ''')
class Root extends ComponentState {

  //-----------------------------
  // Constructor
  //-----------------------------

  Root();

  //-----------------------------
  // Lifecycle Methods
  //-----------------------------
}
