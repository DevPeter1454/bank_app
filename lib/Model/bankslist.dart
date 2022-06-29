List banks = [
  {"id": "1", "name": "Access Bank", "code": "044"},
  {"id": "2", "name": "Citibank", "code": "023"},
  {"id": "3", "name": "Diamond Bank", "code": "063"},
  {"id": "4", "name": "Dynamic Standard Bank", "code": ""},
  {"id": "5", "name": "Ecobank Nigeria", "code": "050"},
  {"id": "6", "name": "Fidelity Bank Nigeria", "code": "070"},
  {"id": "7", "name": "First Bank of Nigeria", "code": "011"},
  {"id": "8", "name": "First City Monument Bank", "code": "214"},
  {"id": "9", "name": "Guaranty Trust Bank", "code": "058"},
  {"id": "10", "name": "Heritage Bank Plc", "code": "030"},
  {"id": "11", "name": "Jaiz Bank", "code": "301"},
  {"id": "12", "name": "Keystone Bank Limited", "code": "082"},
  {"id": "13", "name": "Providus Bank Plc", "code": "101"},
  {"id": "14", "name": "Polaris Bank", "code": "076"},
  {"id": "15", "name": "Stanbic IBTC Bank Nigeria Limited", "code": "221"},
  {"id": "16", "name": "Standard Chartered Bank", "code": "068"},
  {"id": "17", "name": "Sterling Bank", "code": "232"},
  {"id": "18", "name": "Suntrust Bank Nigeria Limited", "code": "100"},
  {"id": "19", "name": "Union Bank of Nigeria", "code": "032"},
  {"id": "20", "name": "United Bank for Africa", "code": "033"},
  {"id": "21", "name": "Unity Bank Plc", "code": "215"},
  {"id": "22", "name": "Wema Bank", "code": "035"},
  {"id": "23", "name": "Zenith Bank", "code": "057"}
];
List bankList = [
  'Select',
];
getList() {
  for (int i = 0; i < banks.length; i++) {
    bankList.add(banks[i]['name']);
  }
  // return bankList;
  
}
newList() {
    getList();
    return bankList;
  }

  




// const [
//                                      DropdownMenuItem(
//                                         value: 'Select', child: Text('Select')),
//                                      DropdownMenuItem(
//                                         value: 'Access Bank',
//                                         child: Text('Access Bank')),
//                                      DropdownMenuItem(
//                                         value: 'Citibank',
//                                         child: Text('Citibank')),
//                                     DropdownMenuItem(
//                                         value: 'Diamond Bank',
//                                         child: Text('Diamond Bank')),
//                                      DropdownMenuItem(
//                                         value: 'Ecobank Nigeria',
//                                         child: Text('Ecobank Nigeria')),
//                                      DropdownMenuItem(
//                                         value: 'Fidelity Bank Nigeria',
//                                         child: Text('Fidelity Bank Nigeria')),
//                                        DropdownMenuItem(
//                                         value: 'First Bank of Nigeria',
//                                         child: Text('First Bank of Nigeria')),  
//                                         DropdownMenuItem(
//                                         value: 'First City Monument Bank',
//                                         child: Text('First City Monument Bank')),  
//                                          DropdownMenuItem(
//                                         value: 'Guaranty Trust Bank',
//                                         child: Text('Guaranty Trust Bank')),
//                                          DropdownMenuItem(
//                                         value: 'Heritage Bank Plc',
//                                         child: Text('Heritage Bank Plc')),
//                                          DropdownMenuItem(
//                                         value: 'Keystone Bank Limited',
//                                         child: Text('Keystone Bank Limited')),
//                                         DropdownMenuItem(
//                                         value: 'Polaris Bank',
//                                         child: Text('Polaris Bank')),
//                                         DropdownMenuItem(
//                                         value: 'Sterling Bank',
//                                         child: Text('Sterling Bank')),
//                                          DropdownMenuItem(
//                                         value: 'United Bank for Africa',
//                                         child: Text('United Bank for Africa')),
//                                           DropdownMenuItem(
//                                         value: 'Wema Bank',
//                                         child: Text('Wema Bank')),
//                                         DropdownMenuItem(
//                                         value: 'Zenith Bank',
//                                         child: Text('Zenith Bank')),
//                                   ]