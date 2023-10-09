import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_foresight/blocs/bloc/auth_bloc.dart';
import 'package:food_foresight/blocs/items_bloc/bloc/item_bloc.dart';
import 'package:food_foresight/data/models/item.dart';
import 'package:food_foresight/presentation/screens/add_item_screen/bloc/bloc/add_item_bloc.dart';
import 'package:intl/intl.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/dual_options_selector.dart';

import './select_catogory_dialogue.dart';
import '../../../data/mock/details.dart';

class AddItemFeature extends StatefulWidget {
  const AddItemFeature({super.key});

  @override
  State<AddItemFeature> createState() => _AddItemFeatureState();
}

class _AddItemFeatureState extends State<AddItemFeature> {
  String? selectedInventory;

  collectInventoryType(String inventory) {
    setState(() {
      selectedInventory = inventory;
      context.read<AddItemBloc>().add(InventorySelected(selectedInventory!));
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: [
        SizedBox(
          height: 55, // Adjust the height as needed
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              buildRoundedButtonWithIcon(
                iconData: Icons.icecream,
                title: inventoryType[0],
                color: selectedInventory == inventoryType[0]
                    ? theme.primaryColor
                    : Colors.white,
                textColor: selectedInventory == inventoryType[0]
                    ? Colors.white
                    : Colors.black,
                onTap: () {
                  collectInventoryType(inventoryType[0]);
                },
              ),
              buildRoundedButtonWithIcon(
                iconData: Icons.icecream,
                title: inventoryType[1],
                color: selectedInventory == inventoryType[1]
                    ? theme.primaryColor
                    : Colors.white,
                textColor: selectedInventory == inventoryType[1]
                    ? Colors.white
                    : Colors.black,
                onTap: () {
                  collectInventoryType(inventoryType[1]);
                },
              ),
              buildRoundedButtonWithIcon(
                iconData: Icons.icecream,
                title: inventoryType[2],
                color: selectedInventory == inventoryType[2]
                    ? theme.primaryColor
                    : Colors.white,
                textColor: selectedInventory == inventoryType[2]
                    ? Colors.white
                    : Colors.black,
                onTap: () {
                  collectInventoryType(inventoryType[2]);
                },
              ),

              // Add more buttons as needed
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Select an expiration date"),
        ),
        BlocBuilder<AddItemBloc, AddItemState>(
          buildWhen: (previousState, currentState) {
            // Return true if you want to rebuild the UI

            return currentState is! SelectedItem;
          },
          builder: (context, state) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildRoundedButtonWithIcon(
                  iconData: Icons.calendar_month_outlined,
                  title: state is ExpiryDatePlus3DaysSelectedState
                      ? DateFormat.yMMMd().format(state.expiryDate)
                      : "+3",
                  color: state is ExpiryDatePlus3DaysSelectedState
                      ? theme.primaryColor
                      : Colors.white,
                  textColor: state is ExpiryDatePlus3DaysSelectedState
                      ? Colors.white
                      : Colors.black,
                  onTap: () {
                    // Your onTap logic here

                    context
                        .read<AddItemBloc>()
                        .add(ExpiryDatePlus3DaysSelected());
                  },
                ),
                buildRoundedButtonWithIcon(
                  iconData: Icons.calendar_month_outlined,
                  title: state is ExpiryDatePlus14DaysSelectedState
                      ? DateFormat.yMMMd().format(state.expiryDate)
                      : "+14 days",
                  color: state is ExpiryDatePlus14DaysSelectedState
                      ? theme.primaryColor
                      : Colors.white,
                  textColor: state is ExpiryDatePlus14DaysSelectedState
                      ? Colors.white
                      : Colors.black,
                  onTap: () {
                    // Your onTap logic here
                    context
                        .read<AddItemBloc>()
                        .add(ExpiryDatePlus14DaysSelected());
                  },
                ),
              ],
            );
          },
        ),
        BlocBuilder<AddItemBloc, AddItemState>(
          buildWhen: (previousState, currentState) {
            // Return true if you want to rebuild the UI

            return currentState is! SelectedItem;
          },
          builder: (context, state) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildRoundedButtonWithIcon(
                  iconData: Icons.calendar_month_outlined,
                  title: "No date",
                  color: state is ExpiryDateNoneSelectedState
                      ? theme.primaryColor
                      : Colors.white,
                  textColor: state is ExpiryDateNoneSelectedState
                      ? Colors.white
                      : Colors.black,
                  onTap: () {
                    // Your onTap logic here
                    context.read<AddItemBloc>().add(ExpiryDateNoneSelected());
                  },
                ),
                buildRoundedButtonWithIcon(
                  iconData: Icons.calendar_month_outlined,
                  title: state is ExpirationDateSelectedState
                      ? DateFormat.yMMMd().format(state.expiryDate!)
                      : "Custom",
                  color: state is ExpirationDateSelectedState
                      ? theme.primaryColor
                      : Colors.white,
                  textColor: state is ExpirationDateSelectedState
                      ? Colors.white
                      : Colors.black,
                  onTap: () {
                    // Your onTap logic here
                    showModalBottomSheet(
                        context: context,
                        builder: (ctx) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          context
                                              .read<AddItemBloc>()
                                              .add(ExpiryDateNoneSelected());
                                        },
                                        child: const Text("Cancel")),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Done",
                                        style: TextStyle(
                                            color: theme.primaryColor),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 250,
                                child: CupertinoDatePicker(
                                    minimumDate: DateTime.now(),
                                    mode: CupertinoDatePickerMode.date,
                                    onDateTimeChanged: (date) {
                                      context
                                          .read<AddItemBloc>()
                                          .add(ExpirationDateSelected(date));
                                    }),
                              ),
                            ],
                          );
                        });
                  },
                ),
              ],
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Details"),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<AddItemBloc, AddItemState>(
              buildWhen: (previousState, currentState) {
                // Return true if you want to rebuild the UI

                return currentState is SelectedItem;
              },
              builder: (context, state) {
                return buildRoundedButtonWithIcon(
                  iconData: Icons.category,
                  title: state is SelectedItem && state.item.category != null
                      ? state.item.category!
                      : "Category",
                  color: state is SelectedItem && state.item.category != null
                      ? theme.primaryColor
                      : Colors.white,
                  textColor:
                      state is SelectedItem && state.item.category != null
                          ? Colors.white
                          : Colors.black,
                  onTap: () {
                    // Your onTap logic here

                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return SelectCatogory(
                            title: "Select Catogory",
                            catogoryList: catogories,
                            optionSelected: (index) {
                              print(index);
                              context.read<AddItemBloc>().add(CatogorySelected(
                                  '${catogories[index].name}'));
                            },
                          );
                        });
                  },
                );
              },
            ),
            BlocBuilder<AddItemBloc, AddItemState>(
              buildWhen: (previousState, currentState) {
                // Return true if you want to rebuild the UI
                print(currentState);
                print(previousState);
                return currentState is SelectedItem;
              },
              builder: (context, state) {
                return buildRoundedButtonWithIcon(
                  iconData: Icons.production_quantity_limits_sharp,
                  title: state is SelectedItem && state.item.quantity != null
                      ? state.item.quantity!
                      : "Quantity",
                  color: state is SelectedItem && state.item.quantity != null
                      ? theme.primaryColor
                      : Colors.white,
                  textColor:
                      state is SelectedItem && state.item.quantity != null
                          ? Colors.white
                          : Colors.black,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return DualOptionsSelectorBox(
                              leftOptionsList:
                                  List.generate(20, (i) => (i + 1).toString()),
                              rightOptionsList: quantityType,
                              title: "Select Quantity",
                              optionsSelected: (left, right) {
                                // print(left);
                                context.read<AddItemBloc>().add(
                                    QuantitySelected(
                                        '${left + 1} ${quantityType[right]}'));
                                // print(right);
                              });
                        });
                  },
                );
              },
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<AddItemBloc, AddItemState>(
              buildWhen: (previousState, currentState) {
                // Return true if you want to rebuild the UI

                return currentState is SelectedItem;
              },
              builder: (context, state) {
                return buildRoundedButtonWithIcon(
                  iconData: Icons.store_mall_directory,
                  title: state is SelectedItem && state.item.storage != null
                      ? state.item.storage!
                      : "Storage",
                  color: state is SelectedItem && state.item.storage != null
                      ? theme.primaryColor
                      : Colors.white,
                  textColor: state is SelectedItem && state.item.storage != null
                      ? Colors.white
                      : Colors.black,
                  onTap: () {
                    // Your onTap logic here
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return DualOptionsSelectorBox(
                              leftOptionsList: storageType,
                              rightOptionsList:
                                  List.generate(20, (i) => (i + 1).toString()),
                              title: "Select Storage",
                              optionsSelected: (left, right) {
                                print(left);
                                print(right);
                                context.read<AddItemBloc>().add(StorageSelected(
                                    '${right + 1} ${storageType[left]}'));
                              });
                        });
                  },
                );
              },
            ),
            BlocBuilder<AddItemBloc, AddItemState>(
              buildWhen: (previousState, currentState) {
                // Return true if you want to rebuild the UI

                return currentState is SelectedItem;
              },
              builder: (context, state) {
                return buildRoundedButtonWithIcon(
                  iconData: Icons.content_copy_rounded,
                  title: state is SelectedItem && state.item.content != null
                      ? state.item.content!
                      : "Content",
                  color: state is SelectedItem && state.item.content != null
                      ? theme.primaryColor
                      : Colors.white,
                  textColor: state is SelectedItem && state.item.content != null
                      ? Colors.white
                      : Colors.black,
                  onTap: () {
                    // Your onTap logic here
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return DualOptionsSelectorBox(
                              leftOptionsList:
                                  List.generate(20, (i) => (i + 1).toString()),
                              rightOptionsList: contentType,
                              title: "Select Content",
                              optionsSelected: (left, right) {
                                print(left);
                                print(right);
                                context.read<AddItemBloc>().add(ContentSelected(
                                    '${left + 1} ${contentType[right]}'));
                              });
                        });
                  },
                );
              },
            ),
          ],
        ),
        const SizedBox(
          height: 100,
        ),
        BlocBuilder<ItemBloc, ItemState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            }
            return RoundedButton(
              text: "Add Item",
              onTap: () {
                Item item = context.read<AddItemBloc>().item;
                if (item.inventory == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please select inventory'),
                    backgroundColor: Colors.red,
                  ));
                } else {
                  // print(item.toJson());
                  context.read<ItemBloc>().add(CreateItem(
                      item,
                      context
                          .read<AuthenticationBloc>()
                          .authRepository
                          .getCurrentUser()!
                          .uid));
                }
              },
              maxSize: const Size(350, 60),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

Widget buildRoundedButtonWithIcon(
    {required IconData iconData,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.white,
    textColor = Colors.black}) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: RoundedButton(
      fontSize: 12,
      text: title,
      onTap: onTap,
      maxSize: Size(150, 50),
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Icon(
          iconData,
          color: textColor,
          size: 14,
        ),
      ),
      color: color,
      elevation: 0,
      border: true,
      borderColor: Colors.grey.withOpacity(.5),
      fontColor: textColor,
    ),
  );
}
