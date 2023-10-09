import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_foresight/blocs/items_bloc/bloc/item_bloc.dart';
import 'package:food_foresight/blocs/suggestions_bloc/bloc/suggestions_bloc.dart';
import 'package:food_foresight/presentation/screens/add_item_screen/bloc/bloc/add_item_bloc.dart';
import '../../widgets/food_item_card.dart';
import './add_items_feature.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  bool showSuggestions = true;

  void toggleSuggestions() {
    setState(() {
      showSuggestions = !showSuggestions;
    });
  }

  final TextEditingController itemNameController = TextEditingController();

  bool showAddItemContainer = false;

  @override
  void initState() {
    context.read<AddItemBloc>().add(ClearItem());
    context.read<SuggestionsBloc>().add(GetSuggestions());
    itemNameController.addListener(() {
      if (itemNameController.text.isNotEmpty) {
        return setState(() {
          showAddItemContainer = true;
          showSuggestions = false;
        });
      }
      setState(() {
        showAddItemContainer = false;
        showSuggestions = true;
      });
    });
    super.initState();
  }

  Map<String, dynamic> expectedExpiration(String duration) {
    final [quantity, unit] = duration.split(" ");
    Duration date;
    String expectedDate;
    switch (unit) {
      case 'w':
        date = Duration(days: (int.parse(quantity) * 7));
        expectedDate =
            'Expected expiration : $quantity ${int.parse(quantity) > 1 ? "weeks" : "week"}';
        break;
      case 'm':
        date = Duration(days: (int.parse(quantity) * 30));
        expectedDate =
            'Expected expiration : $quantity ${int.parse(quantity) > 1 ? "months" : "month"}';
        break;
      case 'd':
        date = Duration(days: (int.parse(quantity) * 1));
        print(date);
        expectedDate =
            'Expected expiration : $quantity ${int.parse(quantity) > 1 ? "days" : "day"}';
        break;
      default:
        date = Duration.zero;
        expectedDate = "Expected expiration: No Date";
    }

    return {"date": date, "expectedDate": expectedDate};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // No elevation
        actions: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: BlocBuilder<AddItemBloc, AddItemState>(
                    builder: (context, state) {
                      return TextField(
                        onChanged: (val) {
                          context.read<AddItemBloc>().add(NameTextChange(val));
                        },
                        controller: itemNameController,
                        cursorColor: Colors.black,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: 'Type here',
                          border: InputBorder.none, // No border or outline
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(height: 10),
              if (showAddItemContainer) const AddItemFeature(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Suggestions',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        toggleSuggestions();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 18),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          showSuggestions ? '- Hide' : 'Show',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (showSuggestions)
                BlocBuilder<SuggestionsBloc, SuggestionsState>(
                  builder: (context, state) {
                    if (state is GetSuggestionsState) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.suggestion.length,
                        padding: const EdgeInsets.all(12),
                        itemBuilder: (context, index) {
                          final expiry = expectedExpiration(
                              state.suggestion[index].expirationDate);
                          print(expiry['expiryDate']);
                          return GestureDetector(
                            onTap: () {
                              context.read<AddItemBloc>().add(
                                  NameTextChange(state.suggestion[index].name));
                              context.read<AddItemBloc>().add(
                                  ExpirationDateSelected(
                                      DateTime.now().add(expiry["date"])));
                              itemNameController.text =
                                  state.suggestion[index].name;
                            },
                            child: FoodItemCard(
                              title: state.suggestion[index].name,
                              description: expiry['expectedDate'],
                            ),
                          );
                        },
                      );
                    }
                    return const Text("No Suggestion Found");
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
