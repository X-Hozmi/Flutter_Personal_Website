import 'package:flutter_personal_website/domain/entities/certificate.dart';
import 'package:flutter_personal_website/domain/entities/education.dart';
import 'package:flutter_personal_website/domain/entities/portfolio_project.dart';
import 'package:flutter_personal_website/domain/entities/publication.dart';
import 'package:flutter_personal_website/domain/entities/work_experience.dart';

/// Static personal data taken from the CVs and certificates in `reference/`.
///
/// The website deliberately keeps this data in code: it is edited rarely and
/// does not depend on external services, so it stays fast and always
/// available even when GitHub or other APIs are unreachable.
class CvData {
  static const String name = 'Abdillah Haidar Mahendro';
  static const String location = 'Bekasi, West Java, Indonesia';
  static const String email = 'abdil.haidar17@gmail.com';
  static const String phoneDisplay = '0889-7766-4271';
  static const String phoneUri = 'tel:+62-889-7766-4271';
  static const String website = 'x-hozmi.github.io';
  static const String linkedInUrl =
      'https://www.linkedin.com/in/abdillah-haidar-mahendro';
  static const String gitHubUrl = 'https://github.com/X-Hozmi';

  /// Resume PDF served from `web/resume/` (relative to the site root).
  static const String resumePath = 'resume/Abdillah_Haidar_Mahendro_-_CV.pdf';

  static const String about =
      'Backend engineer with hands-on depth across the full infrastructure '
      'stack — from designing Laravel-based APIs and payment-system '
      'integrations to owning the servers, databases, and deployment '
      'pipelines those systems run on. Comfortable moving between application '
      'code and the Docker, networking, and monitoring layers beneath it, '
      'with a track record of taking a legacy monolithic platform through a '
      'full containerized, multi-server production migration. Flutter remains '
      'a complementary skill for contributing to mobile front-ends when a '
      'project calls for it.';

  static const String researchFocus =
      'Prospective MS/PhD student in Computer Science '
      '(Resilient Computing & Cybersecurity).';

  static const List<String> researchInterests = [
    'Post-Quantum Cryptography & Migration',
    'Searchable Symmetric Encryption',
    'Resilient Cloud Computing',
    'Threat Modeling',
    'API & Critical Infrastructure Security',
    'Intrusion-Tolerant Distributed Architectures',
  ];

  static const List<PortfolioProject> researchExperiences = [
    PortfolioProject(
      name:
          'Undergraduate Thesis: Fuzzy Searchable Encryption for Cloud '
          'Medical Records',
      period: 'Jan 2026 – July 2026',
      summary:
          'Universitas Bani Saleh · Supervisors: Muhammad Nur, S.Kom., M.Kom. '
          '& Hendra Setiawan, S.Kom., M.Kom.',
      highlights: [
        'Designed an end-to-end client-server Searchable Symmetric '
            'Encryption (SSE) system enabling typo-tolerant keyword search '
            'over AES-256-CBC-encrypted electronic medical records under an '
            'Honest-but-Curious cloud threat model.',
        'Compared N-Gram (bi-gram) expansion and Locality-Sensitive Hashing '
            '(MinHash) against an Exact-Match baseline, evaluating recall, '
            'query latency, and index storage overhead.',
      ],
    ),
  ];

  static const List<Publication> publications = [
    Publication(
      title:
          'Fuzzy Searchable Encryption for Cloud Medical Records: N-Gram vs. '
          'Locality-Sensitive Hashing',
      authors: 'Muhammad Nur, Hendra Setiawan, Abdillah Haidar Mahendro',
      status: 'Manuscript in submission',
      period: 'July 2026',
    ),
  ];

  static const List<WorkExperience> workExperiences = [
    WorkExperience(
      company: 'PT Energi Pelabuhan Indonesia',
      role: 'Data Management & IT Staff',
      location: 'North Jakarta, Indonesia',
      period: 'Jan 2023 – present',
      achievements: [
        'Modernized the company\'s internal ERP system on Laravel 13, '
            'improving long-term maintainability and scalability.',
        'Built backend services compliant with the SNAP API standard, a '
            'bank-driven specification for standardizing communication '
            'between digital payment systems.',
        'Led the migration from a monolithic system architecture to a '
            'containerized Docker setup, enabling flexible deployment '
            'across multiple environments and servers.',
      ],
    ),
  ];

  static const List<Education> educations = [
    Education(
      institution: 'Bani Saleh University',
      degree: 'S.Kom, Informatics Engineering',
      location: 'Bekasi, West Java, Indonesia',
      period: 'Sept 2022 – Sept 2026',
      details: [
        'GPA: 3.74/4.00.',
        'Thesis: Fuzzy Searchable Encryption for Cloud Medical Records: '
            'N-Gram vs. Locality-Sensitive Hashing. Defended and passed on '
            '2 July 2026.',
        'Degree conferral: December 2026.',
      ],
    ),
  ];

  static const List<PortfolioProject> featuredProjects = [
    PortfolioProject(
      name: 'OpenAPI SNAP BI Virtual Account Payment Gateway',
      period: 'Jan 2024 – present',
      summary:
          'Bank Indonesia SNAP-compliant B2B payment backend implemented in '
          'Laravel for PT Energi Pelabuhan Indonesia.',
      url: 'https://github.com/X-Hozmi/openapi-snap-bi',
      highlights: [
        'Implemented a SNAP-compliant B2B Virtual Account gateway covering '
            'authentication, VA inquiry, payment processing, and SNAP '
            'response codes.',
        'Combined OAuth 2.0 Client Credentials, RSA-SHA256 asymmetric '
            'signatures, and HMAC-SHA512 symmetric signatures for '
            'multi-layer API security.',
        'Engineered Redis-backed idempotency and asynchronous settlement '
            'with Laravel job queues, so retries are safe and settlement '
            'never blocks the API request.',
        'Built privacy-aware audit logging that redacts sensitive headers '
            'and payloads before persisting them.',
      ],
    ),
    PortfolioProject(
      name: 'Fuzzy Keyword Searchable Encryption (FKSE) Cloud Testbed',
      period: 'Jan 2026 – July 2026',
      summary:
          'Proof-of-concept client-server cryptographic system enforcing an '
          'Honest-but-Curious cloud threat model.',
      highlights: [
        'Engineered an end-to-end pipeline combining client-side '
            'AES-256-CBC payload encryption, HMAC-SHA256 trapdoor '
            'generation, and remote MySQL inverted indexing.',
        'Benchmarked MinHash LSH against bi-gram tokenization on WHO '
            'ICD-10 medical records, with client-side string-similarity '
            'filtering.',
        'Developed automated benchmarking scripts and statistical tests '
            'for search recall, query latency, and index storage overhead.',
      ],
    ),
    PortfolioProject(
      name: 'UBS Modular LaTeX Academic Publishing Framework',
      period: 'June 2025 – present',
      summary:
          'Open-source academic writing framework for undergraduate '
          'Informatics Engineering students at Universitas Bani Saleh.',
      url: 'https://github.com/X-Hozmi/Template-LaTeX-Tugas-Akhir-Sarjana-UBS',
      highlights: [
        'Modular LaTeX architecture separating metadata, chapters, '
            'appendices, and BibTeX reference management.',
        'One template supporting Proposal, Final Report, and Journal '
            'outputs from the same project structure.',
        'Cross-platform workflow for TeXstudio, VS Code LaTeX Workshop, and '
            'Overleaf with documented XeLaTeX and latexmk recipes.',
        'Actively maintained, with peer code reviews and LaTeX '
            'document-preparation clinics.',
      ],
    ),
  ];

  static const Map<String, List<String>> skillGroups = {
    'Languages': ['PHP', 'Dart', 'Python', 'SQL', 'TeX/LaTeX'],
    'Backend Frameworks': ['Laravel', 'CodeIgniter 3'],
    'Multi-Platform': ['Flutter'],
    'APIs & Architecture': [
      'REST API',
      'API Security',
      'OAuth 2.0',
      'Queue Processing',
    ],
    'Cryptography & Security': [
      'AES-256-CBC/GCM',
      'Searchable Symmetric Encryption',
      'HMAC-SHA256/512',
      'RSA-SHA256',
      'MinHash LSH',
      'Threat Modeling',
    ],
    'Database & Caching': ['MySQL', 'PostgreSQL', 'Redis'],
    'Infrastructure & DevOps': [
      'Linux (Ubuntu/Debian)',
      'Docker',
      'GCP',
      'Nginx',
      'CI/CD',
      'Git',
    ],
    'Monitoring': ['Prometheus', 'Grafana', 'Sentry', 'Cloudflare'],
  };

  static const List<String> softSkills = [
    'Continuous Learning',
    'Attention to detail',
    'Analytical Problem Solving',
    'Crisis Management',
    'Translational Communication',
    'Task Prioritization',
    'Collaboration & Empathy',
  ];

  static const String _dicoding = 'Dicoding Indonesia';
  static const String _cisco = 'Cisco Networking Academy';

  /// Course-completion certificates; attendance-only event certificates are
  /// intentionally excluded.
  static const List<Certificate> certificates = [
    // Dicoding · DevOps Engineer
    Certificate(
      title: 'Belajar Dasar-Dasar DevOps',
      issuer: _dicoding,
      track: 'DevOps Engineer',
      date: 'Aug 2024',
      credentialId: 'JLX17ELJ2X72',
      verifyUrl: 'https://www.dicoding.com/certificates/JLX17ELJ2X72',
    ),
    Certificate(
      title: 'Belajar Jaringan Komputer untuk Pemula',
      issuer: _dicoding,
      track: 'DevOps Engineer',
      date: 'Aug 2024',
      credentialId: 'NVP7QVD2WZR0',
      verifyUrl: 'https://www.dicoding.com/certificates/NVP7QVD2WZR0',
    ),
    Certificate(
      title: 'Menjadi Linux System Administrator',
      issuer: _dicoding,
      track: 'DevOps Engineer',
      date: 'Sep 2024',
      credentialId: '1RXYL8VW3PVM',
      verifyUrl: 'https://www.dicoding.com/certificates/1RXYL8VW3PVM',
    ),
    Certificate(
      title: 'Belajar Implementasi CI/CD',
      issuer: _dicoding,
      track: 'DevOps Engineer',
      date: 'Sep 2024',
      credentialId: 'KEXL1RVVRXG2',
      verifyUrl: 'https://www.dicoding.com/certificates/KEXL1RVVRXG2',
    ),
    Certificate(
      title: 'Belajar Membangun Arsitektur Microservices',
      issuer: _dicoding,
      track: 'DevOps Engineer',
      date: 'Sep 2024',
      credentialId: 'JLX17M6JNX72',
      verifyUrl: 'https://www.dicoding.com/certificates/JLX17M6JNX72',
    ),
    // Dicoding · Back-End Developer
    Certificate(
      title: 'Menjadi Node.js Application Developer',
      issuer: _dicoding,
      track: 'Back-End Developer',
      date: 'Aug 2024',
      credentialId: '81P2ND05OXOY',
      verifyUrl: 'https://www.dicoding.com/certificates/81P2ND05OXOY',
    ),
    Certificate(
      title: 'Belajar Fundamental Aplikasi Back-End',
      issuer: _dicoding,
      track: 'Back-End Developer',
      date: 'Aug 2024',
      credentialId: 'N9ZOM1EQ8PG5',
      verifyUrl: 'https://www.dicoding.com/certificates/N9ZOM1EQ8PG5',
    ),
    Certificate(
      title: 'Cloud Practitioner Essentials (Belajar Dasar AWS Cloud)',
      issuer: _dicoding,
      track: 'Back-End Developer',
      date: 'Sep 2024',
      credentialId: '1OP8W8V2VXQK',
      verifyUrl: 'https://www.dicoding.com/certificates/1OP8W8V2VXQK',
    ),
    Certificate(
      title: 'Menjadi Back-End Developer Expert',
      issuer: _dicoding,
      track: 'Back-End Developer',
      date: 'Sep 2024',
      credentialId: '0LZ067ODRZ65',
      verifyUrl: 'https://www.dicoding.com/certificates/0LZ067ODRZ65',
    ),
    // Dicoding · Google Cloud Professional
    Certificate(
      title: 'Belajar Dasar Google Cloud',
      issuer: _dicoding,
      track: 'Google Cloud Professional',
      date: 'Jul 2024',
      credentialId: '6RPN10315X2M',
      verifyUrl: 'https://www.dicoding.com/certificates/6RPN10315X2M',
    ),
    Certificate(
      title: 'Belajar Dasar Pemrograman JavaScript',
      issuer: _dicoding,
      track: 'Google Cloud Professional',
      date: 'Jul 2024',
      credentialId: 'MRZMEOGORPYQ',
      verifyUrl: 'https://www.dicoding.com/certificates/MRZMEOGORPYQ',
    ),
    Certificate(
      title: 'Menjadi Google Cloud Engineer',
      issuer: _dicoding,
      track: 'Google Cloud Professional',
      date: 'Jul 2024',
      credentialId: 'JMZV38933PN9',
      verifyUrl: 'https://www.dicoding.com/certificates/JMZV38933PN9',
    ),
    Certificate(
      title: 'Menjadi Google Cloud Architect',
      issuer: _dicoding,
      track: 'Google Cloud Professional',
      date: 'Jul 2024',
      credentialId: '07Z60MWNYZQR',
      verifyUrl: 'https://www.dicoding.com/certificates/07Z60MWNYZQR',
    ),
    Certificate(
      title:
          'Belajar Membuat Aplikasi Back-End untuk Pemula dengan Google Cloud',
      issuer: _dicoding,
      track: 'Google Cloud Professional',
      date: 'Aug 2024',
      credentialId: 'NVP7QVDE4ZR0',
      verifyUrl: 'https://www.dicoding.com/certificates/NVP7QVDE4ZR0',
    ),
    // Dicoding · Multi-Platform App Developer
    Certificate(
      title: 'Memulai Pemrograman dengan Dart',
      issuer: _dicoding,
      track: 'Multi-Platform App Developer',
      date: 'Jul 2024',
      credentialId: '4EXGQ86VQZRL',
      verifyUrl: 'https://www.dicoding.com/certificates/4EXGQ86VQZRL',
    ),
    Certificate(
      title: 'Belajar Membuat Aplikasi Flutter untuk Pemula',
      issuer: _dicoding,
      track: 'Multi-Platform App Developer',
      date: 'Jul 2024',
      credentialId: 'JMZV38V1QPN9',
      verifyUrl: 'https://www.dicoding.com/certificates/JMZV38V1QPN9',
    ),
    Certificate(
      title: 'Belajar Fundamental Aplikasi Flutter',
      issuer: _dicoding,
      track: 'Multi-Platform App Developer',
      date: 'Jul 2024',
      credentialId: 'L4PQ17DKQXO1',
      verifyUrl: 'https://www.dicoding.com/certificates/L4PQ17DKQXO1',
    ),
    Certificate(
      title: 'Belajar Pengembangan Aplikasi Flutter Intermediate',
      issuer: _dicoding,
      track: 'Multi-Platform App Developer',
      date: 'Aug 2024',
      credentialId: '07Z60ER7MZQR',
      verifyUrl: 'https://www.dicoding.com/certificates/07Z60ER7MZQR',
    ),
    Certificate(
      title: 'Belajar Prinsip Pemrograman SOLID',
      issuer: _dicoding,
      track: 'Multi-Platform App Developer',
      date: 'Aug 2024',
      credentialId: '1OP8WE608XQK',
      verifyUrl: 'https://www.dicoding.com/certificates/1OP8WE608XQK',
    ),
    Certificate(
      title: 'Menjadi Flutter Developer Expert',
      issuer: _dicoding,
      track: 'Multi-Platform App Developer',
      date: 'Aug 2024',
      credentialId: 'JMZV3J32QPN9',
      verifyUrl: 'https://www.dicoding.com/certificates/JMZV3J32QPN9',
    ),
    // Dicoding · Machine Learning Engineer
    Certificate(
      title: 'Belajar Dasar Visualisasi Data',
      issuer: _dicoding,
      track: 'Machine Learning Engineer',
      date: 'Sep 2024',
      credentialId: '0LZ060N63Z65',
      verifyUrl: 'https://www.dicoding.com/certificates/0LZ060N63Z65',
    ),
    Certificate(
      title: 'Memulai Pemrograman dengan Python',
      issuer: _dicoding,
      track: 'Machine Learning Engineer',
      date: 'Sep 2024',
      credentialId: 'NVP7QL3LVZR0',
      verifyUrl: 'https://www.dicoding.com/certificates/NVP7QL3LVZR0',
    ),
    // Dicoding · standalone
    Certificate(
      title: 'Belajar Dasar Git dengan GitHub',
      issuer: _dicoding,
      date: 'Sep 2024',
      credentialId: 'QLZ97MM22P5D',
      verifyUrl: 'https://www.dicoding.com/certificates/QLZ97MM22P5D',
    ),
    // Cisco Networking Academy
    Certificate(
      title: 'IT Essentials: PC Hardware and Software',
      issuer: _cisco,
      date: 'Mar 2023',
      credentialId: 'b063e3ce-9f37-40aa-aff1-2c68068e270c',
    ),
    Certificate(
      title: 'CCNAv7: Introduction to Networks',
      issuer: _cisco,
      date: 'Mar 2024',
      credentialId: '312d0678-af52-474b-ac7b-34d422ad8a5a',
    ),
    Certificate(
      title: 'CCNAv7: Switching, Routing, and Wireless Essentials',
      issuer: _cisco,
      date: 'Sep 2024',
    ),
    // Database
    Certificate(
      title: 'Database Practitioner',
      issuer: 'DBAcademy',
      date: 'Jan 2026',
    ),
    Certificate(
      title: 'Database Design',
      issuer: 'Oracle Academy',
      date: 'Mar 2026',
    ),
  ];
}
