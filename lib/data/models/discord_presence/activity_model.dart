import 'package:equatable/equatable.dart';
import 'package:flutter_personal_website/data/models/discord_presence/activity_asset_model.dart';
import 'package:flutter_personal_website/data/models/discord_presence/activity_timestamp_model.dart';
import 'package:flutter_personal_website/domain/entities/discord_presence/activity.dart';

class ActivityModel extends Equatable {
  final int type;
  final String name;
  final String? details;
  final String? state;
  final ActivityTimestampsModel? timestamps;
  final ActivityAssetsModel? assets;
  final String? applicationId;

  const ActivityModel({
    required this.type,
    required this.name,
    this.details,
    this.state,
    this.timestamps,
    this.assets,
    this.applicationId,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      type: json['type'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      details: json['details'] as String?,
      state: json['state'] as String?,
      timestamps:
          json['timestamps'] != null
              ? ActivityTimestampsModel.fromJson(
                json['timestamps'] as Map<String, dynamic>,
              )
              : null,
      assets:
          json['assets'] != null
              ? ActivityAssetsModel.fromJson(
                json['assets'] as Map<String, dynamic>,
              )
              : null,
      applicationId: json['application_id'] as String?,
    );
  }

  Activity toEntity() {
    return Activity(
      type: type,
      name: name,
      details: details,
      state: state,
      timestamps: timestamps?.toEntity(),
      assets: assets?.toEntity(),
      applicationId: applicationId,
    );
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
