import 'dart:html';

import 'package:angular/angular.dart';

import 'package:igindo_home/src/utils/dynamic_css_service.dart';
import 'package:igindo_home/src/utils/keygen_service.dart';

@Component(
    changeDetection: ChangeDetectionStrategy.Stateful,
    directives: const <dynamic>[coreDirectives],
    pipes: const <dynamic>[commonPipes],
    encapsulation: ViewEncapsulation.Emulated,
    providers: const <dynamic>[],
    selector: 'bubble',
    template: '''<ng-content></ng-content>''',
    styleUrls: ['bubble.css'])
class Bubble extends ComponentState implements OnInit, OnDestroy {
  final Element _element;
  final DynamicCSSService _dynamicCSSService;
  final String animationInKey, animationOutKey;

  @Input()
  int tweenTo, offsetLeft, offsetRight;

  @Input()
  String animationDelay = '2s', animationDuration = '1s';

  //-----------------------------
  // Constructor
  //-----------------------------

  Bubble(
      @Inject(Element) this._element,
      @Inject(DynamicCSSService) this._dynamicCSSService,
      @Inject(KeygenService) KeygenService keygenService)
      : animationInKey = keygenService.generate(),
        animationOutKey = keygenService.generate();

  //-----------------------------
  // Lifecycle Methods
  //-----------------------------

  @override
  void ngOnInit() {
    final child = _element.children.first;

    if (child is ImageElement) {
      child.onLoad.listen((_) {
        final startOffset = child.client.height + 20;

        _dynamicCSSService.createOrReplaceRule(
            'bubble',
            animationInKey,
            '@keyframes a-$animationInKey',
            '''{
            from {top: -${startOffset}px;}
            to {top: ${tweenTo}px;}
          }''',
            prefixWithDot: false);

        _element.style.animationDelay = animationDelay;
        _element.style.animationDuration = animationDuration;
        _element.style.animationName = 'a-$animationInKey';
        if (offsetLeft != null) _element.style.left = '${offsetLeft}px';
        if (offsetRight != null) _element.style.right = '${offsetRight}px';
        _element.style.top = '-${startOffset}px';
        _element.style.visibility = 'visible';
      });
    }
  }

  @override
  void ngOnDestroy() {
    _dynamicCSSService.flush('bubble', animationInKey);
    _dynamicCSSService.flush('bubble', animationOutKey);
  }

  void unload() {
    final rect = _element.getBoundingClientRect();

    if (rect.top >= -rect.height) {
      _dynamicCSSService.createOrReplaceRule(
          'bubble',
          animationOutKey,
          '@keyframes a-$animationOutKey',
          '''{
            from {top: ${rect.top}px;}
            to {top: ${tweenTo + window.innerHeight}px;}
          }''',
          prefixWithDot: false);

      _element.style.animationName = 'a-$animationOutKey';
      _element.style.animationDelay = '0s';
      _element.style.animationDuration = '1s';
    } else {
      _element.style.display = 'none';
    }
  }
}
