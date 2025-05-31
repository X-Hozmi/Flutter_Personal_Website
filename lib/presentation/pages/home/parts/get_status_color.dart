part of '../home_page.dart';

Color getStatusColor(DiscordPresenceController discordController) {
  switch (discordController.discordPresence?.discordStatus) {
    case 'online':
      return const Color(0xFF23A55A);
    case 'idle':
      return const Color(0xFFF0B232);
    case 'dnd':
      return const Color(0xFFF23F43);
    case 'offline':
    default:
      return const Color(0xFF80848E);
  }
}
