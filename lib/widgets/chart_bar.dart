import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageofTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPercentageofTotal);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            // ! DIKASIH CONTAINER SUPAYA NGISI AMOUNT YANG LEBIH BANYAK CHART BAR TIDAK MENGECIL
            height: 20,
            child: FittedBox(
                child: Text('\$ ${spendingAmount.toStringAsFixed(0)}'))),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1)),
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
          height: 4,
        ),
        Text(label)
      ],
    );
  }
}
