import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_foresight/data/models/item.dart';
import 'package:food_foresight/data/repository/notification_service.dart';
import 'package:food_foresight/presentation/widgets/rounded_button.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../widgets/value_picker.dart';
import '../../widgets/time_picker.dart';
import 'package:timezone/timezone.dart' as tz;

import 'dart:math';

class ExpiryDateRemainderScreen extends StatefulWidget {
  ExpiryDateRemainderScreen({super.key});

  @override
  State<ExpiryDateRemainderScreen> createState() =>
      _ExpiryDateRemainderScreenState();
}

class _ExpiryDateRemainderScreenState extends State<ExpiryDateRemainderScreen> {
  DateTime setDaysBefore(DateTime expiryDate, int days) {
    return expiryDate.subtract(Duration(days: days));
  }

  int generateUniqueNineDigitNumber() {
    int min = 0; // Smallest 9-digit number
    int max = 999999999; // Largest 9-digit number
    return min + Random().nextInt(max - min);
  }

  DateTime? daysBefore;

  int hours = 0;

  int minutes = 0;

  DateTime setRemainderDateTime(DateTime daysBefore, int hours, int minutes) {
    DateTime combinedDateTime = DateTime(
      daysBefore.year,
      daysBefore.month,
      daysBefore.day,
      hours,
      minutes,
    );
    return combinedDateTime;
  }

  Item? item;
  tz.TZDateTime? scheduledTime;
  int? notificationId;

  @override
  void initState() {
    // Call the separate asynchronous method from initState
    initializeNotifications();
    super.initState();
  }

  Future<void> initializeNotifications() async {
    List<PendingNotificationRequest> pendingNotificationRequests =
        await NotificationService().getScheduledNotifications();
    PendingNotificationRequest? pending;

    for (var request in pendingNotificationRequests) {
      final payload = json.decode(request.payload!);
      if (payload['id'] == item!.id) {
        pending = request;
        break;
      }
    }

    print(pending);

    if (pending != null) {
      final payload = json.decode(pending.payload!);
      final scheduledTimeIsoString = payload['time'] as String;
      scheduledTime = tz.TZDateTime.parse(tz.local, scheduledTimeIsoString);
      notificationId = payload['n_id'];
    }

    // Update the UI after the initialization
    setState(() {});
  }

  String formatDateTime(tz.TZDateTime dateTime) {
    final formatter = DateFormat('MMMM d, y hh:mm a', 'en_US');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    int differnceInDays = 16;
    final ThemeData theme = Theme.of(context);
    if (ModalRoute.of(context) != null) {
      item = ModalRoute.of(context)!.settings.arguments as Item;
      print(item);
      if (item?.expirationDate != null) {
        daysBefore = setDaysBefore(item!.expirationDate!, 1);
        differnceInDays =
            item!.expirationDate!.difference(DateTime.now()).inDays + 1;
        print(differnceInDays);
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Expiry Date Remainder',
          style: TextStyle(
              color: Colors.black.withOpacity(.5),
              fontSize: 18,
              height: 2,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          scheduledTime != null
              ? InkWell(
                  onTap: () {
                    if (notificationId != null) {
                      NotificationService().clear(notificationId!);
                      setState(() {
                        scheduledTime = null;
                      });
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(Icons.remove),
                  ),
                )
              : InkWell(
                  onTap: () {
                    final uniqueNumber = generateUniqueNineDigitNumber();
                    if (daysBefore != null) {
                      final payload = {
                        'id': item!.id,
                        'time': tz.TZDateTime.from(
                                setRemainderDateTime(
                                    daysBefore!, hours, minutes),
                                tz.local)
                            .toIso8601String(),
                        'n_id': uniqueNumber
                      };
                      NotificationService().scheduleNotification(
                          uniqueNumber,
                          'Remainder',
                          '${item!.name} is about to expire',
                          json.encode(payload),
                          tz.TZDateTime.from(
                              setRemainderDateTime(daysBefore!, hours, minutes),
                              tz.local));

                      Navigator.pop(context);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(Icons.done_all),
                  ),
                )
        ],
        // backgroundColor: theme.primaryColor.withOpacity(.4),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Row(
                  children: [
                    const Text(
                      'Setup',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 30),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        'Upcoming Reminders',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  item!.expirationDate == null
                      ? const Text(
                          'No Expiry Date! Can\'t set remainder',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      : item!.expirationDate!.isBefore(DateTime.now())
                          ? const Text(
                              'Expired! Can\'t set remainder',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          : const Text(
                              'Create Expiry Date Remainder',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        Text(
                          item!.expirationDate == null ||
                                  item!.expirationDate!
                                      .isBefore(DateTime.now()) ||
                                  scheduledTime != null
                              ? 'Off'
                              : "On",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        const Icon(
                          Icons.check_circle_outline,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              if (scheduledTime != null)
                Column(
                  children: [
                    Lottie.asset(
                      'assets/lottie/waiting.json',
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Remainder is set ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            formatDateTime(scheduledTime!),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              if (item!.expirationDate != null &&
                  !item!.expirationDate!.isBefore(DateTime.now()) &&
                  scheduledTime == null)
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'How many days in advance would you like to receive a reminder that your items are about to expire?',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Text(
                            'Days\n(Swipe right or left to pick)',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ValuePicker(
                          range: differnceInDays > 16 ? 16 : differnceInDays,
                          selectedValue: (val) {
                            print(val);
                            if (item?.expirationDate != null) {
                              daysBefore =
                                  setDaysBefore(item!.expirationDate!, val);
                              print(daysBefore);
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'At what time of the day you want to get remainder',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Text(
                            'Days\n(Swipe up or down to pick)',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TimePicker(
                          selectedHour: (hour) {
                            hours = hour;
                          },
                          selectedMinutes: (min) {
                            minutes = min;
                          },
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
