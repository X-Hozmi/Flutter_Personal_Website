import 'package:equatable/equatable.dart';

class SpotifyTimestamps extends Equatable {
  final int start;
  final int end;

  const SpotifyTimestamps({required this.start, required this.end});

  @override
  List<Object?> get props => [start, end];
}
