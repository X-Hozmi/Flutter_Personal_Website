part of '../home_page.dart';

String getPresenceStatusText(DiscordPresenceController discordController) {
  if (discordController.isOffline) {
    return 'Currently offline';
  }

  final statusText = discordController.getStatusDisplayText();
  final activities =
      discordController.activities
          .where((activity) => activity.name != 'Spotify')
          .toList();

  if (activities.isNotEmpty) {
    return '$statusText • ${activities.length} ${activities.length == 1 ? 'activity' : 'activities'}';
  }

  return statusText;
}
