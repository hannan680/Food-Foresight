import 'package:flutter/material.dart';
import '../widgets/rounded_button.dart';

class DualOptionsSelectorBox extends StatelessWidget {
  const DualOptionsSelectorBox({
    super.key,
    required this.title,
    required this.leftOptionsList,
    required this.rightOptionsList,
    required this.optionsSelected,
  });

  final List<String> rightOptionsList;
  final List<String> leftOptionsList;
  final Function(int, int) optionsSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    int leftSelected = -1;
    int rightSecleted = -1;
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: mediaQuery.size.width * 0.8,
          height: mediaQuery.size.height * 0.8,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Icon(Icons.cancel_outlined)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: mediaQuery.size.height * 0.5,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 100,
                          child: SelectableItemList(
                            items: leftOptionsList,
                            selectedItem: (itemIndex) {
                              leftSelected = itemIndex;
                            },
                            selectedItemBackgroundColor: theme.primaryColor,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: VerticalDivider(
                          thickness: 1.5,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 100,
                          child: SelectableItemList(
                            items: rightOptionsList,
                            selectedItem: (itemIndex) {
                              rightSecleted = itemIndex;
                            },
                            selectedItemBackgroundColor: theme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: RoundedButton(
                      maxSize: Size(300, 100),
                      text: "Save",
                      onTap: () {
                        Navigator.pop(context);
                        optionsSelected(leftSelected, rightSecleted);
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectableItemList extends StatefulWidget {
  const SelectableItemList({
    super.key,
    required this.items,
    required this.selectedItem,
    this.selectedItemColor = Colors.white,
    this.selectedItemBackgroundColor = Colors.orange,
    this.itemColor = Colors.black,
  });
  final List<String> items;
  final Color selectedItemColor;
  final Color itemColor;
  final Color selectedItemBackgroundColor;
  final Function(int) selectedItem;
  @override
  State<SelectableItemList> createState() => _SelectableItemListState();
}

class _SelectableItemListState extends State<SelectableItemList> {
  int selectedItem = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {});
            selectedItem = index;
            widget.selectedItem(index);
          },
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: index == selectedItem
                        ? widget.selectedItemBackgroundColor
                        : null,
                    borderRadius: BorderRadius.circular(20)),
                child: FittedBox(
                  child: Text(
                    widget.items[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: selectedItem == index
                            ? widget.selectedItemColor
                            : widget.itemColor),
                  ),
                ),
              ),
              const SizedBox(
                  width: 50,
                  child: Divider(
                    thickness: 1.5,
                  ))
            ],
          ),
        );
      },
    );
  }
}
