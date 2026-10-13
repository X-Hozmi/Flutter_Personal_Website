import 'package:equatable/equatable.dart';

/// Higher-education entry, mirroring the CV.
class Education extends Equatable {
  final String institution;
  final String degree;
  final String location;
  final String period;
  final List<String> details;

  const Education({
    required this.institution,
    required this.degree,
    required this.location,
    required this.period,
    this.details = const [],
  });

  @override
  List<Object?> get props => [institution, degree, location, period, details];
}
