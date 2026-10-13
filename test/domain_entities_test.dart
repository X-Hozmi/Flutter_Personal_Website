import 'package:checks/checks.dart';
import 'package:flutter_personal_website/domain/entities/blog/blog.dart';
import 'package:flutter_personal_website/domain/entities/certificate.dart';
import 'package:flutter_personal_website/utils/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Certificate', () {
    test('group combines issuer and track', () {
      const certificate = Certificate(
        title: 'Menjadi Linux System Administrator',
        issuer: 'Dicoding Indonesia',
        track: 'DevOps Engineer',
        date: 'Sep 2024',
      );

      check(certificate.group).equals('Dicoding Indonesia · DevOps Engineer');
    });

    test('group falls back to issuer without a track', () {
      const certificate = Certificate(
        title: 'Database Design',
        issuer: 'Oracle Academy',
        date: 'Mar 2026',
      );

      check(certificate.group).equals('Oracle Academy');
    });
  });

  group('Blog', () {
    test('parses a date string', () {
      const blog = Blog(
        title: 'Hello',
        pubDate: '2026-08-01T10:00:00.000Z',
        guid: 'https://medium.com/@haidar17042001/hello',
        categories: ['backend'],
      );

      check(blog.title).equals('Hello');
      check(blog.categories).deepEquals(['backend']);
      check(blog.thumbnail).isNull();
    });

    test('equality is value-based', () {
      const a = Blog(
        title: 'Same',
        pubDate: '2026-08-01T10:00:00.000Z',
        guid: 'https://medium.com/@haidar17042001/same',
        categories: [],
      );
      const b = Blog(
        title: 'Same',
        pubDate: '2026-08-01T10:00:00.000Z',
        guid: 'https://medium.com/@haidar17042001/same',
        categories: [],
      );

      check(a).equals(b);
    });
  });

  group('RequestState', () {
    test('has a loaded state', () {
      check(RequestState.loaded).equals(RequestState.loaded);
      check(RequestState.loaded).not((it) => it.equals(RequestState.error));
    });
  });
}
