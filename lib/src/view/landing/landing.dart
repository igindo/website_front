import 'dart:async';
import 'dart:html';
import 'dart:math' as math;

import 'package:angular/angular.dart';
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
      .doOnData((panel) =>
          window.history.pushState(null, null, '#${panel.anchorName}'))
      .switchMap((panel) => Observable(_onBubbles)
          .take(1)
          .doOnData((bubbles) => bubbles.forEach((bubble) => bubble.unload()))
          .asyncMap(
              (_) => new Future.delayed(const Duration(milliseconds: 500)))
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

    return <BubbleData>[]
      ..addAll(_generateRandomBubbles())
      ..addAll(panel.imagePaths.map((src) => Tuple2(src, rnd.nextBool())).map(
          (tuple) => BubbleDataFactory.create(
              offsetLeft: tuple.item2
                  ? rnd.nextInt(math.max(0, window.innerWidth ~/ 2 - 400))
                  : null,
              offsetRight: tuple.item2
                  ? null
                  : rnd.nextInt(math.max(0, window.innerWidth ~/ 2 - 400)),
              tweenTo: 50 + rnd.nextInt(window.innerHeight - 200),
              opacity: 1.0,
              animationDelay: '${rnd.nextDouble() * 1 + .5}s',
              animationDuration: '${rnd.nextDouble() * 2 + .5}s',
              src: tuple.item1)));
  }

  Panel _resolveActivePanel(Iterable<Panel> panels) =>
      panels.firstWhere((panel) => panel.inRange(), orElse: () => panels.first);

  List<BubbleData> _generateRandomBubbles() {
    final rnd = math.Random();
    final list = <BubbleData>[];
    final count = 10 + rnd.nextInt(5);

    for (var i = 0; i < count; i++) {
      final leftOrRight = rnd.nextBool();

      list.add(BubbleDataFactory.create(
          offsetLeft: leftOrRight ? rnd.nextInt(400) : null,
          offsetRight: leftOrRight ? null : rnd.nextInt(400),
          tweenTo: rnd.nextInt(window.innerHeight),
          opacity: rnd.nextDouble(),
          animationDelay: '${rnd.nextDouble()}s',
          animationDuration: '${rnd.nextDouble() * 2 + .5}s',
          src: _createRandomBubble(),
          hueRotate: rnd.nextInt(45)));
    }

    return list;
  }

  String _createRandomBubble() {
    final rnd = math.Random();
    final size = rnd.nextInt(60) + 20;
    final canvas = new CanvasElement(width: size, height: size);
    final CanvasRenderingContext2D context = canvas.getContext('2d');

    final Function() rndColor = () => new List.generate(
            4, (_) => rnd.nextInt(255).toRadixString(16))
        .map((colorPart) => colorPart.length == 1 ? '0$colorPart' : colorPart)
        .join('');

    final gradient = context.createRadialGradient(
        size / 2, size / 2, 0, size / 2, size / 2, size)
      ..addColorStop(0, '#${rndColor()}')
      ..addColorStop(1, '#${rndColor()}');

    context.fillStyle = gradient;
    context.fillRect(0, 0, size, size);

    return canvas.toDataUrl('image/png');
  }
}
