import 'package:expense_tracker/model/expanse.dart';
import 'package:expense_tracker/widget/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart(this.expanses, {super.key});

  final List<Expanse> expanses;

  List<ExpanseBucket> get buckets {
    return [
      ExpanseBucket.forCategory(expanses, Category.food),
      ExpanseBucket.forCategory(expanses, Category.leisure),
      ExpanseBucket.forCategory(expanses, Category.travel),
      ExpanseBucket.forCategory(expanses, Category.work),
    ];
  }

  double get maxTotalExpanses {
    double maxTotal = 0;
    for (var bucket in buckets) {
      if (bucket.totalExpanses > maxTotal) {
        maxTotal = bucket.totalExpanses;
      }
    }
    return maxTotal;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (var bucket in buckets)
                ChartBar(
                  fill: bucket.totalExpanses == 0
                      ? 0
                      : bucket.totalExpanses / maxTotalExpanses,
                ),
            ],
          )),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.category],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
