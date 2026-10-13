import 'package:equatable/equatable.dart';

/// A single work experience entry, mirroring the resume PDF.
class WorkExperience extends Equatable {
  final String company;
  final String role;
  final String location;
  final String period;
  final List<String> achievements;

  const WorkExperience({
    required this.company,
    required this.role,
    required this.location,
    required this.period,
    required this.achievements,
  });

  @override
  List<Object?> get props => [company, role, location, period, achievements];
}
