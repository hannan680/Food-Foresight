import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  final void Function(int hour) selectedHour;
  final void Function(int min) selectedMinutes;
  const TimePicker(
      {super.key, required this.selectedHour, required this.selectedMinutes});
  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(25)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _PickerWheel(
              range: 25,
              selectedValue: (val) {
                widget.selectedHour(val);
              },
            ),
            const SizedBox(
              width: 30,
            ),
            _PickerWheel(
              range: 61,
              selectedValue: (val) {
                widget.selectedMinutes(val);
              },
            )
          ],
        ),
      ),
    );
  }
}

class _PickerWheel extends StatefulWidget {
  final Function(int) selectedValue;
  final int range;
  const _PickerWheel({required this.range, required this.selectedValue});

  @override
  State<_PickerWheel> createState() => _PickerWheelState();
}

class _PickerWheelState extends State<_PickerWheel> {
  int selectedValue = 0; // Initial selected value

  double itemExtent = 60.0; // Height of each option item
  late FixedExtentScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController(initialItem: selectedValue);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> options = List.generate(widget.range,
        (index) => index.toString().padLeft(2, "0")); // Options from 0 to 10
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return false;
      },
      child: Center(
        child: Container(
          width: 70,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50)),
          height: itemExtent * 3,
          child: ListWheelScrollView(
            controller: scrollController,
            itemExtent: itemExtent,
            physics: const FixedExtentScrollPhysics(),
            children: options.map((value) {
              return Center(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: selectedValue == int.parse(value) ? 24 : 16,
                    fontWeight: selectedValue == int.parse(value)
                        ? FontWeight.w500
                        : FontWeight.normal,
                    color: selectedValue == int.parse(value)
                        ? Colors.black
                        : Colors.grey,
                  ),
                ),
              );
            }).toList(),
            onSelectedItemChanged: (index) {
              widget.selectedValue(index);
              setState(() {
                selectedValue = index;
              });
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
