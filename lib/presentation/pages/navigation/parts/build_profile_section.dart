part of '../navigation_page.dart';

Widget buildProfileSection(
  BuildContext context,
  ProfileController profileController,
) {
  final isMobile = ResponsiveBreakpoints.of(context).isMobile;

  return Obx(() {
    switch (profileController.state) {
      case RequestState.loading:
        return const Center(
          child: CircularProgressIndicator(color: Color(0xFF58A6FF)),
        );

      case RequestState.loaded:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: SizedBox(
                width: isMobile ? 40 : 50,
                height: isMobile ? 40 : 50,
                child: CachedNetworkImage(
                  imageUrl: profileController.gitHubProfile!.avatarUrl,
                  placeholder:
                      (context, url) => Container(
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                  fit: BoxFit.cover,
                  httpHeaders: gitHubAPIHeaders,
                  errorWidget: (context, url, error) {
                    return Container(
                      color: Colors.grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image,
                            color: const Color.fromRGBO(0, 107, 179, 1),
                            size: isMobile ? 16 : 24,
                          ),
                          if (!isMobile) ...[
                            const SizedBox(height: 4),
                            const Text(
                              'Tidak ada gambar',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: isMobile ? 10 : 15),
            Flexible(
              child: Text(
                profileController.gitHubProfile!.name,
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  });
}
