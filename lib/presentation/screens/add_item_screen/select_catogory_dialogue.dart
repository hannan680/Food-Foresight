import 'package:flutter/material.dart';
import 'package:food_foresight/presentation/screens/add_item_screen/model/catogory.dart';

class SelectCatogory extends StatelessWidget {
  const SelectCatogory({
    super.key,
    required this.title,
    required this.catogoryList,
    required this.optionSelected,
  });

  final List<Catogory> catogoryList;
  final Function(int) optionSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: mediaQuery.size.width * 0.8,
          height: mediaQuery.size.height * 0.7,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
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
              Expanded(
                child: SizedBox(
                  width: mediaQuery.size.width * 0.7,
                  child: SelectableItemList(
                      items: catogoryList,
                      selectedItem: (index) {
                        optionSelected(index);
                        Navigator.pop(context);
                      }),
                ),
              )
            ],
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
  final List<Catogory> items;
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
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 36.0),
                      child: Image.asset(widget.items[index].image),
                    ),
                    Text(
                      widget.items[index].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: selectedItem == index
                              ? widget.selectedItemColor
                              : widget.itemColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                  // width: 50,
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
