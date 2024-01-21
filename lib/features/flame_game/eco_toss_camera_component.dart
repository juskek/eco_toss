import 'package:endless_runner/features/flame_game/eco_toss_viewfinder.dart';
import 'package:flame/camera.dart';

class EcoTossCameraComponent extends CameraComponent {
  EcoTossCameraComponent() : super(viewfinder: EcoTossViewfinder());
}
