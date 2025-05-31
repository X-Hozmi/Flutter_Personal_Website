import 'package:equatable/equatable.dart';

class ActivityAssets extends Equatable {
  final String? largeImage;
  final String? largeText;
  final String? smallImage;
  final String? smallText;

  const ActivityAssets({
    this.largeImage,
    this.largeText,
    this.smallImage,
    this.smallText,
  });

  String? get largeImageUrl {
    if (largeImage == null) return null;
    if (largeImage!.startsWith('spotify:')) {
      return 'https://i.scdn.co/image/${largeImage!.substring(8)}';
    }
    return 'https://cdn.discordapp.com/app-assets/$largeImage.png';
  }

  String? get smallImageUrl {
    if (smallImage == null) return null;
    if (smallImage!.startsWith('spotify:')) {
      return 'https://i.scdn.co/image/${smallImage!.substring(8)}';
    }
    return 'https://cdn.discordapp.com/app-assets/$smallImage.png';
  }

  @override
  List<Object?> get props => [largeImage, largeText, smallImage, smallText];
}
