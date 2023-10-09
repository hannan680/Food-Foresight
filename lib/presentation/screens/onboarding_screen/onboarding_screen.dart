import 'package:flutter/material.dart';
import './onboarding_page.dart';
import '../../widgets/rounded_button.dart';
import "../../routes/app_routes.dart";

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  final List<Map<String, String>> _pageData = [
    {
      'heading': 'Stock Management',
      'description': 'Stocks are categorized as per expiry dates:\n'
          '1 day to expire\n'
          '3 days to expire\n'
          'Good to go for at least 4 days.',
    },
    {
      'heading': 'Expiry Tracking',
      'description': 'Save your food before they expire.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page?.toInt() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.signup);
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pageData.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    heading: _pageData[index]['heading']!,
                    description: _pageData[index]['description']!,
                    imagePath: 'assets/images/onboarding_${index + 1}.png',
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pageData.length,
                (index) => Container(
                  margin: const EdgeInsets.all(4),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == _currentPageIndex
                        ? theme.primaryColor
                        : Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RoundedButton(
                color: theme.primaryColor,
                text: _currentPageIndex == _pageData.length - 1
                    ? "Get Started"
                    : "Continue",
                onTap: () {
                  if (_currentPageIndex == _pageData.length - 1) {
                    Navigator.pushReplacementNamed(context, AppRoutes.signup);
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
