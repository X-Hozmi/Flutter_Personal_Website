import 'package:equatable/equatable.dart';

class Blog extends Equatable {
  final String title;
  final String pubDate;
  final String guid;
  final String? thumbnail;
  final List<String> categories;

  const Blog({
    required this.title,
    required this.pubDate,
    required this.guid,
    this.thumbnail,
    required this.categories,
  });

  @override
  List<Object?> get props => [title, pubDate, guid, thumbnail, categories];
}
