import 'package:bank_app/Model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<User> customers = [];
retrieveData() async {
    SharedPreferences newCustomers = await SharedPreferences.getInstance();
    if (newCustomers.containsKey('customers_key')) {
      customers =
          User.decode(newCustomers.getString('customers_key') ?? '').toList();
    }
  }
  List namesCustomers = ['Select', ];

  getCustomers(){
    for (int i = 0; i < customers.length; i++){
      namesCustomers.add(customers[i].accountNo);
    }
  }

  mainData(){
    getCustomers();
    // print(namesCustomers);
    return namesCustomers;
  }