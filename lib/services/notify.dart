import 'package:flutter/material.dart';

class Notify extends StatefulWidget {
  const Notify({Key? key}) : super(key: key);

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  late dynamic requests;
  late dynamic data;
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;
    requests = data[0].requests;
    // requests = data[0].requests;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFFEA251F),
        title: const Text('Notifications'),
        centerTitle: true,
      ),
            body: ListView.builder(
          itemCount: requests.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 15,
                    backgroundColor: Color(0XFFFBE4E4),
                    child: Icon(Icons.notifications, color: Color(0XFFEB4258)),
                  ),
                 
                  title: const Text('Request'),
                  trailing: Text(requests[index].date,
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFFEB4258))),
                  subtitle: requests[index].type == 'SRequest'
                      ? Text(
                          '-You requested for ${requests[index].amount.toString()}.00 from ${requests[index].receiver}',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Color(0XFFEB4258)))
                      : Text(
                          '-${requests[index].sender} requests for ${requests[index].amount.toString()}.00 from you ',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Color(0XFFEB4258))),
                  // tileColor: transactions[index].type == 'Debit' || transactions[index].type == 'Airtime'? const Color(0XFFFBE4E4) : transactions[index].type == 'Credit' ?const Color(0XFFDFFCC4) : const Color(0XFFFFC4C4),
                ),
              ),
            );
          },
        )
        );
  }
}
