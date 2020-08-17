import 'package:flutter/cupertino.dart';

enum BuildFlavor { citizen, staff }

BuildEnvironment _env;

BuildEnvironment get env => _env;

class BuildEnvironment {
  final BuildFlavor flavor;

  BuildEnvironment._init({this.flavor});

  static void init({@required flavor}) =>
      _env ??= BuildEnvironment._init(flavor: flavor);
}
