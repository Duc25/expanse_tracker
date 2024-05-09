import 'package:expense_tracker/model/expanse.dart';
import 'package:expense_tracker/widget/chart/chart.dart';
import 'package:expense_tracker/widget/expanses_list/expanses_list.dart';
import 'package:expense_tracker/widget/new_expanse.dart';
import 'package:flutter/material.dart';

class Expanses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpansesState();
  }
}

class _ExpansesState extends State<Expanses> {
  final List<Expanse> _registeredExpanses = [
    Expanse(
        title: 'Flutter Course',
        date: DateTime.now(),
        amount: 19.99,
        category: Category.work),
    Expanse(
        title: 'Cinema',
        date: DateTime.now(),
        amount: 15.99,
        category: Category.leisure)
  ];

  void _openAddExpanseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpanse(
        onAddExpanse: _addExpanse,
      ),
    );
  }

  void _addExpanse(Expanse expanse) {
    setState(() {
      _registeredExpanses.add(expanse);
    });
  }

  void _removeExpanse(Expanse expanse) {
    final expanseIndex = _registeredExpanses.indexOf(expanse);
    setState(() {
      _registeredExpanses.remove(expanse);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expanse deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpanses.insert(expanseIndex, expanse);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpanseTracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpanseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(_registeredExpanses),
          Expanded(
            child: ExpanseList(
              expanses: _registeredExpanses,
              onRemoveExpanse: _removeExpanse,
            ),
          ),
        ],
      ),
    );
  }
}
