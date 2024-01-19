import 'package:endless_runner/features/flame_game/physics/physics.dart';
import 'package:flame/components.dart';

abstract class EcoTossPostioning {
  static double? _height;
  static double? _width;

  static Anchor get anchor => Anchor.center;

  static void setCanvasSize(double height, double width) {
    _height = height;
    _width = width;
    print('canvasSize: $height x $width');
  }

  static double get height {
    assert(_height != null, 'did you forget to call setCanvasSize?');
    return _height!;
  }

  static double get width {
    assert(_width != null, 'did you forget to call setCanvasSize?');
    return _width!;
  }

  static double get xPixelsPerMetre =>
      width / (EcoToss3DSpace.xMaxMetres - EcoToss3DSpace.xMinMetres);
  static double get yPixelsPerMetre =>
      height / (EcoToss3DSpace.yMaxMetres - EcoToss3DSpace.yMinMetres);
  static double get zPixelsPerMetre =>
      height / 2 / (EcoToss3DSpace.zMaxMetres - EcoToss3DSpace.zMinMetres);

  static double xMetresToXPixels(double xMetres) {
    assert(xMetres >= EcoToss3DSpace.xMinMetres,
        'xMetres ($xMetres) must be >= xMinMetres (${EcoToss3DSpace.xMinMetres})');
    assert(xMetres <= EcoToss3DSpace.xMaxMetres,
        'xMetres ($xMetres) must be <= xMaxMetres (${EcoToss3DSpace.xMaxMetres})');
    final distanceFromMidMetres = xMetres - EcoToss3DSpace.xMidMetres;
    return distanceFromMidMetres * xPixelsPerMetre;
  }

  static double yMetresToYPixels(double yMetres) {
    assert(yMetres >= EcoToss3DSpace.yMinMetres,
        'yMetres ($yMetres) must be >= yMinMetres (${EcoToss3DSpace.yMinMetres})');
    assert(yMetres <= EcoToss3DSpace.yMaxMetres,
        'yMetres ($yMetres) must be <= yMaxMetres (${EcoToss3DSpace.yMaxMetres})');
    final distanceFromMidMetres = -(yMetres - EcoToss3DSpace.yMidMetres);
    return distanceFromMidMetres * yPixelsPerMetre;
  }

  static double zMetresToZPixels(double zMetres) {
    assert(zMetres >= EcoToss3DSpace.zMinMetres,
        'zMetres ($zMetres) must be >= zMinMetres (${EcoToss3DSpace.zMinMetres})');
    assert(zMetres <= EcoToss3DSpace.zMaxMetres,
        'zMetres ($zMetres) must be <= zMaxMetres (${EcoToss3DSpace.zMaxMetres})');
    final distanceFromMidMetres = -(zMetres - EcoToss3DSpace.zMinMetres);
    return distanceFromMidMetres * zPixelsPerMetre + height / 2;
  }
}
