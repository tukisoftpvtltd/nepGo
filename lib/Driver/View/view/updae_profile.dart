// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../User/View/constants/colors.dart';
// import '../../../User/View/widgets/button.dart';
// import '../../../User/View/widgets/input_text_box.dart';
// import 'profile.dart';

// class UpateProfile extends StatefulWidget {
//   const UpateProfile({super.key});

//   @override
//   State<UpateProfile> createState() => _UpateProfileState();
// }

// class _UpateProfileState extends State<UpateProfile> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getUserDatas();
//   }
//    String fname = '';
//   String lname = '';
//   String email = '';
//   getUserDatas() async {
//     SharedPreferences userData = await SharedPreferences.getInstance();
//     //final userId = userData .getString('user_id');
//     setState(() {
//       fname = userData.getString('fname') == null
//           ? ''
//           : userData.getString('fname')!;
//       lname = userData.getString('lname') == null
//           ? ''
//           : userData.getString('lname')!;
//       email = userData.getString('email') == null
//           ? ''
//           : userData.getString('email')!;

//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         shadowColor: Colors.transparent,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//         ),
//         title: const Text('Update Profile',
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             )),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//                 width: 365,
//                 height: 55,
//                 margin: const EdgeInsets.all(20),
//                 child:  InputTextBox(
//                   hinttext: 'First Name',
//                   select: false,
//                   type: TextInputType.name,
//                 )),
//             const SizedBox(
//               width: 365,
//               height: 55,
//               child: InputTextBox(
//                 hinttext: 'Last Name',
//                 select: false,
//               ),
//             ),
//             const SizedBox(height: 15),
//             Container(
//               width: 365,
//               margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Contact',
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               width: 365,
//               height: 55,
//               margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//               child:  InputTextBox(
//                 hinttext: 'Phone',
//                 type: TextInputType.number,
//                 select: false,
//               ),
//             ),
//             const SizedBox(
//               width: 365,
//               height: 55,
//               child: InputTextBox(
//                 hinttext: 'Email',
//                 select: false,
//                 type: TextInputType.emailAddress,
//               ),
//             ),
//             Container(
//               width: 365,
//               margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Address',
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 15),
//             const ReuseableDropdownMenu(),
//             const SizedBox(height: 15),
//             const ReuseableDropdownMenu(),
//             const SizedBox(height: 15),
//             Container(
//               width: 365,
//               height: 55,
//               margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//               child: const InputTextBox(
//                 hinttext: 'City',
//                 select: false,
//                 icon: null,
//               ),
//             ),
//             const SizedBox(
//               width: 365,
//               height: 55,
//               child: InputTextBox(
//                 hinttext: 'Street',
//                 select: false,
//                 icon: null,
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             SizedBox(
//               height: 45,
//               width: 365,
//               child: CustomButton(
//                   label: 'UPDATE',
//                   color: Colours.primarygreen,
//                   onpressed: () {
//                     // Navigator.of(context).push(
//                     //   MaterialPageRoute(
//                     //     builder: (BuildContext context) {
//                     //       return  Profile(
//                     //         name: fname +" "+lname,
//                     //         email: email,
//                     //         phoneno: '',
//                     //       );
//                     //     },
//                     //   ),
//                     // );
//                   }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
