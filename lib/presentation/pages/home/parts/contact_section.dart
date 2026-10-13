part of '../home_page.dart';

/// Contact links and a downloadable CV.
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(title: 'Let\'s connect'),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _ContactCard(
              icon: Icons.email_outlined,
              label: CvData.email,
              onTap: () => urlLauncher(Uri.parse('mailto:${CvData.email}')),
            ),
            _ContactCard(
              icon: Icons.phone_outlined,
              label: CvData.phoneDisplay,
              onTap: () => urlLauncher(Uri.parse(CvData.phoneUri)),
            ),
            _ContactCard(
              icon: Icons.work_outline,
              label: 'LinkedIn',
              onTap: () => urlLauncher(Uri.parse(CvData.linkedInUrl)),
            ),
            _ContactCard(
              icon: Icons.code,
              label: 'GitHub',
              onTap: () => urlLauncher(Uri.parse(CvData.gitHubUrl)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed:
              () => urlLauncher(Uri.base.resolve('/${CvData.resumePath}')),
          icon: const Icon(Icons.download),
          label: const Text('Download CV (PDF)'),
        ),
      ],
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.outlineVariant),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: colors.primary),
            const SizedBox(width: 10),
            Flexible(child: Text(label)),
          ],
        ),
      ),
    );
  }
}
