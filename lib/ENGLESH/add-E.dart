import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:store/api.dart';
import 'package:store/main.dart';
import 'package:store/ENGLESH/orderes-E.dart';
import 'package:store/ENGLESH/view-E.dart';

class AAddMedicinePage extends StatefulWidget {
  int notificationCount = 5;
  static List<PharmacistAccount> pharmacistAccounts = [
    PharmacistAccount(id: 1, name: 'John Doe', email: 'john.doe@example.com'),
    // Add more accounts as needed
  ];

  @override
  _AAddMedicinePage createState() => _AAddMedicinePage();
}

class _AAddMedicinePage extends State<AAddMedicinePage> {
  final TextEditingController scientificNameController =
      TextEditingController();
  final TextEditingController tradeNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController manufacturerController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AAddMedicinePage.pharmacistAccounts = [];
    fetchData();
  }

  fetchData() async {
    var res = await Network().getData('/notification/');
    print(res.body);
    if (res.statusCode == 200) {
      var response = jsonDecode(res.body);
      if (response['error'] == false) {
        for (int i = 0; i < response['data'].length; i++) {
          var cur = response['data'][i];
          AAddMedicinePage.pharmacistAccounts.add(PharmacistAccount(
              id: cur['id'], name: cur['name'], email: cur['email']));
        }

        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101010),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // تضع مسافة بين الرمز وعنوان الصفحة
            Text(
              'Add medication',
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
            ),
            SizedBox(width: 16),
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () async {
                    await showPharmacistAccountsDialog(context);
                  },
                  alignment: Alignment.centerRight,
                ),
                if (AAddMedicinePage.pharmacistAccounts.length > 0)
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        AAddMedicinePage.pharmacistAccounts.length.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        backgroundColor: Color(0xFFFF9900),
      ),
      endDrawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 247, 231, 92),
          padding: EdgeInsets.all(15),
          child: ListView(
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                          "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAHwAAAB8CAMAAACcwCSMAAAA/FBMVEX///9ChfQ0qFPqQzX7vATqQDL7wTpWj/VLr2T/+fDx+PP98vHy9f7rV037uQD7twArpk01f/TpNyb74+L+7MgqevM8gvTxjojpLBfpMh/oIgDqPC3//fj+7tH+9N/sXl350tDk8ucUoUHJ5M9elPXk7P3R3/xvnvbV6tmIxpbznpn1r6zvdGvsX1X3xsTwg3z2u7jrUET91X/7vST8zGP947H8x0/80G7925r96L3uamH70Y36wVX94qfrUDb92IvtuhPhR0vgW2Hicnnnn6Xu1tza586q0aN4unZksmROq1NYhN8xpmOeu/htvICOsfeux/tsoOq1271ctXJoFaoCAAADZUlEQVRoge3Y60LaMBgG4NATBwVsB7VY7aBAWVHmBojOnXQnp5uicv/3shRFgaYk7Ivpn7w38PB+SdNQhGRkZGRkZGRkZMRno7vd3a9vpIMfOJZVc5xe95V4e6Ooq1F0a6f3Ni0cx3WKgtvP4Ziv7aeHq6pzKHLrLeFq7VSgvoyrVi9FXLUOU8RV512KuO6KWnYCrlrbKeKqJeiwIeOCqhNx/b2YVSfiaq2eIi5o7mRcF3PMJeAq10Xf9fZw8oy4qnN72PKVvjHQSqWSNhgMjzwW3K3zob3+oFzSZimVtWFll4pbXPB8v/QsP6Y8qtBwLs2PtBg95Y9n5ZNwDms+LJPoaPqatwrnsNvzI2LtR76yCi++qD3TybgLvs0cr7Q1beAl4jXoZeYkab2fqhuJOPSM2aP0jvR+Au4eAIsbVBs/cR4Zd4D/2j7Qhj6tPiTi7qmA4lF1Eu7UYbbHUjxadQIO/tdwQt9u0xhxXHeB9i7b1PHc93pLuA6+N+fZpo7n/vG1vtS7DrRRhRXXPi3irgq20Wdm3FhY81qPw6u0z7jf8KJ/mavtdOH0f+G6tXPA59b4lXns5S86jlvbKXL7EJcfGtSMRsbZ2dmgeH5+/u37j5+btKzD0/Lr4vfl1dVV7k8mk822WllqOuvwq9IIc/7WloLzN5thTPWaD33jT+H1cHPMww6f6Qi3WXEOzRuTOVpRch1m/BZsN5UFW7m8Y8WrAdjeWrSV3K3J2hy62xtLNMbbVTbbbkGL+8u2kisw7jjwfgtjxTE+Zpt7tQ2zm/HiGGebO3jqk3hxjCOmhw2610nFI5ylOrj4DaF4hKNr+qpDV7xBoB9w1KINvgo93e5JU3/A25nVOvydQpz6A44Ce5Vuwl/lueSxY91M1s0W2C4Q7RmONu2kXVe9g9KkY30BR2hcJZU3bfibFKE3NBwFnRhvmmMuNzc6HvG46ewH2KaZHQMf73Vw/NDddrIZO0qmNQ543Vfpa/6UzXYQBG1ucBTKbn/hkN5pwnDCTUIc3vRTxAvE81UQTp67KLxBmrsonFhdGF5IEyddZsThhNuMQDx+zInEC8u6SBwVQj89HKGLhb/ognHUmMx9lBGN43fM7ENYGnj0IW7i+/gX+Dfi7SiF5n0YhikUl5GRkZGRkZGRQf8AacFh6JcqsAgAAAAASUVORK5CYII="),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(MyApp.name),
                      subtitle: Text(MyApp.email),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                textColor: Color.fromARGB(255, 6, 102, 9),
                leading: Icon(
                  Icons.home,
                  color: const Color.fromARGB(255, 6, 102, 9),
                ),
                title: Text("Add medication"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AAddMedicinePage()),
                  );
                },
              ),
              ListTile(
                title: Text(
                  "Show meds",
                ),
                leading: Icon(Icons.account_balance_rounded),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MMedicineListPage()),
                  );
                },
              ),
              ListTile(
                title: Text(
                  "View orders",
                ),
                leading: Icon(Icons.check_box),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OOrderListPage()),
                  );
                },
              ),
              ListTile(
                textColor: Colors.red,
                title: Text(
                  "تسجيل الخروج",
                ),
                leading: Icon(Icons.exit_to_app, color: Colors.red),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 5,
            color: Color(0xFF151515),
            shadowColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    TextField(
                      controller: scientificNameController,
                      decoration: InputDecoration(
                        labelText: 'Scientific Name',
                        prefixIcon:
                            Icon(Icons.science, color: Color(0xFFFF9900)),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true, // تمكين التلوين
                        fillColor: Colors.white, // تعيين لون التلوين
                        floatingLabelBehavior: FloatingLabelBehavior
                            .never, // منع رفع النص عند التركيز
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: tradeNameController,
                      decoration: InputDecoration(
                        labelText: 'Trade Name',
                        prefixIcon: Icon(Icons.local_pharmacy,
                            color: Color(0xFFFF9900)),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true, // تمكين التلوين
                        fillColor: Colors.white, // تعيين لون التلوين
                        floatingLabelBehavior: FloatingLabelBehavior
                            .never, // منع رفع النص عند التركيز
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: categoryController,
                      decoration: InputDecoration(
                        labelText: 'Category',
                        prefixIcon:
                            Icon(Icons.category, color: Color(0xFFFF9900)),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true, // تمكين التلوين
                        fillColor: Colors.white, // تعيين لون التلوين
                        floatingLabelBehavior: FloatingLabelBehavior
                            .never, // منع رفع النص عند التركيز
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: manufacturerController,
                      decoration: InputDecoration(
                        labelText: 'The manufacture company',
                        prefixIcon:
                            Icon(Icons.business, color: Color(0xFFFF9900)),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true, // تمكين التلوين
                        fillColor: Colors.white, // تعيين لون التلوين
                        floatingLabelBehavior: FloatingLabelBehavior
                            .never, // منع رفع النص عند التركيز
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Quantity Available',
                        prefixIcon: Icon(Icons.add_shopping_cart,
                            color: Color(0xFFFF9900)),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true, // تمكين التلوين
                        fillColor: Colors.white, // تعيين لون التلوين
                        floatingLabelBehavior: FloatingLabelBehavior
                            .never, // منع رفع النص عند التركيز
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: expiryDateController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: 'Finish Date',
                        prefixIcon: Icon(Icons.calendar_today,
                            color: Color(0xFFFF9900)),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true, // تمكين التلوين
                        fillColor: Colors.white, // تعيين لون التلوين
                        floatingLabelBehavior: FloatingLabelBehavior
                            .never, // منع رفع النص عند التركيز
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Price',
                        prefixIcon:
                            Icon(Icons.attach_money, color: Color(0xFFFF9900)),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true, // تمكين التلوين
                        fillColor: Colors.white, // تعيين لون التلوين
                        floatingLabelBehavior: FloatingLabelBehavior
                            .never, // منع رفع النص عند التركيز
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (scientificNameController.text.isEmpty ||
                            tradeNameController.text.isEmpty ||
                            categoryController.text.isEmpty ||
                            manufacturerController.text.isEmpty ||
                            quantityController.text.isEmpty ||
                            expiryDateController.text.isEmpty ||
                            priceController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please fill out all fields',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(fontSize: 20.0)),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          _add(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFB800),
                        shadowColor: Colors.yellow,
                        minimumSize: Size(30, 40),
                      ),
                      child: Text("Add medication",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _add(context) async {
    var sc_name = scientificNameController.text;
    var trad_name = tradeNameController.text;
    var category = categoryController.text;
    var manufacturer = manufacturerController.text;
    var quantity = quantityController.text;
    var finish_date = expiryDateController.text;
    var price = priceController.text;

    var data = {
      'sc_name': sc_name,
      'trad_name': trad_name,
      'category': category,
      'manufacturer': manufacturer,
      'quantity': quantity,
      'finish_date': finish_date,
      'price': price,
    };

    print("ASD");
    var res = await Network().postData(data, '/medicin/add/');
    print(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      // good connection
      var response = jsonDecode(res.body);
      if (response['error'] == true) {
        _showMessage(context, response['message']);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MMedicineListPage()),
        );
      }
    } else {
      if (res.statusCode == 422) {
        _showMessage(context, jsonDecode(res.body)['message']);
      } else {
        print(res.body);
        _showMessage(context, "Invalid Connection");
      }
    }
  }

  _showMessage(context, msg) {
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> showPharmacistAccountsDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.yellow,
          shadowColor: Colors.red,
          title: Text('Notifications'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: AAddMedicinePage.pharmacistAccounts.map((account) {
              return ListTile(
                title: Text(account.name),
                subtitle: Text(account.email),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  navigateToOrdersPage(context, account.id.toString());
                },
              );
            }).toList(),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shadowColor: Colors.red,
                minimumSize: Size(30, 40),
              ),
              child: Text(
                'Close',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void navigateToOrdersPage(BuildContext context, String pharmacistId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OOrderListPage()),
    );
  }
}

class PharmacistAccount {
  final int id;
  final String name;
  final String email;

  PharmacistAccount(
      {required this.id, required this.name, required this.email});
}
