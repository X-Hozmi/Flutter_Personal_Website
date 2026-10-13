import 'package:equatable/equatable.dart';

/// A course-completion certificate with optional public verification.
class Certificate extends Equatable {
  final String title;
  final String issuer;

  /// Learning path the course belongs to, used to group certificates.
  final String? track;

  /// Completion date, already formatted for display (e.g. `Sep 2024`).
  final String date;
  final String? credentialId;
  final String? verifyUrl;

  const Certificate({
    required this.title,
    required this.issuer,
    this.track,
    required this.date,
    this.credentialId,
    this.verifyUrl,
  });

  /// Group label combining the issuer and, when present, the learning path.
  String get group => track == null ? issuer : '$issuer · $track';

  @override
  List<Object?> get props => [
    title,
    issuer,
    track,
    date,
    credentialId,
    verifyUrl,
  ];
}
