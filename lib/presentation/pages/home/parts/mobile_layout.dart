part of '../home_page.dart';

Widget mobileLayout(ProfileController profileController, double imageSize) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ClipOval(
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
                      size: 20,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Tidak ada gambar',
                      style: TextStyle(
                        fontSize: 9,
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
      const SizedBox(height: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Hey there 👋, am', style: TextStyle(fontSize: 14)),
          Text(
            profileController.gitHubProfile!.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            developerRoles,
            style: const TextStyle(fontSize: 13),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
        ],
      ),
    ],
  );
}
