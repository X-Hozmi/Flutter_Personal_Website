import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final int id;
  final String nodeId;
  final String name;
  final String fullName;
  final String htmlUrl;
  final String description;
  final String languagesUrl;

  const Project({
    required this.id,
    required this.nodeId,
    required this.name,
    required this.fullName,
    required this.htmlUrl,
    required this.description,
    required this.languagesUrl,
  });

  @override
  List<Object?> get props => [
    id,
    nodeId,
    name,
    fullName,
    htmlUrl,
    description,
    languagesUrl,
  ];
}
