import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_foresight/blocs/barcode_bloc/bloc/barcode_bloc.dart';
import 'package:food_foresight/blocs/bloc/auth_bloc.dart';
import 'package:food_foresight/blocs/items_bloc/bloc/item_bloc.dart';
import 'package:food_foresight/blocs/sortbloc/bloc/sort_bloc.dart';
import 'package:food_foresight/data/models/item.dart';
import 'package:food_foresight/data/models/sortcriteria.dart';
import 'package:food_foresight/presentation/routes/app_routes.dart';
import 'package:food_foresight/presentation/screens/home_screen/empty_list_placeholder.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:food_foresight/presentation/screens/home_screen/itemtile_shimmer.dart';
import 'package:food_foresight/presentation/screens/scan_screen/scan_screen.dart';
import 'package:food_foresight/presentation/widgets/filtersheet.dart';
import 'package:food_foresight/utils/sortedItems.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/rounded_button.dart';
import './itemtile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  List<Item> items = [];
  List<Item> searchedItems = [];
  List<Item> allItems = [];

  List<Item> searchResults(String query, List<Item> items) {
    return items.where((item) {
      print(item.name!.toLowerCase().startsWith(query.toLowerCase()));
      return item.name!.toLowerCase().startsWith(query.toLowerCase());
    }).toList();
  }

  bool isPop = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocListener<BarcodeBloc, BarcodeState>(
      listener: ((context, state) {
        if (state is BarcodeNotLoadedState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Nothing Found with this barcode"),
          ));
        }
        if (state is BarcodeLoadedState) {
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              context: context,
              builder: (context) {
                return AddScanItem(
                  name: state.barcodeInfoName,
                );
              });
        }
      }),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RoundedButton(
                      minSize: const Size(100, 15),
                      leading: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        child: Icon(
                          Icons.barcode_reader,
                          size: 12,
                        ),
                      ),
                      text: "Scan",
                      fontSize: 12,
                      // width: 100,
                      onTap: () async {
                        String barcodeScanRes =
                            await FlutterBarcodeScanner.scanBarcode(
                                "green", "Cancel", true, ScanMode.BARCODE);
                        context
                            .read<BarcodeBloc>()
                            .add(LookupBarcodeEvent(barcodeScanRes));
                      }),
                  const SizedBox(
                    width: 15,
                  ),
                  RoundedButton(
                      minSize: Size(100, 15),
                      leading: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Icon(
                          Icons.edit,
                          size: 12,
                          color: theme.primaryColor,
                        ),
                      ),
                      color: Colors.transparent,
                      elevation: 0,
                      fontColor: theme.primaryColor,
                      border: true,
                      text: "Write",
                      fontSize: 12,
                      // width: 100,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.addItemScreen);
                      }),
                  const SizedBox(
                    width: 15,
                  ),
                  RoundedButton(
                      minSize: Size(100, 15),
                      leading: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Icon(
                          Icons.sort,
                          size: 12,
                          color: theme.primaryColor,
                        ),
                      ),
                      elevation: 0,
                      fontColor: theme.primaryColor,
                      color: Colors.transparent,
                      border: true,
                      text: "Sort",
                      fontSize: 12,
                      // width: 100,
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return FilterSheet(
                                itemsList: allItems,
                              );
                            });
                      })
                ],
              ),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Food Foresight",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: theme.primaryColor),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.notificationScreen);
                                },
                                child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: const Icon(
                                      Icons.settings,
                                      // color: ,
                                    )),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomSearchBar(
                            onTapTrailing: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return FilterSheet(
                                      itemsList: allItems,
                                    );
                                  });
                            },
                            onChanged: (val) {
                              setState(() {
                                searchQuery = val;
                                searchedItems = searchResults(val, allItems);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // searchQuery != ''
                //     ?
                // ItemsTileList(
                //         items: searchedItems,
                //         allItems: allItems,
                //       )
                //     :
                StreamBuilder(
                    stream: context
                        .read<ItemBloc>()
                        .itemRepository
                        .getItemsStream(context
                            .read<AuthenticationBloc>()
                            .authRepository
                            .getCurrentUser()!
                            .uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListView.builder(
                            itemCount: 5,
                            itemBuilder: (ctx, i) {
                              return const ItemTileShimmer();
                            });
                      }
                      if (snapshot.hasError) {
                        print(snapshot.error);
                      }
                      if (snapshot.data!.isEmpty) {
                        return const Expanded(child: EmptyListPlaceholder());
                      }
                      items = snapshot.data!;
                      allItems = snapshot.data!;

                      return ItemsTileList(
                        items: items,
                        allItems: items,
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemsTileList extends StatefulWidget {
  ItemsTileList({super.key, required this.items, required this.allItems});

  List<Item> items;
  List<Item> allItems;

  @override
  State<ItemsTileList> createState() => _ItemsTileListState();
}

class _ItemsTileListState extends State<ItemsTileList> {
  List<String> selectedItem = [];

  @override
  Widget build(BuildContext context) {
    print("rereuning------------------");
    print(widget.items);

    return Expanded(
      child: BlocListener<ItemBloc, ItemState>(
        listener: (ctx, state) {
          if (state is HideDeleteMenuState) {
            selectedItem = [];
            // setState(() {});
          }
        },
        child: BlocConsumer<SortBloc, SortState>(listener: (context, state) {
          if (state is SettingsChangedState) {
            selectedItem = [];
            setState(() {});
          }
        }, builder: (context, state) {
          if (state is SettingsChangedState) {
            widget.items = filterItems(widget.allItems,
                state.newSettings.filteredCatogory, FilterBy.category);
            widget.items = filterItems(widget.items,
                state.newSettings.filteredInventory, FilterBy.inventory);
            widget.items = sortItems(widget.items, state.newSettings.sortBy);
          }

          return BlocBuilder<ItemBloc, ItemState>(
              buildWhen: (previous, current) {
            return current is HideDeleteMenuState;
          }, builder: (context, state) {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 60),
              physics: const BouncingScrollPhysics(),
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                return ItemTile(
                  items: widget.items,
                  index: index,
                  isSelectionActivated: selectedItem.isNotEmpty,
                  getSelectedItem: (item) {
                    if (selectedItem.contains(item)) {
                      selectedItem.remove(item);
                    } else {
                      selectedItem.add(item);
                    }

                    setState(() {});
                  },
                );
              },
            );
          });
        }),
      ),
    );
  }
}
