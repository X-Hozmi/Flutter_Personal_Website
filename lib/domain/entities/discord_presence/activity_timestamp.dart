import 'package:equatable/equatable.dart';

class ActivityTimestamps extends Equatable {
  final int? start;
  final int? end;

  const ActivityTimestamps({this.start, this.end});

  @override
  List<Object?> get props => [start, end];
}
