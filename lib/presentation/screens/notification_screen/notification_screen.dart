import 'package:flutter/material.dart';
import 'package:food_foresight/data/repository/notification_service.dart';
import 'package:food_foresight/presentation/widgets/alertbox.dart';
import 'package:food_foresight/presentation/widgets/rounded_button.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isRemainders = true;

  bool isUpdates = true;

  bool isConfirmations = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertBox(
                          icon: Icon(Icons.dangerous),
                          heading: "Are you sure",
                          description: "youu want to clear all remainders",
                          buttonText: "Clear All",
                          onButtonPressed: () {
                            NotificationService().clearAll();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("All remainders are cleared")));
                          });
                    });
              },
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey, width: .5)),
                child: ListTile(
                  title: Text('Clear All Reminders'),
                  trailing: Icon(Icons.remove_circle),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Text(
                "Offers and update",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              title: Text('Remainder'),
              subtitle: Text(
                  'Users receive deadline reminders for expiry remainder through notifications.'),
              trailing: Switch(
                value: isRemainders, // Replace with your switch value
                onChanged: (value) {
                  // Handle switch value change
                  setState(() {
                    isRemainders = !isRemainders;
                  });
                },
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Updates and changes'),
              subtitle: Text(
                  'Users are notified of significant shopping list updates, such as changes in adding new list, remove list etc.'),
              trailing: Switch(
                value: isUpdates, // Replace with your switch value
                onChanged: (value) {
                  // Handle switch value change
                  setState(() {
                    isUpdates = !isUpdates;
                  });
                },
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Confirmations'),
              subtitle: Text(
                  'Users receive confirmations for successful received order,account is confirmed, and other completed actions.'),
              trailing: Switch(
                value: isConfirmations, // Replace with your switch value
                onChanged: (value) {
                  setState(() {
                    isConfirmations = !isConfirmations;
                  });
                },
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
