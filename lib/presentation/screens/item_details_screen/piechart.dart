import 'package:flutter/material.dart';
import 'package:food_foresight/data/models/nutrient.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatelessWidget {
  final List<Nutrient> nutrients;
  const PieChart({super.key, required this.nutrients});

  NutrientPercentages calculateNutrientPercentages(List<Nutrient> nutrients) {
    double totalFat = 0;
    double totalProtein = 0;
    double totalCarbohydrates = 0;

    for (var nutrient in nutrients) {
      switch (nutrient.name) {
        case "Fat":
          totalFat = nutrient.amount;
          break;
        case "Protein":
          totalProtein = nutrient.amount;
          break;
        case "Carbohydrates":
          totalCarbohydrates = nutrient.amount;
          break;
      }
    }

    double fatPercentage =
        (totalFat / (totalFat + totalProtein + totalCarbohydrates)) * 100;
    double proteinPercentage =
        (totalProtein / (totalFat + totalProtein + totalCarbohydrates)) * 100;
    double carbohydratesPercentage =
        (totalCarbohydrates / (totalFat + totalProtein + totalCarbohydrates)) *
            100;

    return NutrientPercentages(
      fatPercentage: fatPercentage,
      proteinPercentage: proteinPercentage,
      carbohydratesPercentage: carbohydratesPercentage,
    );
  }

  @override
  Widget build(BuildContext context) {
    NutrientPercentages nutrientPercentage =
        calculateNutrientPercentages(nutrients);
    final List<ChartData> chartData = [
      ChartData(
        'Protien ${nutrientPercentage.proteinPercentage.toStringAsFixed(2)}%',
        nutrientPercentage.proteinPercentage,
      ),
      ChartData(
        'Carbs ${nutrientPercentage.carbohydratesPercentage.toStringAsFixed(2)}%',
        nutrientPercentage.carbohydratesPercentage,
      ),
      ChartData('Fat ${nutrientPercentage.fatPercentage.toStringAsFixed(2)}%',
          nutrientPercentage.fatPercentage),
    ];
    return SizedBox(
      height: 200,
      child: Container(
          child: SfCircularChart(
              legend: Legend(isVisible: true),
              series: <CircularSeries>[
            // Render pie chart
            PieSeries<ChartData, String>(
                explode: true,
                explodeIndex: 0,
                dataSource: chartData,
                pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y)
          ])),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
