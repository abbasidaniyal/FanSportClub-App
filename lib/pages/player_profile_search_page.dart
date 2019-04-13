// import 'package:flutter/material.dart';

// import '../widget/drawer.dart';
// import '../widget/button.dart';
// import '../scoped_model/main.dart';
// import 'package:scoped_model/scoped_model.dart';
// import './player_profile_page.dart';

// class CustomSearchDelegate extends SearchDelegate {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = "";
//         },
//       )
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     // TODO: implement buildLeading
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     MainModel model = ScopedModel.of(context);

//     final results = model.playerProfiles
//         .where((a) => a.name.toLowerCase().contains(query.toLowerCase()));

//     return ListView.builder(
//       padding: EdgeInsets.all(0),
//       itemCount: results.toList().length,
//       itemBuilder: (context, int index) {
//         if (model.playerProfiles.length > 0) {
//           return Container(
//             width: MediaQuery.of(context).size.width,
//             margin: EdgeInsets.symmetric(vertical: 20.0),
//             child: GestureDetector(
//               child: Row(
//                 mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.1,
//                     child: Icon(
//                       Icons.account_circle,
//                     ),
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.9,
//                     child: Text(
//                       results.toList()[index].name,
//                       textScaleFactor: 1.3,
//                     ),
//                   )
//                 ],
//               ),
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return PlayerProfilePage(results.toList()[index]);
//                     },
//                   ),
//                 );
//               },
//             ),
//           );
//         } else
//           return CircularProgressIndicator();
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     MainModel model = ScopedModel.of(context);

//     final results = model.playerProfiles
//         .where((a) => a.name.toLowerCase().contains(query.toLowerCase()));

//     return ListView.builder(
//       padding: EdgeInsets.all(0),
//       itemCount: results.toList().length,
//       itemBuilder: (context, int index) {
//         if (model.playerProfiles.length > 0) {
//           return Container(
//             width: MediaQuery.of(context).size.width,
//             margin: EdgeInsets.symmetric(vertical: 20.0),
//             child: GestureDetector(
//               child: Row(
//                 mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.1,
//                     child: Icon(
//                       Icons.account_circle,
//                     ),
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.9,
//                     child: Text(
//                       results.toList()[index].name,
//                       textScaleFactor: 1.3,
//                     ),
//                   )
//                 ],
//               ),
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return PlayerProfilePage(results.toList()[index]);
//                     },
//                   ),
//                 );
//               },
//             ),
//           );
//         } else
//           return CircularProgressIndicator();
//       },
//     );
//   }
// }

// class PlayerProfileSearch extends StatefulWidget {
//   @override
//   _PlayerProfileSearchState createState() => _PlayerProfileSearchState();
// }

// class _PlayerProfileSearchState extends State<PlayerProfileSearch> {
//   String nameToBeSearched;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     MainModel model = ScopedModel.of(context);
//     model.intiProfileData(model.token);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: MyDrawer(),
//       appBar: AppBar(
//         title: Text("Search Player Data"),
//         backgroundColor: Theme.of(context).primaryColor,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               showSearch(
//                 context: context,
//                 delegate: CustomSearchDelegate(),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Container(child: Container() //ListView.builder(),
//           ),
//     );
//   }
// }
