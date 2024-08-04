import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import 'package:url_launcher/url_launcher.dart';

class ExperiencesSection extends StatelessWidget {
  final List<Map<String, dynamic>> experiences = [
    {
      'period': '2023 — PRESENT',
      'title': 'Lead Senior Mobile Engineer',
      'company': 'LightWork',
      'description':
          'Build and maintain the first AI-managed property management app to launch in the UK market. As the lead mobile developer, work closely with the web team to deliver LightWork, ensuring seamless integration and adherence to industry best practices in mobile development and user experience',
      'tags': [
        'Flutter',
        'RESTful APIs',
        'PostHog',
        'Mapbox',
        'Hubspot',
        'Postman',
        'JSON',
        'HTML',
        'A/B testing',
        'QA',
        'Ios',
        'Android'
      ],
      'showApps': false,
      'url': 'https://dev.lightwork.blue/',
    },
    {
      'period': '2021 — 2023        ',
      'title': 'Software Engineer',
      'company': 'iyzico',
      'description':
          'Architected and delivered 12+ high-performance features across iOS and Android, resulting in a 35% increase in user engagement and a 20% boost in transaction volume over 2 years',
      'tags': [
        'React Native',
        'SDK',
        'Version Control',
        'JSON',
        'HTML',
        'A/B testing',
        'QA'
      ],
      'showApps': true,
      'url': 'https://www.iyzico.com/en',
    },
    {
      'period': '2019 — 2020        ',
      'title': 'Creative Technologist Co-op',
      'company': 'MullenLowe U.S.',
      'description':
          'Developed, maintained, and shipped production code for client apps. clients included JetBlue, Lovesac, and more.',
      'tags': [
        'Javascript',
        'JQuary',
        'Html',
        'Dart',
        'CP Testing',
      ],
      'showApps': false,
      'url': 'https://us.mullenlowe.com/',
    },
    {
      'period': '2018 — 2019        ',
      'title': 'Developer',
      'company': 'MindPal inc.',
      'description':
          'Optimized MindPals flagship mental wellness app, achieving a 4.8-star rating on the App Store and garnering praise for its intuitive design and personalized features. Pioneered the integration of cutting-edge technologies like mood tracking and guided meditations, contributing to a 30% increase in user retention within the first 6 months.',
      'tags': [
        'Ios',
        'Android',
        'Figma',
        'React',
        'Contentful',
        'Node.js',
      ],
      'showApps': false,
      'url': null,
    },
    // Add more experiences here
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: experiences
          .map((experience) => _buildExperienceCard(experience))
          .toList(),
    );
  }

  Widget _buildExperienceCard(Map<String, dynamic> experience) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.only(top: 16, bottom: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  shadcn.Text(
                    experience['period'],
                    style: const TextStyle(
                      color: Color(0xFF607B96),
                      fontWeight: FontWeight.w600,
                    ),
                  ).xSmall(),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: HoverableTitle(
                            title:
                                '${experience['title']} · ${experience['company']}',
                            url: experience['url'],
                          ),
                        ),
                        const Icon(Icons.open_in_new,
                            color: Colors.white, size: 16),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      experience['description'],
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (experience['showApps'] == true) ...[
                      Row(
                        children: [
                          Wrap(
                            spacing: 8,
                            children: [
                              _buildAppLink(
                                'Android App',
                                'https://play.google.com/store/apps/details?id=com.iyzico.assistant&hl=en',
                              ),
                              _buildAppLink(
                                'iOS App',
                                'https://apps.apple.com/us/app/iyzico/id1436467445',
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                    Wrap(
                      spacing: 8,
                      children: experience['tags'].map<Widget>((tag) {
                        return shadcn.Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            tag,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ).withPadding(
                          vertical: 3,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppLink(String text, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
        child: Row(
          children: [
            Icon(
              Icons.link,
              color: Colors.blue,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              text,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HoverableTitle extends StatefulWidget {
  final String title;
  final String? url;

  const HoverableTitle({Key? key, required this.title, this.url})
      : super(key: key);

  @override
  _HoverableTitleState createState() => _HoverableTitleState();
}

class _HoverableTitleState extends State<HoverableTitle> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: widget.url != null
            ? () async {
                if (await canLaunch(widget.url!)) {
                  await launch(widget.url!);
                } else {
                  throw 'Could not launch ${widget.url}';
                }
              }
            : null,
        child: Text(
          widget.title,
          style: TextStyle(
            color: _isHovered ? Colors.blue : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

extension HoverExtensions on Widget {
  Widget withHoverHighlight() {
    return MouseRegion(
      onEnter: (_) {},
      onExit: (_) {},
      child: this,
    );
  }
}
