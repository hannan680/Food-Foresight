import 'package:flutter/material.dart';

class ValuePicker extends StatefulWidget {
  const ValuePicker(
      {super.key, required this.range, required this.selectedValue});
  final Function(int) selectedValue;
  final int range;

  @override
  State<ValuePicker> createState() => _ValuePickerState();
}

class _ValuePickerState extends State<ValuePicker> {
  int selectedValue = 1; // Initial selected value

  double itemExtent = 60.0; // Height of each option item
  late FixedExtentScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController(initialItem: selectedValue);
  }

  @override
  Widget build(BuildContext context) {
    final List<int> options =
        List.generate(widget.range, (index) => index); // Options from 0 to 10
    return Center(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return false;
        },
        child: Container(
          width: 200,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(50)),
          height: itemExtent,
          // Visible height of options
          child: RotatedBox(
            quarterTurns: -1,
            child: ListWheelScrollView(
              controller: scrollController,
              itemExtent: itemExtent,
              physics: const FixedExtentScrollPhysics(),
              children: options.map((value) {
                return RotatedBox(
                  quarterTurns: 1,
                  child: Center(
                    child: Text(
                      value.toString(),
                      style: TextStyle(
                        fontSize: selectedValue == value ? 24 : 16,
                        fontWeight: selectedValue == value
                            ? FontWeight.w500
                            : FontWeight.normal,
                        color:
                            selectedValue == value ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                );
              }).toList(),
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedValue = index;
                  widget.selectedValue(index);
                });
              },
            ),
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
