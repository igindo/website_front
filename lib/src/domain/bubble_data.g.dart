// GENERATED CODE - DO NOT MODIFY BY HAND

part of domain.bubble_data;

// **************************************************************************
// ClassGenerator
// **************************************************************************

@immutable
class _BubbleDataImpl implements BubbleData, TearOffAndValueObjectSchema {
  @override
  final int offsetLeft;
  @override
  final int offsetRight;
  @override
  final int tweenTo;
  @override
  final int hueRotate;
  @override
  final String animationDelay;
  @override
  final String animationDuration;
  @override
  final String src;
  @override
  final double opacity;
  const _BubbleDataImpl(
      {this.offsetLeft,
      this.offsetRight,
      this.tweenTo,
      this.hueRotate,
      this.animationDelay,
      this.animationDuration,
      this.src,
      this.opacity});
  @override
  dynamic getValueFromKey(String key) {
    switch (key) {
      case 'offsetLeft':
        return offsetLeft;
      case 'offsetRight':
        return offsetRight;
      case 'tweenTo':
        return tweenTo;
      case 'hueRotate':
        return hueRotate;
      case 'animationDelay':
        return animationDelay;
      case 'animationDuration':
        return animationDuration;
      case 'src':
        return src;
      case 'opacity':
        return opacity;
    }
    return null;
  }

  @override
  List<TearOffAndValueObjectSchema> expand(
      [List<TearOffAndValueObjectSchema> list]) {
    list ??= <TearOffAndValueObjectSchema>[];
    list.add(this);
    return list;
  }

  @override
  bool operator ==(Object other) =>
      other is BubbleData && other.hashCode == this.hashCode;
  @override
  int get hashCode => hash_finish(hash_combine(
      hash_combine(
          hash_combine(
              hash_combine(
                  hash_combine(
                      hash_combine(
                          hash_combine(
                              hash_combine(0, this.offsetLeft.hashCode),
                              this.offsetRight.hashCode),
                          this.tweenTo.hashCode),
                      this.hueRotate.hashCode),
                  this.animationDelay.hashCode),
              this.animationDuration.hashCode),
          this.src.hashCode),
      this.opacity == null ? null.hashCode : this.opacity.toString().hashCode));
  @override
  Map<String, dynamic> toJSON() => const BubbleDataEncoder().convert(this);
  @override
  Function(dynamic, String, dynamic) getTearOffForKey(String key) {
    switch (key) {
      case 'offsetLeft':
        return null;
      case 'offsetRight':
        return null;
      case 'tweenTo':
        return null;
      case 'hueRotate':
        return null;
      case 'animationDelay':
        return null;
      case 'animationDuration':
        return null;
      case 'src':
        return null;
      case 'opacity':
        return null;
    }
    return null;
  }
}

_BubbleDataImpl _bubbleDataTearOff(
        BubbleData source, String property, dynamic value) =>
    new _BubbleDataImpl(
        offsetLeft: property == 'offsetLeft' ? value as int : source.offsetLeft,
        offsetRight:
            property == 'offsetRight' ? value as int : source.offsetRight,
        tweenTo: property == 'tweenTo' ? value as int : source.tweenTo,
        hueRotate: property == 'hueRotate' ? value as int : source.hueRotate,
        animationDelay: property == 'animationDelay'
            ? value as String
            : source.animationDelay,
        animationDuration: property == 'animationDuration'
            ? value as String
            : source.animationDuration,
        src: property == 'src' ? value as String : source.src,
        opacity: property == 'opacity' ? value as double : source.opacity);

class BubbleDataFactory {
  static BubbleData create(
          {int offsetLeft,
          int offsetRight,
          int tweenTo,
          int hueRotate,
          String animationDelay,
          String animationDuration,
          String src,
          double opacity}) =>
      new _BubbleDataImpl(
          offsetLeft: offsetLeft,
          offsetRight: offsetRight,
          tweenTo: tweenTo,
          hueRotate: hueRotate,
          animationDelay: animationDelay,
          animationDuration: animationDuration,
          src: src,
          opacity: opacity);
}

Uint8List writeBubbleData(BubbleData value) {
  if (value == null) return new Uint8List.fromList(const <int>[0]);
  final data = <int>[1];
  write(data, writeInt(value.offsetLeft));
  write(data, writeInt(value.offsetRight));
  write(data, writeInt(value.tweenTo));
  write(data, writeInt(value.hueRotate));
  write(data, writeString(value.animationDelay));
  write(data, writeString(value.animationDuration));
  write(data, writeString(value.src));
  write(data, writeDouble(value.opacity));
  return new Uint8List.fromList(data);
}

BubbleData readBubbleData(Uint8List data) {
  if (data[0] == 0) return null;
  int index = 1, _size;
  _size = data[index];
  final offsetLeft = readInt(
      new Uint8List.fromList(data.sublist(index + 1, index + _size + 1)));
  index += _size + 1;
  _size = data[index];
  final offsetRight = readInt(
      new Uint8List.fromList(data.sublist(index + 1, index + _size + 1)));
  index += _size + 1;
  _size = data[index];
  final tweenTo = readInt(
      new Uint8List.fromList(data.sublist(index + 1, index + _size + 1)));
  index += _size + 1;
  _size = data[index];
  final hueRotate = readInt(
      new Uint8List.fromList(data.sublist(index + 1, index + _size + 1)));
  index += _size + 1;
  _size = data[index];
  final animationDelay = readString(
      new Uint8List.fromList(data.sublist(index + 1, index + _size + 1)));
  index += _size + 1;
  _size = data[index];
  final animationDuration = readString(
      new Uint8List.fromList(data.sublist(index + 1, index + _size + 1)));
  index += _size + 1;
  _size = data[index];
  final src = readString(
      new Uint8List.fromList(data.sublist(index + 1, index + _size + 1)));
  index += _size + 1;
  _size = data[index];
  final opacity = readDouble(
      new Uint8List.fromList(data.sublist(index + 1, index + _size + 1)));
  index += _size + 1;
  return new _BubbleDataImpl(
      offsetLeft: offsetLeft,
      offsetRight: offsetRight,
      tweenTo: tweenTo,
      hueRotate: hueRotate,
      animationDelay: animationDelay,
      animationDuration: animationDuration,
      src: src,
      opacity: opacity);
}

class BubbleDataCodec extends Codec<BubbleData, Map<String, dynamic>> {
  const BubbleDataCodec();
  @override
  Converter<BubbleData, Map<String, dynamic>> get encoder =>
      const BubbleDataEncoder();
  @override
  Converter<Map<String, dynamic>, BubbleData> get decoder =>
      const BubbleDataDecoder();
}

class BubbleDataEncoder extends Converter<BubbleData, Map<String, dynamic>> {
  const BubbleDataEncoder();
  @override
  Map<String, dynamic> convert(BubbleData data) => <String, dynamic>{
        'offsetLeft': data?.offsetLeft,
        'offsetRight': data?.offsetRight,
        'tweenTo': data?.tweenTo,
        'hueRotate': data?.hueRotate,
        'animationDelay': data?.animationDelay,
        'animationDuration': data?.animationDuration,
        'src': data?.src,
        'opacity': data?.opacity,
      };
}

class BubbleDataDecoder extends Converter<Map<String, dynamic>, BubbleData> {
  const BubbleDataDecoder();
  @override
  BubbleData convert(Map<String, dynamic> data) => BubbleDataFactory.create(
        offsetLeft: data['offsetLeft'] as int,
        offsetRight: data['offsetRight'] as int,
        tweenTo: data['tweenTo'] as int,
        hueRotate: data['hueRotate'] as int,
        animationDelay: data['animationDelay'] as String,
        animationDuration: data['animationDuration'] as String,
        src: data['src'] as String,
        opacity: data['opacity'] as double,
      );
}

class _BubbleData$<T> extends ObjectSchema<T> {
  const _BubbleData$(List<String> path$) : super(path$);
  ObjectSchema<int> get offsetLeft => new ObjectSchema<int>(path$ != null
      ? (new List<String>.from(path$)..add('offsetLeft'))
      : const <String>['offsetLeft']);
  ObjectSchema<int> get offsetRight => new ObjectSchema<int>(path$ != null
      ? (new List<String>.from(path$)..add('offsetRight'))
      : const <String>['offsetRight']);
  ObjectSchema<int> get tweenTo => new ObjectSchema<int>(path$ != null
      ? (new List<String>.from(path$)..add('tweenTo'))
      : const <String>['tweenTo']);
  ObjectSchema<int> get hueRotate => new ObjectSchema<int>(path$ != null
      ? (new List<String>.from(path$)..add('hueRotate'))
      : const <String>['hueRotate']);
  ObjectSchema<String> get animationDelay =>
      new ObjectSchema<String>(path$ != null
          ? (new List<String>.from(path$)..add('animationDelay'))
          : const <String>['animationDelay']);
  ObjectSchema<String> get animationDuration =>
      new ObjectSchema<String>(path$ != null
          ? (new List<String>.from(path$)..add('animationDuration'))
          : const <String>['animationDuration']);
  ObjectSchema<String> get src => new ObjectSchema<String>(path$ != null
      ? (new List<String>.from(path$)..add('src'))
      : const <String>['src']);
  ObjectSchema<double> get opacity => new ObjectSchema<double>(path$ != null
      ? (new List<String>.from(path$)..add('opacity'))
      : const <String>['opacity']);
}

BubbleData bubbleDataLens<S>(
    BubbleData entity,
    ObjectSchema<S> path(_BubbleData$<BubbleData> schema),
    S swapper(S oldValue)) {
  final schema = path(const _BubbleData$<BubbleData>(null));
  final values = <dynamic>[entity];
  final tearOffs = <dynamic>[_bubbleDataTearOff];
  dynamic newValue;

  for (var i = 0, len = schema.path$.length; i < len; i++) {
    var key = schema.path$[i];
    var currValue = values.last as TearOffAndValueObjectSchema;

    if (i < len - 1) {
      tearOffs.add(currValue.getTearOffForKey(key));
      values.add(currValue.getValueFromKey(key));
    } else {
      newValue = swapper(currValue.getValueFromKey(key) as S);
    }
  }

  for (var i = tearOffs.length - 1; i >= 0; i--) {
    newValue = tearOffs[i](values[i], schema.path$[i], newValue);
  }

  return newValue as BubbleData;
}
