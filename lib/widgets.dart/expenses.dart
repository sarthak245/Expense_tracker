import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets.dart/expenses_list.dart/expenses_list.dart';
import 'package:expense_tracker/widgets.dart/new_expense.dart';
import 'package:expense_tracker/widgets.dart/chart/chart.dart';

class Expenses extends StatefulWidget {
  const  Expenses({super.key});
  @override
  State<Expenses> createState(){
    return _ExpensesState();
  } 
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(title: 'Flutter Course', amount: 10.99, date: DateTime.now(), category: Category.work),
    Expense(title: 'New Shoes', amount: 99.99, date: DateTime.now(), category: Category.leisure),
    Expense(title: 'Weekly Groceries', amount: 50.99, date: DateTime.now(), category: Category.food),
    Expense(title: 'Monthly Bus Pass', amount: 30.99, date: DateTime.now(), category: Category.travel),
  ];

  void _openAddExpenseForm(){
       showModalBottomSheet(
        isScrollControlled: true,
        context: context, 
        builder: (ctx) => NewExpense(onAddExpense:_addExpense),
       );
  }

  void _addExpense(Expense expense){
    setState((){
    _registeredExpenses.add(expense);
  });
}
void _removeExpense(Expense expense){
  final expenseIndex = _registeredExpenses.indexOf(expense);
    setState((){
    _registeredExpenses.remove(expense);
  });
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    duration: const Duration(seconds: 3),
    content: const Text('Expense removed'),
    action: SnackBarAction(
      label: 'UNDO',
      onPressed: (){
        setState((){
          _registeredExpenses.insert(expenseIndex, expense);
        });
      }, 
    ),   
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text('No expenses added yet!, Lets Start now'),);
    if(_registeredExpenses.isNotEmpty){
      mainContent = ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense,);
    }
    return  Scaffold(
      appBar: AppBar(   
        title: const Text('ExpensesTracker'),
        actions: [
          IconButton(
        onPressed: _openAddExpenseForm,
        icon : const Icon(Icons.add), 
      ),
      ],
      ),
      body: Column(
        children: [
           Chart(expenses: _registeredExpenses),
           Expanded(child: mainContent),
        ],
        ),
    );
  }
}
