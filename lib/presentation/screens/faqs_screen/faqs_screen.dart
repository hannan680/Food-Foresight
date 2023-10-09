import 'package:flutter/material.dart';
import '../../widgets/custom_search_bar.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
        centerTitle: true,
        backgroundColor: theme.primaryColor.withOpacity(.5),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            CustomSearchBar(),
            const SizedBox(height: 50),
            Text(
              'Recommended articles',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                  fontSize: 18),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: articlesList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.grey, width: .5)),
                    child: ListTile(
                      title: Text(articlesList[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> articlesList = [
  'How does the ingredient detection feature work?',
  'How does the ingredient detection feature work?',
  'How does the ingredient detection feature work?',
  'How does the ingredient detection feature work?',
  'How does the ingredient detection feature work?',
  // Add more articles here
];
