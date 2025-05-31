part of '../project_page.dart';

Future<List<String>> fetchLanguages(
  String languagesUrl, {
  bool topThreeOnly = false,
}) async {
  // Check cache first
  if (languageCache.containsKey(languagesUrl)) {
    final cached = languageCache[languagesUrl]!;
    return topThreeOnly ? cached.take(3).toList() : cached;
  }

  try {
    final response = await http.get(
      Uri.parse(languagesUrl),
      headers: gitHubAPIHeaders,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> languagesData = json.decode(response.body);

      // Sort languages by usage (value) in descending order
      final sortedEntries =
          languagesData.entries.toList()
            ..sort((a, b) => (b.value as int).compareTo(a.value as int));

      // Extract only the language names (keys)
      final languages = sortedEntries.map((entry) => entry.key).toList();

      // Cache the result
      languageCache[languagesUrl] = languages;

      // Return top 3 if requested, otherwise return all
      return topThreeOnly ? languages.take(3).toList() : languages;
    }
  } catch (e) {
    log('Error fetching languages: $e');
  }

  // Return empty list if API call fails
  return [];
}
