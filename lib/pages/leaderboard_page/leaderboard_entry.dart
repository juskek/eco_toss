import 'package:json_annotation/json_annotation.dart';

part 'leaderboard_entry.g.dart';

@JsonSerializable()
class LeaderboardEntry {
  final String userId;
  final String name;
  final int score;

  LeaderboardEntry({required this.name, required this.score});

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryFromJson(json);

  Map<String, dynamic> toJson() => _$LeaderboardEntryToJson(this);
}
