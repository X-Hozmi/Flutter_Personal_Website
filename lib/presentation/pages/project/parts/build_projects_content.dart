part of '../project_page.dart';

Widget buildProjectsContent(
  BuildContext context,
  ProjectController projectController,
) {
  switch (projectController.state) {
    case RequestState.loading:
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF58A6FF)),
      );

    case RequestState.error:
      return Center(
        child: Column(
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              'Error: ${projectController.message}',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => projectController.refreshProjects(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF58A6FF),
              ),
              child: const Text('Retry', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );

    case RequestState.empty:
      return Center(
        child: Column(
          children: [
            const Icon(Icons.folder_open, color: Colors.grey, size: 48),
            const SizedBox(height: 16),
            Text(
              projectController.message,
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );

    case RequestState.loaded:
      return Column(
        children: [
          // Responsive Project Grid
          LayoutBuilder(
            builder: (_, constraints) {
              // Determine grid configuration based on screen width
              int crossAxisCount;
              double childAspectRatio;
              double crossAxisSpacing;
              double mainAxisSpacing;

              if (constraints.maxWidth >= 1200) {
                // Large desktop
                crossAxisCount = 3;
                childAspectRatio = 0.8;
                crossAxisSpacing = 24;
                mainAxisSpacing = 24;
              } else if (constraints.maxWidth >= 800) {
                // Desktop/Tablet
                crossAxisCount = 2;
                childAspectRatio = 0.75;
                crossAxisSpacing = 20;
                mainAxisSpacing = 20;
              } else if (constraints.maxWidth >= 600) {
                // Small tablet
                crossAxisCount = 2;
                childAspectRatio = 0.7;
                crossAxisSpacing = 16;
                mainAxisSpacing = 16;
              } else {
                // Mobile
                crossAxisCount = 1;
                childAspectRatio = 1.2;
                crossAxisSpacing = 12;
                mainAxisSpacing = 12;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: mainAxisSpacing,
                ),
                itemCount: projectController.projects.length,
                itemBuilder: (_, index) {
                  return buildProjectCard(
                    context,
                    projectController.projects[index],
                    constraints.maxWidth,
                  );
                },
              );
            },
          ),
        ],
      );

    default:
      return const SizedBox.shrink();
  }
}
