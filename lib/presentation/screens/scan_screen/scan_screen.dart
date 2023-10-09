import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_foresight/blocs/barcode_bloc/bloc/barcode_bloc.dart';
import 'package:food_foresight/blocs/bloc/auth_bloc.dart';
import 'package:food_foresight/blocs/items_bloc/bloc/item_bloc.dart';
import 'package:food_foresight/data/mock/details.dart';
import 'package:food_foresight/data/models/item.dart';
import 'package:food_foresight/presentation/widgets/rounded_button.dart';
import 'package:lottie/lottie.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<BarcodeBloc, BarcodeState>(
      listener: (context, state) {
        print(state);
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
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).padding.top + 65)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      margin: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(.3),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Scan Barcode',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Effortlessly retrieve product names from our extensive 4 million-item database using barcode scanning',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Image.asset('assets/images/scan.png')),
                    const SizedBox(
                      height: 50,
                    ),
                    RoundedButton(
                      text: "Scan",
                      onTap: () async {
                        String barcodeScanRes =
                            await FlutterBarcodeScanner.scanBarcode(
                                "green", "Cancel", true, ScanMode.BARCODE);
                        print(barcodeScanRes);
                        if (barcodeScanRes != "-1") {
                          if (context.mounted) {
                            context
                                .read<BarcodeBloc>()
                                .add(LookupBarcodeEvent(barcodeScanRes));
                          }
                        }
                      },
                      maxSize: const Size.fromWidth(200),
                      border: true,
                      color: Colors.transparent,
                      elevation: 0,
                      fontColor: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
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

class AddScanItem extends StatefulWidget {
  final String name;
  const AddScanItem({super.key, required this.name});

  @override
  State<AddScanItem> createState() => _AddScanItemState();
}

class _AddScanItemState extends State<AddScanItem> {
  final _nameController = TextEditingController();
  final item = Item();
  String? selectedInventory;
  String? isError;

  @override
  void initState() {
    // TODO: implement initState
    _nameController.text = widget.name;
    item.name = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(item.inventory);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("You have item ready to add"),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
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
                      Expanded(
                        // Added Expanded widget
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              print(val);
                              item.name = val;
                            });
                          },
                          controller: _nameController,
                          cursorColor: Colors.black,
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: 18),
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(),
                            enabledBorder: UnderlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Select an inventory"),
                  SizedBox(
                    height: 10,
                  ),
                  if (isError != null)
                    Text(
                      isError!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 55,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        buildRoundedButtonWithIcon(
                          iconData: Icons.icecream,
                          title: inventoryType[0],
                          color: selectedInventory == inventoryType[0]
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          textColor: selectedInventory == inventoryType[0]
                              ? Colors.white
                              : Colors.black,
                          onTap: () {
                            setState(() {
                              selectedInventory = inventoryType[0];
                            });
                          },
                        ),
                        buildRoundedButtonWithIcon(
                          iconData: Icons.icecream,
                          title: inventoryType[1],
                          color: selectedInventory == inventoryType[1]
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          textColor: selectedInventory == inventoryType[1]
                              ? Colors.white
                              : Colors.black,
                          onTap: () {
                            setState(() {
                              selectedInventory = inventoryType[1];
                            });
                          },
                        ),
                        buildRoundedButtonWithIcon(
                          iconData: Icons.shopping_basket,
                          title: inventoryType[2],
                          color: selectedInventory == inventoryType[2]
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          textColor: selectedInventory == inventoryType[2]
                              ? Colors.white
                              : Colors.black,
                          onTap: () {
                            setState(() {
                              selectedInventory = inventoryType[2];
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Spacer(),
        Divider(),
        Container(
          padding: EdgeInsets.all(16),
          child: BlocBuilder<ItemBloc, ItemState>(
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
                  item.inventory = selectedInventory;
                  if (item.name == '') {
                    setState(() {
                      isError = "Name cannot be empty";
                    });
                  } else if (item.inventory == null) {
                    setState(() {
                      isError = "Please select an inventory";
                    });
                  } else {
                    // print(item.toJson());
                    setState(() {
                      isError = null;
                    });

                    context.read<ItemBloc>().add(CreateItem(
                        item,
                        context
                            .read<AuthenticationBloc>()
                            .authRepository
                            .getCurrentUser()!
                            .uid));
                    Navigator.pop(context);
                  }
                },
                maxSize: const Size(350, 60),
              );
            },
          ),
        )
      ],
    );
  }
}
