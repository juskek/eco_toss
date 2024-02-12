import 'package:json_annotation/json_annotation.dart';

part 'eco_toss_user.g.dart';

@JsonSerializable()
class EcoTossUser {
  EcoTossUser({required this.userId, this.name});
  String userId;
  String? name;

  factory EcoTossUser.fromJson(Map<String, dynamic> json) =>
      _$EcoTossUserFromJson(json);

  Map<String, dynamic> toJson() => _$EcoTossUserToJson(this);
}
