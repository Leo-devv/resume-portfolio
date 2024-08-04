import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

class SkillsCarousel extends StatefulWidget {
  @override
  _SkillsCarouselState createState() => _SkillsCarouselState();
}

class _SkillsCarouselState extends State<SkillsCarousel> {
  late PageController _pageController;
  final List<Map<String, dynamic>> _skills = [
    {'icon': null, 'label': ''}, // Placeholder 1
    {'icon': null, 'label': ''}, // Placeholder 2
    {'icon': Icons.code, 'label': 'Python'},
    {'icon': Icons.flutter_dash, 'label': 'Flutter'},
    {'icon': Icons.bolt, 'label': 'Ubuntu'},
    {'icon': Icons.merge_type, 'label': 'Git'},
    {'icon': Icons.android, 'label': 'Android'},
    {'icon': Icons.apple, 'label': 'iOS'},
    {'icon': Icons.web, 'label': 'Web'},
    {'icon': Icons.security, 'label': 'Cyber Security'},
    {'icon': Icons.data_usage, 'label': 'Data Science'},
    {'icon': Icons.memory, 'label': 'AI'},
    {'icon': null, 'label': ''},
    {'icon': null, 'label': ''},
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.2,
      initialPage: 4,
    );
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.round() + 1;
        if (nextPage >= _skills.length - 4) {
          nextPage = 4;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      margin: const EdgeInsets.all(16),
      child: SizedBox(
        height: 150,
        child: PageView.builder(
          controller: _pageController,
          itemCount: _skills.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildSkillCard(_skills[index]);
          },
        ),
      ),
    );
  }

  Widget _buildSkillCard(Map<String, dynamic> skill) {
    if (skill['icon'] == null) {
      return Container(); // Placeholder for empty spacing
    }
    return MouseRegion(
      onEnter: (_) => setState(() => skill['highlighted'] = true),
      onExit: (_) => setState(() => skill['highlighted'] = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: skill['highlighted'] == true
              ? Colors.blue.shade400
              : Colors.black38,
          borderRadius: BorderRadius.circular(8),
          boxShadow: skill['highlighted'] == true
              ? [
                  BoxShadow(
                      color: Colors.blue.shade400,
                      blurRadius: 7,
                      spreadRadius: 2)
                ]
              : [
                  const BoxShadow(
                      color: Colors.black12, blurRadius: 5, spreadRadius: 1)
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(skill['icon'], size: 40),
            const SizedBox(height: 16),
            Text(
              skill['label'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ).withMargin(horizontal: 10),
    );
  }
}
