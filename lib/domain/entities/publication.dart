import 'package:equatable/equatable.dart';

/// A research publication or manuscript.
class Publication extends Equatable {
  final String title;
  final String authors;

  /// Venue and status, e.g. `Manuscript in submission · TELKOMNIKA`.
  final String status;
  final String period;

  const Publication({
    required this.title,
    required this.authors,
    required this.status,
    required this.period,
  });

  @override
  List<Object?> get props => [title, authors, status, period];
}
