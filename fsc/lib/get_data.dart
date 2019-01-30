// import 'package:flutter/material.dart';
// import 'dart:convert';

// import 'package:http/http.dart' as http;


// class GetData extends StatefulWidget {

//   @override
//   State<StatefulWidget> createState() {
    
//     return _GetData();
//   }

// }

// class _GetData extends State<GetData> {

//   List list;
//   bool isLoading = false;

//   // _fetchData () {
    
//   //   setState(() {
//   //     isLoading = true;
//   //   });

//   //   final response =  http.get("https://my-json-server.typicode.com/abbasidaniyal/DummyDB/tournaments");

//   //   if(response.statusCode==200){
//   //     list = json.decode(response.body);  
//   //   }

//   // }
// /*


//   @override
//   Widget build (BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: RaisedButton(
//         child: Text("Press"),
//         onPressed: (){
//           _fetchData();
//         },
//       ),
//       body: ListView.builder(
//         itemCount: 4,
//         itemBuilder: (BuildContext context, int index){
          
//           return ListTile(
//             title: Text(list[index]["name"]),
//           );
//         },
//       ),
//     );
//   }

// }


