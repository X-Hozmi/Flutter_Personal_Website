part of '../home_page.dart';

Widget desktopLayout(ProfileController profileController, double imageSize) {
  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Hey there 👋, am', style: TextStyle(fontSize: 16)),
              Text(
                profileController.gitHubProfile!.name,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(developerRoles, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 30),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Flexible(
          child: Center(
            child: ClipOval(
              child: SizedBox(
                width: imageSize,
                height: imageSize,
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
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image,
                            color: Color.fromRGBO(0, 107, 179, 1),
                            size: 24,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Tidak ada gambar',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
