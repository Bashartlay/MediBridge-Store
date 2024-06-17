import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:store/ARABIC/add.dart';
import 'package:store/api.dart';
import 'package:store/main.dart';
import 'package:store/ARABIC/view.dart';

class Order {
  final int id;
  final String date;
  final String pharmacistName;
  final String orderStatus;
  final bool isPaid;
  final List<Medicine> medicines;

  Order(this.id, this.date, this.pharmacistName, this.medicines,
      this.orderStatus, this.isPaid);
}

class Medicine {
  final String scientificName;
  final String tradeName;
  final int quantity;

  Medicine(this.scientificName, this.tradeName, this.quantity);
}

class OrderListPage extends StatefulWidget {
  static List<Order> orders = [];

  @override
  _OrderListPage createState() => _OrderListPage();
}

class _OrderListPage extends State<OrderListPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    OrderListPage.orders.clear();
    fetchData();
  }

  fetchData() async {
    var res = await Network().getData('/orders/');
    // print(res.body);
    print("ASD");
    if (res.statusCode == 200) {
      var response = jsonDecode(res.body);
      if (response['error'] == false) {
        for (int i = 0; i < response['data'].length; i++) {
          List<Medicine> medicines = [];
          // print(response['data'][i]);
          for (int j = 0; j < response['data'][i]['medicins'].length; j++) {
            var cur = response['data'][i]['medicins'][j];
            medicines.add(
                Medicine(cur['sc_name'], cur['trad_name'], cur['quantity']));
          }
          //************
          // 0 تم الاستلام
          // 1 قيد التحضير
          // 2 تم الإرسال
          //***************
          String status = "";
          if (response['data'][i]['status'] == 0)
            status = "تم الإستلام";
          else if (response['data'][i]['status'] == 1)
            status = "قيد التحضير";
          else
            status = "تم الإرسال";
          print(response['data'][i]['status']);
          OrderListPage.orders.add(Order(
              response['data'][i]['id'],
              response['data'][i]['order_date'],
              response['data'][i]['user'],
              medicines,
              status,
              response['data'][i]['payment_status'] == 0 ? false : true));
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                'قائمة الطلبيات',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
              ),
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
                title: Text(
                  "اضافة دواء",
                  textAlign: TextAlign.right,
                ),
                trailing: Icon(Icons.home),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddMedicinePage()),
                  );
                },
              ),
              ListTile(
                title: Text(
                  "عرض الأدوية",
                  textAlign: TextAlign.right,
                ),
                trailing: Icon(Icons.account_balance_rounded),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MedicineListPage()),
                  );
                },
              ),
              ListTile(
                textColor: Color.fromARGB(255, 6, 102, 9),
                title: Text(
                  "عرض الطلبات",
                  textAlign: TextAlign.right,
                ),
                trailing: Icon(
                  Icons.check_box,
                  color: Color.fromARGB(255, 6, 102, 9),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderListPage()),
                  );
                },
              ),
              ListTile(
                textColor: Colors.red,
                title: Text(
                  "تسجيل الخروج",
                  textAlign: TextAlign.right,
                ),
                trailing: Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: OrderListPage.orders.length,
              itemBuilder: (context, index) {
                return OrderTile(order: OrderListPage.orders[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderTile extends StatefulWidget {
  final Order order;

  OrderTile({required this.order});

  @override
  _OrderTileState createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  late String selectedOrderStatus;
  late bool selectedIsPaid;

  changeStatus(value) async {
    int status = 0;
    if (value == "تم الإستلام")
      status = 0;
    else if (value == "قيد التحضير")
      status = 1;
    else
      status = 2;

    var res = await Network().postData({'order_status': status},
        '/updateOrderStatus/' + widget.order.id.toString());
  }

  changePayment(value) async {
    int status = 0;
    if (value == false)
      status = 0;
    else
      status = 1;

    var res = await Network().postData({'payment_status': status},
        '/updatePaymentStatus/' + widget.order.id.toString());
  }

  @override
  void initState() {
    super.initState();
    print(widget.order.orderStatus);
    selectedOrderStatus = widget.order.orderStatus;
    selectedIsPaid = widget.order.isPaid;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(8),
      color: Colors.white,
      child: ExpansionTile(
        title: ListTile(
          title: Text(
            'اسم الصيدلي: ${widget.order.pharmacistName}',
            textDirection: TextDirection.rtl,
          ),
          subtitle: Column(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'تاريخ الطلب: ${widget.order.date}',
                  textDirection: TextDirection.rtl,
                ),
              ]),
              Column(
                children: [
                  Text(
                    'حالة الطلب: ',
                    textDirection: TextDirection.rtl,
                  ),
                  DropdownButton<String>(
                    value: selectedOrderStatus,
                    onChanged: (newValue) {
                      setState(() {
                        selectedOrderStatus = newValue!;
                      });
                      print('تم اختيار: $newValue');
                      // Handle updating the database here
                      changeStatus(newValue);
                    },
                    items: ['تم الإستلام', 'قيد التحضير', 'تم الإرسال']
                        .map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Visibility(
                visible: selectedOrderStatus == 'تم الإرسال',
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green, // لون الخلفية
                    child: Icon(
                      Icons.check, // رمز التأكيد
                      color: Colors.white, // لون الرمز
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: selectedOrderStatus == 'قيد التحضير',
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.amber, // لون الخلفية
                    child: Icon(
                      Icons.check, // رمز التأكيد
                      color: Colors.black, // لون الرمز
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'حالة الدفع: ',
                textDirection: TextDirection.rtl,
              ),
              DropdownButton<bool>(
                value: selectedIsPaid,
                onChanged: (newValue) {
                  setState(() {
                    selectedIsPaid = newValue!;
                  });
                  print('تم اختيار: $newValue');
                  // Handle updating the database here
                  changePayment(newValue);
                },
                items: [
                  DropdownMenuItem<bool>(
                    value: true,
                    child: Text('مدفوعة'),
                  ),
                  DropdownMenuItem<bool>(
                    value: false,
                    child: Text('غير مدفوعة'),
                  ),
                ],
              ),
            ],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              textDirection: TextDirection.rtl,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < widget.order.medicines.length; i++)
                  Row(
                    children: [
                      MedicineCard(
                          index: i + 1, medicine: widget.order.medicines[i]),
                      SizedBox(width: 10.0),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MedicineCard extends StatelessWidget {
  final int index;
  final Medicine medicine;

  MedicineCard({required this.index, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Color(0xFFFF9900),
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Color(0xFFFFEB3B), width: 2.0), // لون الحواف
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '$index __________',
              textDirection: TextDirection.rtl,
              style: TextStyle(color: Color.fromARGB(255, 10, 155, 15)),
            ),
            Text('الاسم العلمي: ${medicine.scientificName}',
                textDirection: TextDirection.rtl),
            Text('الاسم التجاري: ${medicine.tradeName}',
                textDirection: TextDirection.rtl),
            Text('الكمية المطلوبة: ${medicine.quantity}',
                textDirection: TextDirection.rtl),
          ],
        ),
      ),
    );
  }
}
