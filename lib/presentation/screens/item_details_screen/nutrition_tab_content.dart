import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_foresight/blocs/items_bloc/bloc/item_bloc.dart';
import 'package:food_foresight/blocs/recipe_bloc/bloc/recipe_bloc.dart';
import 'package:food_foresight/data/models/nutrient.dart';
import './piechart.dart';

class NutritionTabContent extends StatelessWidget {
  final bool isLoading;
  final bool isError;
  final List<Nutrient>? nutrients;
  const NutritionTabContent(
      {super.key,
      this.isLoading = false,
      this.isError = false,
      this.nutrients});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        // padding: EdgeInsets.all(16.0),
        child: Column(
      children: [
        if (isLoading)
          LinearProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        if (isError)
          const Center(
            child: Text('Error getting nutrients'),
          ),
        if (nutrients != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(16.0),
                  color: Colors.grey[200],
                  child: Row(
                    children: [
                      PieChart(nutrients: nutrients!),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(height: 20),
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: {
                    0: FractionColumnWidth(0.7),
                    1: FractionColumnWidth(0.2),
                    2: FractionColumnWidth(0.1),
                  },
                  children: [
                    const TableRow(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1.5, color: Colors.black))),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              "Per Serving",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(
                            "Amount",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "RDA",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )
                        ]),
                    ...nutrients!.map((nutrient) {
                      return _buildNutritionTableRow(
                          nutrient.name,
                          '${nutrient.amount} ${nutrient.unit}',
                          nutrient.percentOfDailyNeeds.toString());
                    }).toList()
                    // Add more rows here...
                  ],
                ),
              ],
            ),
          )
      ],
    ));
  }

  Widget _buildNutritionRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 20,
      thickness: 1,
      color: Colors.black,
    );
  }

  TableRow _buildNutritionTableRow(String title, String amount, String rda) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(title),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(amount),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(rda),
        ),
      ],
    );
  }
}
