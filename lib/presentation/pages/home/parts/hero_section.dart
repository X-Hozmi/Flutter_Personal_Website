part of '../home_page.dart';

/// Hero header: avatar, name, roles, and quick GitHub/profile actions.
///
/// [profile] is optional; without it a placeholder avatar is shown.
class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.profile});

  final GitHubProfile? profile;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final colors = Theme.of(context).colorScheme;

    final size = isMobile ? 120.0 : 150.0;
    final avatarUrl = profile?.avatarUrl ?? '';
    final placeholder = Container(
      color: colors.surfaceContainerHighest,
      child: Icon(Icons.person, size: 64, color: colors.onSurfaceVariant),
    );
    final avatar = ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: RemoteImage(
          url: avatarUrl,
          fallback: placeholder,
          semanticLabel: 'Profile picture',
        ),
      ),
    );

    final info = Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Hi there, I\'m',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          CvData.name,
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _RoleChip(
              icon: Icons.code,
              label: 'Backend Developer',
              color: colors.primary,
            ),
            _RoleChip(
              icon: Icons.dns_outlined,
              label: 'Infrastructure Engineer',
              color: colors.tertiary,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            FilledButton.icon(
              onPressed: () => urlLauncher(Uri.parse(CvData.gitHubUrl)),
              icon: const Icon(Icons.open_in_new, size: 18),
              label: const Text('View GitHub'),
            ),
            OutlinedButton.icon(
              onPressed: () => context.goNamed('project'),
              icon: const Icon(Icons.folder_open, size: 18),
              label: const Text('View Projects'),
            ),
          ],
        ),
      ],
    );

    if (isMobile) {
      return Column(
        children: [
          avatar,
          const SizedBox(height: 24),
          info,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 3, child: info),
        const SizedBox(width: 32),
        Expanded(flex: 2, child: Center(child: avatar)),
      ],
    );
  }
}

class _RoleChip extends StatelessWidget {
  const _RoleChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
