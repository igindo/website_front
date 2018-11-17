import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

@Component(
    changeDetection: ChangeDetectionStrategy.Stateful,
    directives: const <dynamic>[routerDirectives, coreDirectives],
    pipes: const <dynamic>[commonPipes],
    encapsulation: ViewEncapsulation.Emulated,
    providers: const <dynamic>[],
    selector: 'panel',
    templateUrl: 'panel.html',
    styleUrls: ['panel.css'])
class Panel extends ComponentState {
  final Element _element;

  @Input()
  String anchorName, bubbles = '';

  Iterable<String> get imagePaths =>
      bubbles.split(',').map((src) => src.trim());

  //-----------------------------
  // Constructor
  //-----------------------------

  Panel(@Inject(Element) this._element);

  //-----------------------------
  // Lifecycle Methods
  //-----------------------------

  //-----------------------------
  // Public Methods
  //-----------------------------

  bool inRange() =>
      (_element.getBoundingClientRect().top +
          _element.getBoundingClientRect().height / 2) >=
      .0;
}
