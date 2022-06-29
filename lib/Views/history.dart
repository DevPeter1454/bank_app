import 'package:bank_app/Model/model.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({Key? key, required this.data}) : super(key: key);
  final dynamic data;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late List<Transaction> transactions;
  @override
  Widget build(BuildContext context) {
    transactions = widget.data[0].transactions;
    return Scaffold(
        body: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 15,
                     backgroundColor: transactions[index].type == 'Debit' || transactions[index].type == 'Airtime'? const Color(0XFFFBE4E4) : transactions[index].type == 'Credit' ?const Color(0XFFDFFCC4) : const Color(0XFFFFC4C4) ,
                    child: transactions[index].type == 'Debit'
                      ? const Icon(Icons.arrow_upward, color : Color(0XFFEB4258))
                      : transactions[index].type == 'Credit'? const Icon(Icons.arrow_downward, color: Color(0XFF96DA58)): const Icon(Icons.arrow_upward, color : Color(0XFFEB4258)),
                   
                  ),
                  title: Text(transactions[index].type),
                  trailing: transactions[index].type == 'Debit' ? Text(' -${transactions[index].amount.toString()}.00', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0XFFEB4258))) : transactions[index].type == 'Credit' ? Text('${transactions[index].amount.toString()}.00', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0XFF96DA58))):  Text('-${transactions[index].amount.toString()}.00',style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0XFFEB4258))),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      transactions[index].type == 'Debit'? Text('You transferred ${transactions[index].amount} to ${transactions[index].receiver}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w200, color: Color(0XFFEB4258))): transactions[index].type == 'Credit'? Text(' You received ${transactions[index].amount} from ${transactions[index].sender}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w200, color: Color(0XFF96DA58))): Text('You bought airtime of ${transactions[index].amount}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w200, color: Color(0XFFEB4258))),
                      Text(transactions[index].date, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0XFFEB4258))),

                    ],
                  ),
                  // tileColor: transactions[index].type == 'Debit' || transactions[index].type == 'Airtime'? const Color(0XFFFBE4E4) : transactions[index].type == 'Credit' ?const Color(0XFFDFFCC4) : const Color(0XFFFFC4C4),
                ),
              ),
            );
          },
    ));
  }
}
