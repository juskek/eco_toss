abstract class BinDimensions {
  static const heightMetres = 0.55;
  static const widthMetres = 0.55;
  static const backSurfaceZMetres = 4.0;
  static const frontSurfaceZMetres = 3.4;
  static const depthMetres = backSurfaceZMetres - frontSurfaceZMetres;

  /// The scale factor for the bin's back surface image.
  /// This is used to scale the image to match the bin's logical size (in metres).
  static const binBackSurfaceImageScale = 0.5;
  static const binFrontSurfaceImageScale = 0.5;
  static const binBackSurfaceImageYCorrectionPixels = 50.0;
  static const binFrontSurfaceImageYCorrectionPixels = 5.0;
}
