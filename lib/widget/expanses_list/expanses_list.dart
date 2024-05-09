import 'package:expense_tracker/model/expanse.dart';
import 'package:expense_tracker/widget/expanses_list/expanse_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExpanseList extends StatelessWidget {
  const ExpanseList({
    super.key,
    required this.expanses,
    required this.onRemoveExpanse,
  });
  final List<Expanse> expanses;
  final void Function(Expanse expanse) onRemoveExpanse;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expanses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expanses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error,
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        onDismissed: (dismiss) {
          onRemoveExpanse(expanses[index]);
        },
        child: ExpanseItem(
          expanses[index],
        ),
      ),
    );
  }
}
