import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return shadcn.Scaffold(
      child: shadcn.Padding(
        padding: const EdgeInsets.all(16.0),
        child: shadcn.Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Projects').h1(),
            const SizedBox(height: 16),
            const Text(
              'Here are some of the projects I have worked on...',
            ).h2(),
          ],
        ),
      ),
    );
  }
}
