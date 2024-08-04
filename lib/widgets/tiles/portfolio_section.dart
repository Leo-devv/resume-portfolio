import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

class PortfolioSection extends StatelessWidget {
  final ScrollController scrollController;

  PortfolioSection({required this.scrollController});

  final List<Map<String, String>> portfolios = [
    {
      'title': 'Lightwork',
      'description':
          'advanced, AI-powered home services platform is designed to streamline property care by leveraging cutting-edge artificial intelligence. Our application simplifies the management of various home maintenance tasks, making it easier for users to maintain their properties and contractors to manage their jobs.',
      'image': 'lightworkposter.png', // Update with your actual image path
      'stars': 'Beta Testing',
      'tags':
          'Twillo, OpenAi, DeepGram, daily webrtc, Parokopedia Api, Google Maps Api'
    },
    {
      'title': 'iyzico',
      'description':
          'iyzico is a comprehensive digital payment solution designed to facilitate secure and efficient transactions for businesses and individuals. The iyzico app offers a seamless payment experience by enabling users to make online and mobile payments with ease. It supports a variety of payment methods, including credit and debit cards, bank transfers, and alternative payment options like digital wallets.',
      'image': 'iyzico.png', // Update with your actual image path
      'stars': '500k+',
      'tags': 'React, Express, Spotify API, Heroku'
    },
    {
      'title': 'VeryFit',
      'description':
          'VeryFit is a professional and easy-to-use sports and health app designed to help you manage your health with smart wearable devices. The app offers a comprehensive suite of features that enable users to track and improve their health and fitness effortlessly.',
      'image': 'vefit.png',
      'stars': '100k',
      'tags': 'React, Express, Spotify API, Heroku'
    },
    {
      'title': 'InstaFood',
      'description':
          'InstaFood is a comprehensive food discovery and delivery app designed to bring the best dining experiences right to your fingertips. Whether you’re craving a quick bite, looking to try new cuisines, or want to enjoy your favorite meals from the comfort of your home, InstaFood has you covered.',
      'image': 'instafood.png',
      'stars': '',
      'tags': 'Dart, Firebase, Stripe Api'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Projects',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: List.generate(portfolios.length, (index) {
              return PortfolioCard(
                portfolio: portfolios[index],
                index: index,
                scrollController: scrollController,
              );
            }),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('More Coming Soon'),
            ),
          ),
        ],
      ),
    );
  }
}

class PortfolioCard extends StatefulWidget {
  final Map<String, String> portfolio;
  final int index;
  final ScrollController scrollController;

  const PortfolioCard({
    Key? key,
    required this.portfolio,
    required this.index,
    required this.scrollController,
  }) : super(key: key);

  @override
  _PortfolioCardState createState() => _PortfolioCardState();
}

class _PortfolioCardState extends State<PortfolioCard>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    _animationController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final screenHeight = MediaQuery.of(context).size.height;
    final cardHeight = 200.0; // Approximate height of the card
    final cardTopPosition =
        widget.index * (cardHeight + 16); // Including margin
    final offset = widget.scrollController.offset;

    if (offset + screenHeight > cardTopPosition + cardHeight / 2) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: MouseRegion(
          onEnter: (_) => _onHover(true),
          onExit: (_) => _onHover(false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: _isHovered
                    ? Colors.blue.withOpacity(0.2)
                    : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    widget.portfolio['image']!,
                    width: 150,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.portfolio['title']!,
                            style: TextStyle(
                              fontSize: 18,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              color: _isHovered
                                  ? Colors.blue.withOpacity(0.9)
                                  : Colors.white,
                            ),
                          ),
                          const Icon(Icons.open_in_new,
                              color: Colors.white, size: 16),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.portfolio['description']!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            widget.portfolio['stars']!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children:
                            widget.portfolio['tags']!.split(', ').map((tag) {
                          return TagChip(label: tag);
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }

  bool _isHovered = false;
}

class TagChip extends StatelessWidget {
  final String label;

  const TagChip({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return shadcn.Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    ).withPadding(vertical: 3);
  }
}
