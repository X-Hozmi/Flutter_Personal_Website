import 'package:flutter/material.dart';
import 'package:flutter_personal_website/presentation/pages/home/home_page.dart';
import 'package:flutter_personal_website/presentation/widgets/info_card.dart';
import 'package:flutter_personal_website/utils/cv_data.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pumps [child] in a narrow, scrollable viewport with enlarged text so any
/// layout overflow surfaces as a test failure.
Future<void> pumpNarrow(WidgetTester tester, Widget child) async {
  tester.view.physicalSize = const Size(360, 800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    MaterialApp(
      home: MediaQuery(
        data: const MediaQueryData(
          size: Size(360, 800),
          textScaler: TextScaler.linear(1.5),
        ),
        child: Scaffold(body: SingleChildScrollView(child: child)),
      ),
    ),
  );
}

void main() {
  testWidgets('experience, research, education fit a narrow screen', (
    tester,
  ) async {
    await pumpNarrow(
      tester,
      const Column(
        children: [ExperienceSection(), ResearchSection(), EducationSection()],
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Data Management & IT Staff'), findsOneWidget);
    expect(find.text('Manuscript in submission'), findsOneWidget);
  });

  testWidgets('certificates are grouped and expandable', (tester) async {
    await pumpNarrow(tester, const CertificatesSection());

    final groups = CertificatesSection.groupCertificates(CvData.certificates);
    expect(groups.values.expand((list) => list).length, 28);
    expect(find.byType(ExpansionTile), findsNWidgets(groups.length));

    await tester.ensureVisible(find.text('Oracle Academy'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Oracle Academy'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Database Design'), findsOneWidget);
  });

  testWidgets('contact section shows links and CV download', (tester) async {
    await pumpNarrow(tester, const ContactSection());

    expect(tester.takeException(), isNull);
    expect(find.text('LinkedIn'), findsOneWidget);
    expect(find.text('Download CV (PDF)'), findsOneWidget);
  });

  testWidgets('TitleWithPeriod stacks on narrow widths', (tester) async {
    await pumpNarrow(
      tester,
      const TitleWithPeriod(
        title: 'A very long project title that would not fit in one row',
        period: 'June 2025 – present',
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.byType(Row), findsNothing);
  });

  test('certificates with a verify link also carry a credential ID', () {
    for (final certificate in CvData.certificates) {
      if (certificate.verifyUrl != null) {
        expect(
          certificate.verifyUrl,
          endsWith(certificate.credentialId!),
          reason: certificate.title,
        );
      }
    }
  });
}
