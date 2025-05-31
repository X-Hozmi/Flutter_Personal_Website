import 'package:equatable/equatable.dart';
import 'package:flutter_personal_website/domain/entities/discord_presence/activity_asset.dart';
import 'package:flutter_personal_website/domain/entities/discord_presence/activity_timestamp.dart';

class Activity extends Equatable {
  final int type;
  final String name;
  final String? details;
  final String? state;
  final ActivityTimestamps? timestamps;
  final ActivityAssets? assets;
  final String? applicationId;

  const Activity({
    required this.type,
    required this.name,
    this.details,
    this.state,
    this.timestamps,
    this.assets,
    this.applicationId,
  });

  String get activityType {
    switch (type) {
      case 0:
        return 'Playing';
      case 1:
        return 'Streaming';
      case 2:
        return 'Listening to';
      case 3:
        return 'Watching';
      case 4:
        return 'Custom Status';
      case 5:
        return 'Competing in';
      default:
        return 'Unknown';
    }
  }

  @override
  List<Object?> get props => [
    type,
    name,
    details,
    state,
    timestamps,
    assets,
    applicationId,
  ];
}
