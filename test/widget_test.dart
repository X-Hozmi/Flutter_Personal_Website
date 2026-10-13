import 'package:flutter/material.dart';
import 'package:flutter_personal_website/presentation/pages/home/parts/section_heading.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SectionHeading renders title and subtitle', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SectionHeading(
            title: 'Projects',
            subtitle: 'Selected work.',
          ),
        ),
      ),
    );

    expect(find.text('Projects'), findsOneWidget);
    expect(find.text('Selected work.'), findsOneWidget);
  });
}
