import 'package:expense_tracker/model/expanse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExpanseItem extends StatelessWidget {
  const ExpanseItem(this.expanse, {super.key});
  final Expanse expanse;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expanse.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text('\$${expanse.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcon[expanse.category]),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(expanse.formatDate)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
