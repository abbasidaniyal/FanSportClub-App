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
      setState(() {
        isLoading = status;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment History"),
      ),
      body: Container(
        child: isLoading == true
            ? CircularProgressIndicator()
            : ListView.builder(),
      ),
    );
  }
}
