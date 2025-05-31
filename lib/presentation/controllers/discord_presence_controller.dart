import 'dart:async';

import 'package:flutter_personal_website/domain/entities/discord_presence/activity.dart';
import 'package:flutter_personal_website/domain/entities/discord_presence/discord_presence.dart';
import 'package:flutter_personal_website/domain/entities/discord_presence/discord_user.dart';
import 'package:flutter_personal_website/domain/entities/discord_presence/spotify.dart';
import 'package:flutter_personal_website/domain/usecases/get_discord_presence_usecase.dart';
import 'package:flutter_personal_website/utils/state_enum.dart';
import 'package:get/get.dart';

class DiscordPresenceController extends GetxController {
  final GetDiscordPresence getDiscordPresenceUseCase;

  final Rx<RequestState> _state = RequestState.initial.obs;
  final RxString _message = ''.obs;
  final Rx<DiscordPresence?> _discordPresence = Rx<DiscordPresence?>(null);

  Timer? _periodicTimer;

  RequestState get state => _state.value;
  String get message => _message.value;
  DiscordPresence? get discordPresence => _discordPresence.value;

  // Convenience getters
  bool get isOnline => discordPresence?.discordStatus == 'online';
  bool get isIdle => discordPresence?.discordStatus == 'idle';
  bool get isDnd => discordPresence?.discordStatus == 'dnd';
  bool get isOffline => discordPresence?.discordStatus == 'offline';

  bool get isListeningToSpotify => discordPresence?.listeningToSpotify ?? false;
  Spotify? get currentSpotify => discordPresence?.spotify;
  List<Activity> get activities => discordPresence?.activities ?? [];
  DiscordUser? get user => discordPresence?.discordUser;

  DiscordPresenceController({required this.getDiscordPresenceUseCase});

  @override
  void onInit() {
    super.onInit();
    getDiscordPresence();
    startPeriodicUpdates();
  }

  @override
  void onClose() {
    _periodicTimer?.cancel();
    super.onClose();
  }

  Future<void> getDiscordPresence() async {
    _state.value = RequestState.loading;
    update();

    final result = await getDiscordPresenceUseCase.execute();

    result.fold(
      (failure) {
        _state.value = RequestState.error;
        _message.value = failure.message;
        _discordPresence.value = null;
      },
      (success) {
        if (!success.success) {
          _state.value = RequestState.error;
          _message.value = 'Failed to fetch Discord presence';
          _discordPresence.value = null;
        } else {
          _state.value = RequestState.loaded;
          _message.value = '';
          _discordPresence.value = success;
        }
      },
    );

    update();
  }

  Future<void> refreshDiscordPresence() async {
    await getDiscordPresence();
  }

  void startPeriodicUpdates({Duration interval = const Duration(seconds: 30)}) {
    _periodicTimer?.cancel();
    _periodicTimer = Timer.periodic(interval, (_) {
      getDiscordPresence();
    });
  }

  void stopPeriodicUpdates() {
    _periodicTimer?.cancel();
  }

  void clearDiscordPresence() {
    _discordPresence.value = null;
    _state.value = RequestState.initial;
    _message.value = '';
    update();
  }

  // Helper methods for UI
  String getStatusDisplayText() {
    if (discordPresence == null) return 'Unknown';

    switch (discordPresence!.discordStatus) {
      case 'online':
        return 'Online';
      case 'idle':
        return 'Away';
      case 'dnd':
        return 'Do Not Disturb';
      case 'offline':
        return 'Offline';
      default:
        return 'Unknown';
    }
  }

  String getCurrentActivityText() {
    if (activities.isEmpty) return '';

    final activity = activities.first;
    final activityType = activity.activityType;

    if (activity.details != null && activity.state != null) {
      return '$activityType ${activity.name}\n${activity.details}\n${activity.state}';
    } else if (activity.details != null) {
      return '$activityType ${activity.name}\n${activity.details}';
    } else if (activity.state != null) {
      return '$activityType ${activity.name}\n${activity.state}';
    }

    return '$activityType ${activity.name}';
  }

  String getSpotifyText() {
    if (!isListeningToSpotify || currentSpotify == null) return '';

    return 'Listening to ${currentSpotify!.song}\nby ${currentSpotify!.artist}\non ${currentSpotify!.album}';
  }
}
