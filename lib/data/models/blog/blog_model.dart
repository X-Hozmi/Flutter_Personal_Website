import 'package:equatable/equatable.dart';
import 'package:flutter_personal_website/domain/entities/blog/blog.dart';

class BlogModel extends Equatable {
  final String title;
  final String pubDate;
  final String guid;
  final String? thumbnail;
  final List<String> categories;

  const BlogModel({
    required this.title,
    required this.pubDate,
    required this.guid,
    this.thumbnail,
    required this.categories,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      title: json['title'] as String? ?? '',
      pubDate: json['pubDate'] as String? ?? '',
      guid: json['guid'] as String? ?? '',
      thumbnail:
          (json['thumbnail'] as String?)?.isEmpty ?? true
              ? null
              : json['thumbnail'] as String?,
      categories:
          json['categories'] != null
              ? List<String>.from(json['categories'] as List<dynamic>)
              : <String>[],
    );
  }

  static List<BlogModel> fromApiResponse(Map<String, dynamic> apiResponse) {
    if (apiResponse['items'] == null) {
      return <BlogModel>[];
    }

    final List<dynamic> items = apiResponse['items'] as List<dynamic>;

    if (items.isEmpty) {
      return <BlogModel>[];
    }

    return items
        .map((item) => BlogModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static List<BlogModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => BlogModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'pubDate': pubDate,
      'guid': guid,
      'thumbnail': thumbnail,
      'categories': categories,
    };
  }

  Blog toEntity() {
    return Blog(
      title: title,
      pubDate: pubDate,
      guid: guid,
      thumbnail: thumbnail,
      categories: categories,
    );
  }

  @override
  List<Object?> get props => [title, pubDate, guid, thumbnail, categories];
}
