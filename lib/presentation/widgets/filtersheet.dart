import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_foresight/blocs/sortbloc/bloc/sort_bloc.dart';
import 'package:food_foresight/data/models/item.dart';
import 'package:food_foresight/data/models/sortcriteria.dart';

class FilterSheet extends StatefulWidget {
  final List<Item> itemsList;
  FilterSheet({super.key, required this.itemsList});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  SortCriteria? sortBy;

  List<String> filteredCatogory = [];
  List<String> filteredInventory = [];
  duplicateFieldsRemove() {
    widget.itemsList.forEach((item) {
      if (item.category != null) {
        if (!filteredCatogory.contains(item.category!)) {
          filteredCatogory.add(item.category!);
        }
        print(filteredCatogory);
      }
      if (item.inventory != null) {
        if (!filteredInventory.contains(item.inventory!)) {
          filteredInventory.add(item.inventory!);
        }
      }
    });
  }

  List<String> selectedCategory = [];
  List<String> selectedInventory = [];

  @override
  void initState() {
    // TODO: implement initState
    selectedCategory =
        List.from(context.read<SortBloc>().settings.filteredCatogory);
    selectedInventory =
        List.from(context.read<SortBloc>().settings.filteredInventory);
    sortBy = context.read<SortBloc>().settings.sortBy;
    duplicateFieldsRemove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sort by',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Swipe left for more options',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildOption(context, 'Category', SortCriteria.Category),
                  buildOption(context, 'Name', SortCriteria.Name),
                  buildOption(context, 'Inventory', SortCriteria.Inventory),
                  buildOption(context, 'Exp. date', SortCriteria.ExpiryDate),
                ],
              ),
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            Text(
              'Filter',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'See groceries categorized as',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 40,
              child: ListView.builder(
                itemCount: filteredCatogory.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return buildCategoryOption(filteredCatogory[i]);
                },
              ),
            ),
            SizedBox(height: 50),
            Text(
              'See groceries stored in',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 50,
              child: ListView.builder(
                itemCount: filteredInventory.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return buildStorageOption(filteredInventory[i]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOption(BuildContext context, String text, SortCriteria sort) {
    return GestureDetector(
      onTap: () {
        setState(() {
          sortBy = sort;
          context.read<SortBloc>().add(SortBy(sortCriteria: sort));
        });
      },
      child: SizedBox(
        width: 140,
        child: Container(
          margin: EdgeInsets.only(right: 12),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.5),
            color: sort == sortBy ? Theme.of(context).primaryColor : null,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
              child: Text(
            text,
            style:
                TextStyle(color: sort == sortBy ? Colors.white : Colors.black),
          )),
        ),
      ),
    );
  }

  Widget buildCategoryOption(String text) {
    return GestureDetector(
      onTap: () {
        // Add your category selection logic here
        setState(() {
          if (selectedCategory.contains(text)) {
            selectedCategory.remove(text);
          } else {
            selectedCategory.add(text);
          }
          context
              .read<SortBloc>()
              .add(FilterByCategory(filter: selectedCategory));
        });
      },
      child: Container(
        width: 100,
        margin: EdgeInsets.only(right: 12),
        // padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.5),
            borderRadius: BorderRadius.circular(20),
            color: selectedCategory.contains(text)
                ? Theme.of(context).primaryColor
                : null),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: selectedCategory.contains(text) ? Colors.white : null),
          ),
        ),
      ),
    );
  }

  Widget buildStorageOption(String text) {
    return GestureDetector(
      onTap: () {
        // Add your storage selection logic here
        setState(() {
          if (selectedInventory.contains(text)) {
            selectedInventory.remove(text);
          } else {
            selectedInventory.add(text);
          }
          print(selectedInventory);
          print("========================");
          context
              .read<SortBloc>()
              .add(FilterByInventory(filter: selectedInventory));
        });
      },
      child: Container(
        height: 40,
        width: 100,
        margin: EdgeInsets.only(right: 12),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.5),
          color: selectedInventory.contains(text)
              ? Theme.of(context).primaryColor
              : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: FittedBox(
                child: Text(
          text,
          style: TextStyle(
              color: selectedInventory.contains(text) ? Colors.white : null),
        ))),
      ),
    );
  }
}
