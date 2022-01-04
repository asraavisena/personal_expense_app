import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageofTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPercentageofTotal);
  @override
  Widget build(BuildContext context) {
    // ! CALCULATE CHARTBAR HEIGHT WITH LAYOUTBUILDER

    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          Container(
              // ! DIKASIH CONTAINER SUPAYA NGISI AMOUNT YANG LEBIH BANYAK CHART BAR TIDAK MENGECIL
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('\$ ${spendingAmount.toStringAsFixed(0)}'))),
          const SizedBox(
            height: 4,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: const Color.fromRGBO(220, 220, 220, 1)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPercentageofTotal,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(child: Text(label)))
        ],
      );
    });
  }
}
