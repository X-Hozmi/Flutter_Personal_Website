import 'package:equatable/equatable.dart';
import 'package:flutter_personal_website/domain/entities/discord_presence/activity_timestamp.dart';

class ActivityTimestampsModel extends Equatable {
  final int? start;
  final int? end;

  const ActivityTimestampsModel({this.start, this.end});

  factory ActivityTimestampsModel.fromJson(Map<String, dynamic> json) {
    return ActivityTimestampsModel(start: json['start'], end: json['end']);
  }

  ActivityTimestamps toEntity() {
    return ActivityTimestamps(start: start, end: end);
  }

  @override
  List<Object?> get props => [start, end];
}
