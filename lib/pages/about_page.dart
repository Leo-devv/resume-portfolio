import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return shadcn.Scaffold(
      child: shadcn.Padding(
        padding: const EdgeInsets.all(16.0),
        child: shadcn.Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('About Me').h1(),
            const SizedBox(height: 16),
            const Text(
              'I am a passionate Senior Software Engineer with extensive experience in developing innovative applications using Flutter and other technologies...',
            ).h2(),
          ],
        ),
      ),
    );
  }
}
