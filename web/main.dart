import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:igindo_home/src/view/landing/landing.template.dart' as ng;

import 'main.template.dart' as self;

@GenerateInjector(<dynamic>[
  routerProviders,
  const ClassProvider(ExceptionHandler, useClass: BrowserExceptionHandler)
])
const InjectorFactory injector = self.injector$Injector;

void main() {
  runApp(ng.LandingNgFactory, createInjector: injector);
}

@Injectable()
class BrowserExceptionHandler implements ExceptionHandler {
  const BrowserExceptionHandler();

  @override
  void call(dynamic exception, [dynamic stackTrace, String reason]) {
    window.console.error(ExceptionHandler.exceptionToString(
      exception,
      stackTrace,
      reason,
    ));
  }
}
