import 'package:flutter/material.dart';
import 'package:my_flutter_website/widgets/tiles/experiences_section.dart';
import 'package:my_flutter_website/widgets/tiles/portfolio_section.dart';
import 'dart:async';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  double _progress = 0;
  int _currentSection = 0;
  final List<String> _sections = ['About', 'Experience', 'Projects'];
  int _currentRoleIndex = 0;
  final List<String> _roles = ['Web', 'Mobile', 'FrontEnd', 'Flutter'];
  late AnimationController _animationController;
  late Animation<double> _flipAnimation;
  Offset _mousePosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double maxScrollExtent = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      setState(() {
        _progress = (currentScroll / maxScrollExtent);
        _currentSection = (_progress * (_sections.length - 1)).round();
      });
    });

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _startRoleTransition();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _startRoleTransition() {
    Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      _animationController.forward().then((_) {
        setState(() {
          _currentRoleIndex = (_currentRoleIndex + 1) % _roles.length;
        });
        _animationController.reset();
      });
    });
  }

  void _scrollToSection(int index) {
    double position = 0;
    switch (index) {
      case 0:
        position = 0;
        break;
      case 1:
        position = MediaQuery.of(context).size.height * 0.6;
        break;
      case 2:
        position = MediaQuery.of(context).size.height * 1.2;
        break;
    }
    _scrollController.animateTo(
      position,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseRegion(
        onHover: (event) {
          setState(() {
            _mousePosition = event.position;
          });
        },
        child: CustomPaint(
          painter: BackgroundPainter(_mousePosition),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double leftPadding = constraints.maxWidth > 1800 ? 300 : 100;
              double rightPadding = constraints.maxWidth > 1800 ? 300 : 100;

              if (constraints.maxWidth > 1200) {
                return Row(
                  children: [
                    _buildFixedSide(leftPadding),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: rightPadding,
                              left: 40,
                              bottom: 40,
                              top: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 70),
                              _buildIntroduction(),
                              const SizedBox(height: 40),
                              ExperiencesSection(),
                              const SizedBox(height: 40),
                              PortfolioSection(
                                  scrollController: _scrollController),
                              SizedBox(height: 50),
                              const shadcn.Text(
                                'Loosely designed in Figma and coded in Visual Studio Code by yours truly. Built with Dart, Html  and  Js.',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white38),
                              ).small(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFixedSideSmall(),
                        const SizedBox(height: 20),
                        _buildSectionWithTitle('About', _buildIntroduction()),
                        const SizedBox(height: 20),
                        _buildSectionWithTitle(
                            'Experience', ExperiencesSection()),
                        const SizedBox(height: 20),
                        _buildSectionWithTitle(
                            '',
                            PortfolioSection(
                                scrollController: _scrollController)),
                        const shadcn.Text(
                          'Loosely designed in Figma and coded in Visual Studio Code by yours truly. Built with Dart, Html  and  Js.',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white38),
                        ).small(),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFixedSide(double leftPadding) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding:
          EdgeInsets.only(top: 100, bottom: 100, left: leftPadding, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LEO Mohamed',
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Senior Frontend Engineer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          const shadcn.Text(
            'I build pixel-perfect, engaging, and accessible digital experiences.',
            style: TextStyle(
              color: Colors.white70,
            ),
          ).base(),
          const SizedBox(height: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(_sections.length, (index) {
              return GestureDetector(
                onTap: () {
                  _scrollToSection(index);
                },
                child: _buildSectionLink(
                    _sections[index], index == _currentSection),
              );
            }),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              _buildSocialIcon(
                  shadcn.BootstrapIcons.github, 'https://github.com/Leo-devv'),
              _buildSocialIcon(shadcn.BootstrapIcons.linkedin,
                  'https://www.linkedin.com/in/hussein-h-5579302bb/'),
              _buildSocialIcon(shadcn.BootstrapIcons.instagram,
                  'https://www.instagram.com/lifeofhussey/'),
              _buildSocialIcon(shadcn.BootstrapIcons.mailbox,
                  'mailto:leo.mohaamed@gmail.com'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFixedSideSmall() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const shadcn.Text(
              'LEO MOHAMED',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const shadcn.Text(
              '',
              style: TextStyle(
                color: Colors.white,
              ),
            ).xSmall(),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Senior Frontend Engineer',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        const shadcn.Text(
          'I build pixel-perfect, engaging, and accessible digital experiences.',
          style: TextStyle(
            color: Colors.white70,
          ),
        ).small(),
        const SizedBox(height: 30),
        Row(
          children: [
            _buildSocialIcon(
                shadcn.BootstrapIcons.github, 'https://github.com/Leo-devv'),
            _buildSocialIcon(shadcn.BootstrapIcons.linkedin,
                'https://www.linkedin.com/in/hussein-h-5579302bb/'),
            _buildSocialIcon(shadcn.BootstrapIcons.instagram,
                'https://www.instagram.com/lifeofhussey/'),
            _buildSocialIcon(
                shadcn.BootstrapIcons.mailbox, 'mailto:your-email@example.com'),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () async {
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSectionLink(String text, bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isActive ? 70 : 30,
            height: 2,
            color: isActive ? Colors.white : Colors.grey,
            margin: const EdgeInsets.only(right: 10),
          ),
          shadcn.Text(
            text.toUpperCase(),
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white54,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ).xSmall(),
        ],
      ),
    );
  }

  Widget _buildIntroduction() {
    return const Text(
      'Back in 2017, I embarked on my engineering journey and have since built apps for companies, businesses, and startups. I’ve created multiple apps that were the first of their kind to hit the market. Currently, I am working at LightWork, focusing on giving customers the time they need by letting our app handle all their property management problems. \n\n'
      'I am fortunate to have international experience, having worked with companies from different continents. This opportunity has not only allowed me to collaborate with new people but also to experience diverse cultures and work environments. \n\n'
      'When I’m not working, I indulge in my content creation hobby, creating videos for my 100k fans on YouTube, or I am traveling, as I have a passion for exploring new places.',
      style: TextStyle(
        color: Colors.white70,
        fontSize: 16.5,
        height: 1.5,
      ),
    );
  }

  Widget _buildSectionWithTitle(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        shadcn.Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ).base(),
        const SizedBox(height: 20),
        content,
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final Offset mousePosition;

  BackgroundPainter(this.mousePosition);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.black.withOpacity(0.3),
          Colors.blue.withOpacity(0.4),
          Colors.transparent,
        ],
        stops: [0.0, 0.5, 1.0],
        center: Alignment(mousePosition.dx / size.width * 2 - 1,
            mousePosition.dy / size.height * 2 - 1),
        radius: 0.2,
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
