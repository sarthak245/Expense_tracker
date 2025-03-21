import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget{


  const ExpenseItem(this.expense, {super.key} );

  final Expense expense;
  @override
  Widget build(BuildContext context ){
    return Card(
           child:Padding(
             padding: const EdgeInsets.symmetric(
             horizontal : 10,
              vertical : 5,
             ),
             child: Column(
               children: [
                 Text(expense.title, style: Theme.of(context).textTheme.titleLarge,),
                 const SizedBox(height: 4,),
                 Row(
                  children:[
                 Text('\u20B9${expense.amount.toStringAsFixed(2)}'), //it makes a double to a string with 2 decimal places (12.3345 -> 12.33)
                  const Spacer(),
                  Row(
                    children: [
                       Icon(categoryIcons[expense.category]),
                      const SizedBox(width: 8,),
                      Text(expense.formattedDate),
                    ],
                  ),

                  ],                                             //dollar sign is a special character so we need to escape it with a backslash and other dollar sign to show the entire text as one string
                 ),
               ],
             ),
           ),
    );
  }
}