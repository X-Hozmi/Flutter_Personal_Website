import 'package:equatable/equatable.dart';
import 'package:flutter_personal_website/domain/entities/discord_presence/activity_asset.dart';

class ActivityAssetsModel extends Equatable {
  final String? largeImage;
  final String? largeText;
  final String? smallImage;
  final String? smallText;

  const ActivityAssetsModel({
    this.largeImage,
    this.largeText,
    this.smallImage,
    this.smallText,
  });

  factory ActivityAssetsModel.fromJson(Map<String, dynamic> json) {
    return ActivityAssetsModel(
      largeImage: json['large_image'],
      largeText: json['large_text'],
      smallImage: json['small_image'],
      smallText: json['small_text'],
    );
  }

  ActivityAssets toEntity() {
    return ActivityAssets(
      largeImage: largeImage,
      largeText: largeText,
      smallImage: smallImage,
      smallText: smallText,
    );
  }

  @override
  List<Object?> get props => [largeImage, largeText, smallImage, smallText];
}
