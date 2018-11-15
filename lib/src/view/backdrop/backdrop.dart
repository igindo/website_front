import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stagexl/stagexl.dart' as xl;

@Component(
    changeDetection: ChangeDetectionStrategy.Stateful,
    directives: const <dynamic>[routerDirectives, coreDirectives],
    pipes: const <dynamic>[commonPipes],
    encapsulation: ViewEncapsulation.Emulated,
    providers: const <dynamic>[],
    selector: 'backdrop',
    template: '''<canvas #stage></canvas>''')
class Backdrop extends ComponentState implements OnInit, OnDestroy {
  @ViewChild('stage')
  CanvasElement canvas;

  @Input()
  set size(int value) => _onSize.add(value);

  final BehaviorSubject<int> _onSize = BehaviorSubject<int>();

  StreamSubscription _resizeSubscription;

  //-----------------------------
  // Constructor
  //-----------------------------

  Backdrop();

  //-----------------------------
  // Lifecycle Methods
  //-----------------------------

  @override
  Future<void> ngOnInit() async {
    final size = await _onSize.first;

    final options = new xl.StageOptions()
      ..stageAlign = xl.StageAlign.TOP_LEFT
      ..stageScaleMode = xl.StageScaleMode.NO_SCALE
      ..renderEngine = xl.RenderEngine.Canvas2D
      ..backgroundColor = 0x121226;

    var stage = new xl.Stage(canvas, options: options);
    var renderLoop = new xl.RenderLoop();
    renderLoop.addStage(stage);

    final bitmapData = await xl.BitmapData.load(
        './static/assets/logo_45.png', new xl.BitmapDataLoadOptions());

    _resizeSubscription = Observable.merge([
      Observable(window.onResize).startWith(null).doOnData((_) {
        canvas.width = window.innerWidth;
        canvas.height = size;

        canvas.style.width = '${window.innerWidth}px';
        canvas.style.height = '${size}px';
      }),
      window.onScroll
    ]).listen((_) => _plotLogo(
        stage, bitmapData, document.scrollingElement.scrollTop ~/ 15));
  }

  @override
  void ngOnDestroy() {
    _resizeSubscription?.cancel();
  }

  void _plotLogo(xl.Stage stage, xl.BitmapData bitmapData, int offset) {
    final decline = 6 * window.innerWidth / 54,
        cols = (window.innerWidth / 54).ceil() + 4;
    final bmp = xl.BitmapData(window.innerWidth, _onSize.value, 0x121226);
    var dx = -250, dy = -offset - decline - 30, tx = 0;
    var data = bitmapData;

    stage.children.toList().forEach(stage.removeChild);

    // ignore: literal_only_boolean_expressions
    while (true) {
      if (dy + decline + 30 >= -150) {
        for (var x = tx; x < cols - tx; x++) {
          bmp.draw(data, xl.Matrix(1, 0, 0, 1, dx + 54 * x, dy + 6 * x));
        }
      }

      dx += 40;
      dy += 105;
      tx--;

      if (dy >= 0) {
        final cy = (dy - 104).abs() / 104;

        data = bitmapData.clone()
          ..colorTransform(
              xl.Rectangle(0, 0, 150, 150), xl.ColorTransform(cy, cy, cy, cy));
      }

      if (dy >= _onSize.value / 4) break;
    }

    var gradientX = xl.GraphicsGradient.linear(0, 0, window.innerWidth, 0),
        gradientY = xl.GraphicsGradient.linear(0, 0, 0, _onSize.value);
    var shapeX = xl.Shape(), shapeY = xl.Shape();

    gradientX.addColorStop(.15, 0xff121226);
    gradientX.addColorStop(.5, 0x00121226);
    gradientX.addColorStop(.85, 0xff121226);

    gradientY.addColorStop(.0, 0x00121226);
    gradientY.addColorStop(1.0, 0xff121226);

    shapeX.graphics
      ..beginPath()
      ..moveTo(0, 0)
      ..lineTo(window.innerWidth, 0)
      ..lineTo(window.innerWidth, _onSize.value)
      ..lineTo(0, _onSize.value)
      ..closePath()
      ..fillGradient(gradientX);

    shapeY.graphics
      ..beginPath()
      ..moveTo(0, 0)
      ..lineTo(window.innerWidth, 0)
      ..lineTo(window.innerWidth, _onSize.value)
      ..lineTo(0, _onSize.value)
      ..closePath()
      ..fillGradient(gradientY);

    bmp.draw(shapeY);
    bmp.draw(shapeX);

    stage.addChild(xl.Bitmap(bmp));
  }
}
