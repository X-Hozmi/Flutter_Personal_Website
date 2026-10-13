part of '../home_page.dart';

/// Course-completion certificates grouped by issuer and learning path.
class CertificatesSection extends StatelessWidget {
  const CertificatesSection({super.key});

  /// Groups certificates while preserving the declaration order.
  static Map<String, List<Certificate>> groupCertificates(
    List<Certificate> certificates,
  ) {
    final groups = <String, List<Certificate>>{};
    for (final certificate in certificates) {
      groups.putIfAbsent(certificate.group, () => []).add(certificate);
    }
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    final groups = groupCertificates(CvData.certificates);

    return InfoCard(
      padding: 8,
      // ExpansionTile/ListTile paint ink on the nearest Material, which must
      // sit above the card's background to stay visible.
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          children: [
            for (final entry in groups.entries)
              _CertificateGroup(title: entry.key, certificates: entry.value),
          ],
        ),
      ),
    );
  }
}

class _CertificateGroup extends StatelessWidget {
  const _CertificateGroup({required this.title, required this.certificates});

  final String title;
  final List<Certificate> certificates;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Icon(Icons.workspace_premium_outlined, color: colors.primary),
        title: Text(title, style: Theme.of(context).textTheme.titleSmall),
        subtitle: Text(
          '${certificates.length} '
          '${certificates.length == 1 ? 'certificate' : 'certificates'}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        childrenPadding: const EdgeInsets.only(bottom: 8),
        children: [
          for (final certificate in certificates)
            _CertificateTile(certificate: certificate),
        ],
      ),
    );
  }
}

class _CertificateTile extends StatelessWidget {
  const _CertificateTile({required this.certificate});

  final Certificate certificate;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final verifyUrl = certificate.verifyUrl;
    final credentialId = certificate.credentialId;

    return ListTile(
      dense: true,
      title: Text(certificate.title),
      subtitle: Text(
        credentialId == null
            ? certificate.date
            : '${certificate.date} · ID $credentialId',
        style: TextStyle(color: colors.onSurfaceVariant),
      ),
      trailing:
          verifyUrl == null
              ? null
              : Icon(Icons.verified_outlined, size: 18, color: colors.primary),
      onTap: verifyUrl == null ? null : () => urlLauncher(Uri.parse(verifyUrl)),
    );
  }
}
