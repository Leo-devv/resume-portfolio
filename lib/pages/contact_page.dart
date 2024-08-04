import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return shadcn.Scaffold(
      child: shadcn.Padding(
        padding: const EdgeInsets.all(16.0),
        child: shadcn.Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Contact Me').h1(),
            const SizedBox(height: 16),
            const Text(
              'Feel free to reach out to me via email or through my social media channels...',
            ).h2(),
          ],
        ),
      ),
    );
  }
}
