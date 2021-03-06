import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

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
