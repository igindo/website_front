import 'dart:async';
import 'dart:html';
import 'dart:math' as math;

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart' as router show Location;
import 'package:angular_router/angular_router.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import 'package:igindo_home/src/domain/bubble_data.dart';

import 'package:igindo_home/src/view/backdrop/backdrop.dart';
import 'package:igindo_home/src/view/bubble/bubble.dart';
import 'package:igindo_home/src/view/panel/panel.dart';

import 'package:igindo_home/src/utils/dynamic_css_service.dart';
import 'package:igindo_home/src/utils/keygen_service.dart';

@Component(
    changeDetection: ChangeDetectionStrategy.Stateful,
    directives: const <dynamic>[
      routerDirectives,
      coreDirectives,
      Backdrop,
      Panel,
      Bubble
    ],
    pipes: const <dynamic>[commonPipes],
    encapsulation: ViewEncapsulation.Emulated,
    providers: const <dynamic>[
      ClassProvider(DynamicCSSService),
      ClassProvider(KeygenService)
    ],
    selector: 'landing',
    templateUrl: 'landing.html',
    styleUrls: ['landing.css'])
class Landing extends ComponentState implements AfterViewInit, OnDestroy {
  final BehaviorSubject<Iterable<Panel>> _onPanels =
      BehaviorSubject<Iterable<Panel>>();
  final BehaviorSubject<Iterable<Bubble>> _onBubbles =
      BehaviorSubject<Iterable<Bubble>>(seedValue: const []);

  @ViewChildren(Panel)
  set onPanels(Iterable<Panel> value) => _onPanels.add(value);

  @ViewChildren(Bubble)
  set onBubbles(Iterable<Bubble> value) => _onBubbles.add(value);

  Stream<List<BubbleData>> _bubbles;
  Stream<List<BubbleData>> get bubbles => _bubbles ??= _onPanels
      .switchMap((panels) => Observable(window.document.onScroll)
          .startWith(null)
          .map((_) => panels)
          .map(_resolveActivePanel))
      .distinct()
      .exhaustMap((panel) => Observable(_onBubbles)
          .take(1)
          .doOnData((bubbles) => bubbles.forEach((bubble) => bubble.unload()))
          .asyncMap((_) => new Future.delayed(const Duration(seconds: 1)))
          .map((_) => panel))
      .map(_loadBubbles);

  //-----------------------------
  // Constructor
  //-----------------------------

  Landing();

  //-----------------------------
  // Lifecycle Methods
  //-----------------------------

  @override
  void ngAfterViewInit() {}

  @override
  void ngOnDestroy() {
    _onPanels.close();
  }

  List<BubbleData> _loadBubbles(Panel panel) {
    final rnd = math.Random();
    final leftOrRight = rnd.nextBool();

    return <BubbleData>[]
      ..addAll(_generateRandomBubbles())
      ..add(BubbleDataFactory.create(
          offsetLeft: leftOrRight
              ? rnd.nextInt(math.max(0, (window.innerWidth - 600) ~/ 2))
              : null,
          offsetRight: leftOrRight
              ? null
              : rnd.nextInt(math.max(9, (window.innerWidth - 600) ~/ 2)),
          tweenTo: 150 + rnd.nextInt(window.innerHeight - 400),
          opacity: 1.0,
          animationDelay: '${rnd.nextDouble() * 1 + .5}s',
          animationDuration: '${rnd.nextDouble() * 2 + .5}s',
          src: './static/assets/office.jpg'))
      ..add(BubbleDataFactory.create(
          offsetLeft: leftOrRight
              ? rnd.nextInt(math.max(0, (window.innerWidth - 600) ~/ 2))
              : null,
          offsetRight: leftOrRight
              ? null
              : rnd.nextInt(math.max(9, (window.innerWidth - 600) ~/ 2)),
          tweenTo: 150 + rnd.nextInt(window.innerHeight - 400),
          opacity: 1.0,
          animationDelay: '${rnd.nextDouble() * 1 + .5}s',
          animationDuration: '${rnd.nextDouble() * 2 + .5}s',
          src: './static/assets/rx.jpg'));
  }

  Panel _resolveActivePanel(Iterable<Panel> panels) =>
      panels.firstWhere((panel) => panel.inRange(), orElse: () => panels.first);

  List<BubbleData> _generateRandomBubbles() {
    final rnd = math.Random();
    final list = <BubbleData>[];
    final count = 10 + rnd.nextInt(20);

    for (var i = 0; i < count; i++) {
      final leftOrRight = rnd.nextBool();

      list.add(BubbleDataFactory.create(
          offsetLeft: leftOrRight ? rnd.nextInt(400) : null,
          offsetRight: leftOrRight ? null : rnd.nextInt(400),
          tweenTo: rnd.nextInt(window.innerHeight),
          opacity: rnd.nextDouble() * .8 + .2,
          animationDelay: '${rnd.nextDouble() * 1 + .5}s',
          animationDuration: '${rnd.nextDouble() * 2 + .5}s',
          src: './static/assets/gen_bubble_${rnd.nextInt(3) + 1}.jpg'));
    }

    return list;
  }
}
