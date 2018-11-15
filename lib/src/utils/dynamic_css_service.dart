import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

@Injectable()
class DynamicCSSService {
  final StreamController<bool> _isFullyFlushed$ctrl =
      new StreamController<bool>.broadcast();
  final StreamController<bool> _change$ctrl =
      new StreamController<bool>.broadcast();

  Stream<bool> get isFullyFlushed => _isFullyFlushed$ctrl.stream;
  Stream<bool> get change => _change$ctrl.stream;

  final Map<String, Map<String, IndexedCssRule>> _dynamicRules =
      <String, Map<String, IndexedCssRule>>{};

  CssStyleSheet _cssStyleSheet;

  DynamicCSSService();

  void createOrReplaceRule(
      String groupName, String uniqueName, String cssClassName, String cssStyle,
      {bool prefixWithDot= true, String cachedCssRule}) {
    if (cssStyle.compareTo('{}') == 0) return;

    if (!_dynamicRules.containsKey(groupName))
      _dynamicRules[groupName] = <String, IndexedCssRule>{};

    final existingRule = _dynamicRules[groupName][uniqueName];
    final cssRule = cachedCssRule != null
        ? cachedCssRule
        : prefixWithDot
            ? '.$cssClassName $cssStyle'
            : '$cssClassName $cssStyle';
    final styleSheet = _getStyleSheet();

    if (existingRule != null && existingRule.cssRule.compareTo(cssRule) == 0)
      return;

    flush(groupName, uniqueName);

    _dynamicRules[groupName][uniqueName] =
        new IndexedCssRule(cssRule, styleSheet, getNextIndex());

    _change$ctrl.add(true);
  }

  bool hasRuleInPlace(String groupName, String uniqueName) {
    if (_dynamicRules.containsKey(groupName)) {
      if (uniqueName == null) return true;

      return _dynamicRules[groupName].containsKey(uniqueName);
    }

    return false;
  }

  Map<String, Map<String, IndexedCssRule>> flushAll() {
    final oldRules =
        <String, Map<String, IndexedCssRule>>{};

    _dynamicRules.forEach((String key, Map<String, IndexedCssRule> value) {
      oldRules[key] = <String, IndexedCssRule>{};

      value.forEach(
          (String entry, IndexedCssRule rule) => oldRules[key][entry] = rule);
    });

    _dynamicRules.keys.toList(growable: false).forEach(flush);

    _dynamicRules.clear();

    _isFullyFlushed$ctrl.add(true);
    _change$ctrl.add(true);

    return oldRules;
  }

  void restoreFromCache(Map<String, Map<String, IndexedCssRule>> cache) {
    cache.forEach((String groupName, Map<String, IndexedCssRule> data) {
      data.forEach((String uniqueName, IndexedCssRule cssRule) =>
          createOrReplaceRule(groupName, uniqueName, '', '',
              cachedCssRule: cssRule.cssRule));
    });
  }

  void flush(String groupName, [String uniqueName]) {
    if (_dynamicRules.containsKey(groupName)) {
      if (uniqueName != null &&
          _dynamicRules[groupName].containsKey(uniqueName)) {
        final tuple = _dynamicRules[groupName][uniqueName];

        _getStyleSheet().deleteRule(tuple.index);

        _dynamicRules[groupName].remove(uniqueName);

        _dynamicRules.forEach((String K, Map<String, IndexedCssRule> V) {
          V.forEach((String k, IndexedCssRule v) {
            if (v.index > tuple.index) v.index--;

            V[k] = v;
          });
        });
      } else if (uniqueName == null) {
        final uniqueNames = <String>[];

        _dynamicRules[groupName].forEach((String K, _) => uniqueNames.add(K));

        uniqueNames
            .forEach((String uniqueName) => flush(groupName, uniqueName));
      }
    }

    _change$ctrl.add(true);
  }

  CssStyleSheet _getStyleSheet() {
    if (_cssStyleSheet == null) {
      final styleSheet = new StyleElement();

      document.head.append(styleSheet);

      _cssStyleSheet = styleSheet.sheet as CssStyleSheet;
    }

    return _cssStyleSheet;
  }

  int getNextIndex() {
    var maxIndex = -1;

    _dynamicRules.forEach((_, Map<String, IndexedCssRule> V) {
      V.forEach((_, IndexedCssRule V) {
        if (V.index > maxIndex) maxIndex = V.index;
      });
    });

    return maxIndex + 1;
  }
}

class IndexedCssRule {
  final String cssRule;
  int index = 0;

  IndexedCssRule(this.cssRule, CssStyleSheet styleSheet, int insertIndex) {
    index = styleSheet.insertRule(cssRule, insertIndex);
  }
}
