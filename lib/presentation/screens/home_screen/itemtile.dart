import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_foresight/blocs/bloc/auth_bloc.dart';
import 'package:food_foresight/blocs/items_bloc/bloc/item_bloc.dart';
import 'package:food_foresight/blocs/sortbloc/bloc/sort_bloc.dart';
import 'package:food_foresight/data/mock/details.dart';
import 'package:food_foresight/data/models/item.dart';
import 'package:food_foresight/data/repository/auth_repository.dart';
import 'package:food_foresight/presentation/routes/app_routes.dart';
import 'package:food_foresight/presentation/screens/add_item_screen/model/catogory.dart';
import 'package:food_foresight/presentation/widgets/alertbox.dart';

class ItemTile extends StatefulWidget {
  final List<Item> items;
  final int index;
  final Function(String) getSelectedItem;
  final bool isSelectionActivated;
  const ItemTile(
      {super.key,
      required this.items,
      required this.index,
      required this.getSelectedItem,
      required this.isSelectionActivated});

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  String formatExpiry(DateTime? date) {
    if (date == null) return 'No expiry date';
    DateTime now = DateTime.now();
    DateTime futureDate = date; // Replace with your future date

    Duration remainingTime = futureDate.difference(now);
    if (remainingTime.inDays >= 1) {
      return 'Expires In ${remainingTime.inDays} ${remainingTime.inDays == 1 ? 'day' : 'days'} ';
    } else if (remainingTime.inHours >= 1) {
      return 'Expires In ${remainingTime.inHours} ${remainingTime.inHours == 1 ? 'hour' : 'hours'} left';
    } else if (remainingTime.inMinutes >= 1) {
      return 'Expires In ${remainingTime.inMinutes} ${remainingTime.inMinutes == 1 ? 'minute' : 'minutes'} left';
    } else {
      return 'Expired';
    }
  }

  Catogory? catogory;

  findCategory(items, index) {
    if (items[index].expirationDate != null) {
      formatExpiry(items[index].expirationDate);
    }
    if (items[index].category != null) {
      catogory = catogories
          .firstWhere((catogory) => catogory.name == items[index].category);
    }
  }

  String? selectedItem;
  @override
  void initState() {
    // TODO: implement initState
    print("hello");
    if (!widget.isSelectionActivated) {
      selectedItem = null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    findCategory(widget.items, widget.index);

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          Navigator.of(context).pushNamed(AppRoutes.itemUpdateScreen,
              arguments: widget.items[widget.index]);
        }
        if (direction == DismissDirection.endToStart) {
          showDialog(
              context: context,
              builder: (context) {
                return BlocBuilder<ItemBloc, ItemState>(builder: (ctx, state) {
                  print(state);
                  bool isLoading = false;
                  if (state is LoadingState) {
                    isLoading = true;
                  }

                  if (state is DeleteErrorState) {
                    isLoading = false;
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Error deleting!"),
                      backgroundColor: Colors.red,
                    ));
                    context.read<ItemBloc>().add(ItemInitialEvent());
                  }

                  if (state is SuccessState) {
                    Navigator.of(context).pop();
                    isLoading = false;
                    context.read<ItemBloc>().add(ItemInitialEvent());
                  }
                  return AlertBox(
                      icon: const Icon(Icons.warning_amber_rounded),
                      heading: ('Delete'),
                      description: "Are you sure you want to delete",
                      buttonText: isLoading ? "Deleting..." : "Delete",
                      onButtonPressed: () {
                        if (widget.items[widget.index].id != null) {
                          context.read<ItemBloc>().add(DeleteItem(
                              userId: context
                                  .read<AuthenticationBloc>()
                                  .authRepository
                                  .getCurrentUser()!
                                  .uid,
                              itemId: widget.items[widget.index].id!));
                        }
                      });
                });
              });
        }
        return false;
      },
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.itemUpdateScreen,
              arguments: widget.items[widget.index]);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: selectedItem == widget.items[widget.index].id!
                    ? Border(
                        left: BorderSide(
                            width: 5, color: Theme.of(context).primaryColor),
                      )
                    : Border(left: BorderSide.none)),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation:
                  formatExpiry(widget.items[widget.index].expirationDate) ==
                          'Expired'
                      ? 1
                      : 2,
              color: formatExpiry(widget.items[widget.index].expirationDate) ==
                      'Expired'
                  ? Colors.red.shade100
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      child: ListTile(
                        title: Text(widget.items[widget.index].name!),
                        subtitle: Text(formatExpiry(
                            widget.items[widget.index].expirationDate)),
                        trailing: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: 40,
                                child: catogory != null
                                    ? Image.asset(catogory!.image)
                                    : CircleAvatar(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: FittedBox(
                                              child: Text(
                                            "No category",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                        ),
                                      ),
                              ),
                            ),
                            Text(widget.items[widget.index].inventory != null
                                ? widget.items[widget.index].inventory!
                                : ""),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
