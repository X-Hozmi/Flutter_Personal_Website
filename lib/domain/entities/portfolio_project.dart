import 'package:equatable/equatable.dart';

/// A curated project or research entry, mirroring the CV highlights.
class PortfolioProject extends Equatable {
  final String name;
  final String period;
  final String summary;
  final List<String> highlights;
  final String? url;

  const PortfolioProject({
    required this.name,
    required this.period,
    required this.summary,
    required this.highlights,
    this.url,
  });

  @override
  List<Object?> get props => [name, period, summary, highlights, url];
}
