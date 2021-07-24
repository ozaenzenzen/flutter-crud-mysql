// import 'package:flutter/material.dart';
// import 'package:flutter_crud_mysql_1/services/homedata_services.dart';
// import 'package:flutter_crud_mysql_1/widget/home_item.dart';

// class DataPage extends StatefulWidget {
//   @override
//   _DataPageState createState() => _DataPageState();
// }

// class _DataPageState extends State<DataPage> {
//   Homedata homedata = Homedata();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             StreamBuilder<List>(
//               stream: homedata.getDataStream(),
//               builder: (context, snapshot) {
//                 var data = snapshot.data;
//                 if (snapshot.hasData == true) {
//                   return ListView.builder(
//                     // controller: scrollController,
//                     shrinkWrap: true,
//                     physics: ScrollPhysics(),
//                     itemCount: (data == null) ? 0 : data.length,
//                     itemBuilder: (context, index) {
//                       return HomeItem(
//                         data: data,
//                         index: index,
//                       );
//                     },
//                   );
//                 } else {
//                   return Center(
//                     child: SizedBox(
//                       height: 30,
//                       width: 30,
//                       child: CircularProgressIndicator(),
//                     ),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
