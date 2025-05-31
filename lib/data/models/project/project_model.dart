import 'package:equatable/equatable.dart';
import 'package:flutter_personal_website/domain/entities/project/project.dart';

class ProjectModel extends Equatable {
  final int id;
  final String nodeId;
  final String name;
  final String fullName;
  final String htmlUrl;
  final String description;
  final String languagesUrl;

  const ProjectModel({
    required this.id,
    required this.nodeId,
    required this.name,
    required this.fullName,
    required this.htmlUrl,
    required this.description,
    required this.languagesUrl,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] ?? 0,
      nodeId: json['node_id'] ?? '',
      name: json['name'] ?? '',
      fullName: json['full_name'] ?? '',
      htmlUrl: json['html_url'] ?? '',
      description: json['description'] ?? '',
      languagesUrl: json['languages_url'] ?? '',
    );
  }

  static List<ProjectModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => ProjectModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'node_id': nodeId,
      'name': name,
      'full_name': fullName,
      'html_url': htmlUrl,
      'description': description,
      'languages_url': languagesUrl,
    };
  }

  Project toEntity() {
    return Project(
      id: id,
      nodeId: nodeId,
      name: name,
      fullName: fullName,
      htmlUrl: htmlUrl,
      description: description,
      languagesUrl: languagesUrl,
    );
  }

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
