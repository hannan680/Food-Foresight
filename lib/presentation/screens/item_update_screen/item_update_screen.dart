import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_foresight/blocs/bloc/auth_bloc.dart';
import 'package:food_foresight/blocs/items_bloc/bloc/item_bloc.dart';
import 'package:food_foresight/data/mock/details.dart';
import 'package:food_foresight/data/models/item.dart';
import 'package:food_foresight/presentation/routes/app_routes.dart';
import 'package:food_foresight/presentation/screens/add_item_screen/add_items_feature.dart';
import 'package:food_foresight/presentation/screens/add_item_screen/bloc/bloc/add_item_bloc.dart';
import 'package:food_foresight/presentation/screens/add_item_screen/select_catogory_dialogue.dart';
import 'package:food_foresight/presentation/widgets/dual_options_selector.dart';
import 'package:food_foresight/presentation/widgets/rounded_button.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class ItemUpdateScreen extends StatefulWidget {
  const ItemUpdateScreen({super.key});

  @override
  State<ItemUpdateScreen> createState() => _ItemUpdateScreenState();
}

class _ItemUpdateScreenState extends State<ItemUpdateScreen> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = item.name!;
      updatedItem = item;
      print(updatedItem.expirationDate);
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    updatedItem = Item();
    updateExpiry = false;

    super.dispose();
  }

  final _nameController = TextEditingController();

  bool isPlus3days = false;
  bool isPlus14days = false;
  bool isNoDate = false;
  bool isCustom = false;
  bool updateExpiry = false;
  plusdays(int days) {
    DateTime now = DateTime.now();
    DateTime futureDate = now.add(Duration(days: days));
    updatedItem.expirationDate = futureDate;
  }

  Item updatedItem = Item();
  late Item item;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final argsItem = args as Item;
    item = argsItem.clone();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          // title: Text("Saving..."),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.expiryDateRemainderScreen,
                  arguments: item,
                );
              },
              child: Lottie.asset('assets/lottie/alarm.json', repeat: false),
            ),
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).padding.top + kToolbarHeight)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.restaurant,
                            size: 18,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: TextField(
                            onChanged: (val) {
                              setState(() {
                                print(val);
                                updatedItem.name = val;
                              });
                            },

                            controller: _nameController,
                            // controller: itemNameController,
                            cursorColor: Colors.black,
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 18),
                            decoration: const InputDecoration(
                              border:
                                  UnderlineInputBorder(), // No border or outline
                              focusedBorder: UnderlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.date_range,
                              size: 18,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                              'Expiration date: ${updateExpiry ? updatedItem.expirationDate == null ? 'no date' : DateFormat.yMMMd().format(updatedItem.expirationDate!) : item.expirationDate == null ? 'no date' : DateFormat.yMMMd().format(item.expirationDate!)} '),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildRoundedButtonWithIcon(
                          iconData: Icons.calendar_month_outlined,
                          title: "+3",
                          color: isPlus3days
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          textColor: isPlus3days ? Colors.white : Colors.black,
                          onTap: () {
                            // Your onTap logic here
                            setState(() {
                              plusdays(3);
                              isPlus3days = true;
                              isCustom = false;
                              isNoDate = false;
                              isPlus14days = false;
                              updateExpiry = true;
                            });
                          },
                        ),
                        buildRoundedButtonWithIcon(
                          iconData: Icons.calendar_month_outlined,
                          title: "+14 days",
                          color: isPlus14days
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          textColor: isPlus14days ? Colors.white : Colors.black,
                          onTap: () {
                            // Your onTap logic here
                            setState(() {
                              plusdays(14);
                              isPlus3days = false;
                              isCustom = false;
                              isNoDate = false;
                              isPlus14days = true;
                              updateExpiry = true;
                            });
                            context
                                .read<AddItemBloc>()
                                .add(ExpiryDatePlus14DaysSelected());
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildRoundedButtonWithIcon(
                          iconData: Icons.calendar_month_outlined,
                          title: "No date",
                          color: isNoDate
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          textColor: isNoDate ? Colors.white : Colors.black,
                          onTap: () {
                            // Your onTap logic here
                            setState(() {
                              updatedItem.expirationDate = null;
                              isPlus3days = false;
                              isCustom = false;
                              isNoDate = true;
                              isPlus14days = false;
                              updateExpiry = true;
                            });
                            context
                                .read<AddItemBloc>()
                                .add(ExpiryDateNoneSelected());
                          },
                        ),
                        buildRoundedButtonWithIcon(
                          iconData: Icons.calendar_month_outlined,
                          title: "Custom",
                          color: isCustom
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          textColor: isCustom ? Colors.white : Colors.black,
                          onTap: () {
                            // Your onTap logic here
                            showModalBottomSheet(
                                context: context,
                                builder: (ctx) {
                                  return SizedBox(
                                    child: Column(
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
                                                    context.read<AddItemBloc>().add(
                                                        ExpiryDateNoneSelected());
                                                  },
                                                  child: const Text("Cancel")),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  "Done",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 250,
                                          child: CupertinoDatePicker(
                                              minimumDate: DateTime.now(),
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                              onDateTimeChanged: (date) {
                                                setState(() {
                                                  updatedItem.expirationDate =
                                                      date;
                                                  isPlus3days = false;
                                                  isCustom = true;
                                                  isNoDate = false;
                                                  isPlus14days = false;
                                                  updateExpiry = true;
                                                });
                                              }),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                    UpdateTile(
                      icon: Icons.paste_outlined,
                      title:
                          'Contains:  ${updatedItem.content != null ? updatedItem.content : item.content}',
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return DualOptionsSelectorBox(
                                  leftOptionsList: List.generate(
                                      20, (i) => (i + 1).toString()),
                                  rightOptionsList: contentType,
                                  title: "Select Content",
                                  optionsSelected: (left, right) {
                                    print(left);
                                    print(right);
                                    setState(() {
                                      updatedItem.content =
                                          '${left + 1} ${contentType[right]}';
                                    });
                                  });
                            });
                      },
                      topDivider: true,
                    ),
                    UpdateTile(
                      icon: Icons.storage,
                      title:
                          'Stored in ${updatedItem.storage ?? (item.storage ?? "no storage available")}',
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return DualOptionsSelectorBox(
                                  leftOptionsList: storageType,
                                  rightOptionsList: List.generate(
                                      20, (i) => (i + 1).toString()),
                                  title: "Select Storage",
                                  optionsSelected: (left, right) {
                                    print(left);
                                    print(right);
                                    setState(() {
                                      updatedItem.storage =
                                          '${right + 1} ${storageType[left]}';
                                    });
                                  });
                            });
                      },
                    ),
                    UpdateTile(
                      icon: Icons.category,
                      title:
                          'Category: ${updatedItem.category ?? (item.category ?? 'not available')} ',
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return SelectCatogory(
                                title: "Select Catogory",
                                catogoryList: catogories,
                                optionSelected: (index) {
                                  print(index);
                                  setState(() {
                                    updatedItem.category =
                                        catogories[index].name;
                                  });
                                },
                              );
                            });
                      },
                    ),
                    UpdateTile(
                      icon: Icons.nineteen_mp_rounded,
                      title:
                          'Quantity: ${updatedItem.quantity ?? (item.quantity ?? 'not available')}',
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return DualOptionsSelectorBox(
                                  leftOptionsList: List.generate(
                                      20, (i) => (i + 1).toString()),
                                  rightOptionsList: quantityType,
                                  title: "Select Quantity",
                                  optionsSelected: (left, right) {
                                    // print(left);
                                    setState(() {
                                      updatedItem.quantity =
                                          '${left + 1} ${quantityType[right]}';
                                    });
                                    // print(right);
                                  });
                            });
                      },
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BlocConsumer<ItemBloc, ItemState>(
                        listener: (ctx, state) {
                      if (state is SuccessState) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Updated!"),
                          backgroundColor: Colors.green,
                        ));
                      }
                    }, builder: (context, state) {
                      if (state is LoadingState) {
                        return CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        );
                      }

                      return RoundedButton(
                        text: "Update",
                        onTap: () {
                          if (updatedItem.name == null ||
                              updatedItem.name == '') {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Name should not be empty"),
                              backgroundColor: Colors.red,
                            ));
                          } else {
                            context.read<ItemBloc>().add(UpdatedItem(
                                context
                                    .read<AuthenticationBloc>()
                                    .authRepository
                                    .getCurrentUser()!
                                    .uid,
                                updatedItem.id!,
                                updatedItem));
                          }
                        },
                        maxSize: Size(250, 70),
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UpdateTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  final bool topDivider;
  const UpdateTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.topDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (topDivider)
          const Divider(
            color: Colors.black,
          ),
        ListTile(
          leading: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(title),
          trailing: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(25),
            child: GestureDetector(
              onTap: onTap,
              child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.edit,
                    color: Colors.black,
                  )),
            ),
          ),
        ),
        const Divider(
          color: Colors.black,
        )
      ],
    );
  }
}
