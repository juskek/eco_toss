import 'package:endless_runner/features/flame_game/physics/physics.dart';
import 'package:flame/components.dart';

abstract class EcoTossPositioning {
  static double? _height;
  static double? _width;

  static Anchor get anchor => Anchor.center;

  static double get leftX {
    assert(_width != null, 'did you forget to call setCanvasSize?');
    return -_width! / 2;
  }

  static double get rightX {
    assert(_width != null, 'did you forget to call setCanvasSize?');
    return _width! / 2;
  }

  static double get topY {
    assert(_height != null, 'did you forget to call setCanvasSize?');
    return -_height! / 2;
  }

  static double get bottomY {
    assert(_height != null, 'did you forget to call setCanvasSize?');
    return _height! / 2;
  }

  static void setCanvasSize(double height, double width) {
    _height = height;
    _width = width;
  }

  static double get height {
    assert(_height != null, 'did you forget to call setCanvasSize?');
    return _height!;
  }

  static double get width {
    assert(_width != null, 'did you forget to call setCanvasSize?');
    return _width!;
  }

  static double get xyzPixelsPerMetre =>
      width / (EcoToss3DSpace.xMaxMetres - EcoToss3DSpace.xMinMetres);

  static double xSizeMetresToPixels(double xSizeMetres) {
    return xSizeMetres * xyzPixelsPerMetre;
  }

  static double ySizeMetresToPixels(double ySizeMetres) {
    return ySizeMetres * xyzPixelsPerMetre;
  }

  static Vector2 xyzMetresToXyPixels(Vector3 xyz) {
    final xPixels = _xPositionMetresToPixels(xyz.x);
    final yPixelsFromYMetres = _yPositionMetresToPixels(xyz.y);
    final yPixelsFromZMetres = _zPositionMetresToPixelsRelativeToY(xyz.z);
    final yPixels = yPixelsFromYMetres + yPixelsFromZMetres;
    return Vector2(xPixels, yPixels);
  }

  static double _xPositionMetresToPixels(double xMetres) {
    assert(xMetres >= EcoToss3DSpace.xMinMetres,
        'xMetres ($xMetres) must be >= xMinMetres (${EcoToss3DSpace.xMinMetres})');
    assert(xMetres <= EcoToss3DSpace.xMaxMetres,
        'xMetres ($xMetres) must be <= xMaxMetres (${EcoToss3DSpace.xMaxMetres})');
    final distanceFromMidMetres = xMetres - EcoToss3DSpace.xMidMetres;
    return distanceFromMidMetres * xyzPixelsPerMetre;
  }

  static double _yPositionMetresToPixels(double yMetres) {
    assert(yMetres >= EcoToss3DSpace.yMinMetres,
        'yMetres ($yMetres) must be >= yMinMetres (${EcoToss3DSpace.yMinMetres})');
    assert(yMetres <= EcoToss3DSpace.yMaxMetres,
        'yMetres ($yMetres) must be <= yMaxMetres (${EcoToss3DSpace.yMaxMetres})');
    final distanceFromMidMetres = -(yMetres - EcoToss3DSpace.yMidMetres);
    return distanceFromMidMetres * xyzPixelsPerMetre;
  }

  static double _zPositionMetresToPixelsRelativeToY(double zMetres) {
    assert(zMetres >= EcoToss3DSpace.zMinMetres,
        'zMetres ($zMetres) must be >= zMinMetres (${EcoToss3DSpace.zMinMetres})');
    assert(zMetres <= EcoToss3DSpace.zMaxMetres,
        'zMetres ($zMetres) must be <= zMaxMetres (${EcoToss3DSpace.zMaxMetres})');
    final distanceFromMidMetres = -(zMetres - EcoToss3DSpace.zMinMetres);
    return distanceFromMidMetres * xyzPixelsPerMetre / 2;
  }
}
