import 'package:Fan_Sports/models/paid_event_detail.dart';
import 'package:Fan_Sports/scoped_model/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PaymentHistory extends StatefulWidget {
  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  bool isLoading = true;
  List<PaidEventDetails> array = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    MainModel model = ScopedModel.of(context);
    await model
        .getPaymentHistory(model.token, model.loggedInUser.id)
        .then((status) {
      array = model.paymentHistoryList;
      setState(() {
        isLoading = status;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment History"),
      ),
      body: Container(
        child: isLoading == true
            ? Center(child: CircularProgressIndicator())
            : array.length==0? Center(
              child: Text("No payment history"),
            ) :ListView.builder(
                itemCount: array.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              "Tournament Name : " + array[index].tournamentName,textScaleFactor: 1.5,style: TextStyle(fontWeight: FontWeight.bold  ),),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Amount : " + array[index].entryFee.toString()),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Age Category Limit :" +
                              array[index].ageCategory.toString()),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Event Type : " + array[index].eventType),
                        ],
                      ),
                    ),
                  );  
                },
              ),
      ),
    );
  }
}
