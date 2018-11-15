import 'dart:math';

import 'package:angular/angular.dart';

@Injectable()
class KeygenService {

  KeygenService();

  String generate([int seed]) {
    final buffer = new StringBuffer();
    final rnd = new Random(seed);

    buffer.write(rnd.nextInt(0xfffffff).toRadixString(16));
    buffer.write('-');
    buffer.write(rnd.nextInt(0xffff).toRadixString(16));
    buffer.write('-');
    buffer.write(rnd.nextInt(0xffff).toRadixString(16));
    buffer.write('-');
    buffer.write(rnd.nextInt(0xffff).toRadixString(16));
    buffer.write('-');
    buffer.write(rnd.nextInt(0xffffffff).toRadixString(16));
    buffer.write(rnd.nextInt(0xffff).toRadixString(16));

    return buffer.toString();
  }
}
