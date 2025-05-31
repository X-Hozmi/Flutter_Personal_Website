import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Blog Posts
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5, // Replace with actual blog count
            itemBuilder: (context, index) {
              return _buildBlogCard(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBlogCard(int index) {
    final blogs = [
      {
        'title': 'Flutter State Management: A Complete Guide',
        'date': 'about 2 weeks ago',
        'tags': ['Flutter', 'State-Management', 'Mobile-Development'],
        'number': '01',
      },
      {
        'title': 'Building Responsive UIs in Flutter',
        'date': 'about 1 month ago',
        'tags': ['Flutter', 'UI-Design', 'Responsive-Design'],
        'number': '02',
      },
      {
        'title': 'Firebase Integration with Flutter Apps',
        'date': 'about 1 month ago',
        'tags': ['Flutter', 'Firebase', 'Backend-Integration'],
        'number': '03',
      },
      {
        'title': 'Advanced Dart Programming Techniques',
        'date': 'about 2 months ago',
        'tags': ['Dart', 'Programming', 'Advanced-Concepts'],
        'number': '04',
      },
      {
        'title': 'My Journey as a Flutter Developer',
        'date': 'about 3 months ago',
        'tags': ['Personal', 'Career', 'Flutter-Development'],
        'number': '05',
      },
    ];

    final blog = blogs[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      // decoration: BoxDecoration(
      //   color: const Color(0xFF161B22),
      //   borderRadius: BorderRadius.circular(8),
      //   border: Border.all(color: const Color(0xFF30363D)),
      // ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Blog Number
          Text(
            blog['number'] as String,
            style: const TextStyle(
              // color: Colors.white30,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 20),
          // Blog Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog['title'] as String,
                  style: const TextStyle(
                    // color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  blog['date'] as String,
                  style: const TextStyle(
                    // color: Colors.white60,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children:
                      (blog['tags'] as List<String>)
                          .map(
                            (tag) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF58A6FF).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: const Color(
                                    0xFF58A6FF,
                                  ).withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                tag,
                                style: const TextStyle(
                                  color: Color(0xFF58A6FF),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
