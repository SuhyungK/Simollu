import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simollu_front/models/PreferenceModel.dart';
import 'package:simollu_front/viewmodels/PreferenceViewModel.dart';
import 'package:simollu_front/views/liking_things_button.dart';

class LikingThings extends StatefulWidget {
  const LikingThings({Key? key}) : super(key: key);

  @override
  State<LikingThings> createState() => _LikingThingsState();
}

class _LikingThingsState extends State<LikingThings> {
  List<String> likings = ['독서', '걷기', '사진', '쇼핑', '노래', '휴식', '오락&게임'];
  late List<String> selectedLikings = [];
  final preferenceViewModel = PreferenceViewModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            // height: double.infinity,
            child: Column(
              children: [
                Center(
                    child: Container(
                        margin: const EdgeInsets.only(
                            top: 100, bottom: 10), // marginTop 설정
                        child: Column(
                          children: [
                            Text(
                              '기다리면서',
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            Text.rich(
                              TextSpan(
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: 0,
                                    wordSpacing: 0,
                                    height: 1.0,
                                    shadows: []),
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: '뭐하고',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amber)),
                                  TextSpan(text: ' 싶어?'),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Image.asset('assets/liking-image.png'),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Wrap(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.center,
                                children:
                                    List.generate(likings.length, (index) {
                                  var text = likings[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: CustomButton(
                                        text: likings[index],
                                        onPressed: () {
                                          setState(() {
                                            if (selectedLikings
                                                .contains(text)) {
                                              selectedLikings.remove(text);
                                            } else {
                                              selectedLikings.add(text);
                                            }
                                            // print(selectedLikings);
                                          });
                                        }),
                                  );
                                }),
                              ),
                            )
                          ],
                        )))
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 9),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: selectedLikings.length >= 3
                  ? () async {
                      // 완료 버튼 눌렀을 때 발생하는 일
                      final preferenceModel =
                          PreferenceModel(userPrefernceList: selectedLikings);
                      final json = preferenceModel.toJson();
                      final jsonData = jsonEncode(json);
                      // print(jsonEncode(json));
                      var result =
                          await preferenceViewModel.postPreference(jsonData);
                      debugPrint('사용자의 취향 : ${result.userPrefernceList}');
                    }
                  // 선택된 취향이 3개보다 작으면 disabled
                  : null,
              style: ElevatedButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  // backgroundColor: Colors.yellow
                  backgroundColor: Color(0xFFFFD200)),
              child: const Text('완료',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0,
                    wordSpacing: 0,
                    height: 1.0,
                    shadows: [],
                    decoration: TextDecoration.none,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}



//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:simollu_front/root.dart';
// import 'package:simollu_front/views/liking_things_button.dart';
//
// class LikingThings extends StatelessWidget {
//   const LikingThings({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: SingleChildScrollView(
//           child: SizedBox(
//             // height: double.infinity,
//             child: Column(
//               children: [
//                 Center(
//                   child: Container(
//                     margin: const EdgeInsets.only(
//                         top: 100, bottom: 10), // marginTop 설정
//                     child: Column(
//                       children: [
//                         const Text(
//                           "기다리면서",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 50,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.bold,
//                             fontStyle: FontStyle.normal,
//                             letterSpacing: 0,
//                             wordSpacing: 0,
//                             height: 1.0,
//                             shadows: [],
//                             decoration: TextDecoration.none,
//                           ),
//                         ),
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "뭐하고 ",
//                               style: TextStyle(
//                                 color: Color(0xFFFFD200),
//                                 fontSize: 50,
//                                 fontFamily: 'Roboto',
//                                 fontWeight: FontWeight.bold,
//                                 fontStyle: FontStyle.normal,
//                                 letterSpacing: 0,
//                                 wordSpacing: 0,
//                                 height: 1.0,
//                                 shadows: [],
//                                 decoration: TextDecoration.none,
//                               ),
//                             ),
//                             Text("싶어?",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 50,
//                                   fontFamily: 'Roboto',
//                                   fontWeight: FontWeight.bold,
//                                   fontStyle: FontStyle.normal,
//                                   letterSpacing: 0,
//                                   wordSpacing: 0,
//                                   height: 1.0,
//                                   shadows: [],
//                                   decoration: TextDecoration.none,
//                                 )),
//                           ],
//                         ),
//                         Container(
//                           margin: const EdgeInsets.only(top: 20),
//                           child: Image.asset('assets/liking-image.png'),
//                         ),
//                         Container(
//                           margin:
//                           const EdgeInsets.only(left: 21.0, right: 21.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               CustomButton(
//                                 text: '독서',
//                                 onPressed: () {
//                                   print('독서 클릭!!!!!!!!');
//                                 },
//                               ),
//                               CustomButton(
//                                 text: '걷기',
//                                 onPressed: () {
//                                   print('걷기 클릭!!!!!!!!');
//                                 },
//                               ),
//                               CustomButton(
//                                 text: '사진',
//                                 onPressed: () {
//                                   print('사진 클릭!!!!!!!!');
//                                 },
//                               ),
//                               CustomButton(
//                                 text: '쇼핑',
//                                 onPressed: () {
//                                   print('쇼핑 클릭!!!!!!!!');
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin:
//                           const EdgeInsets.only(left: 35.0, right: 35.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               CustomButton(
//                                 text: '노래',
//                                 onPressed: () {
//                                   print('노래 클릭!!!!!!!!');
//                                 },
//                               ),
//                               CustomButton(
//                                 text: '휴식',
//                                 onPressed: () {
//                                   print('휴식 클릭!!!!!!!!');
//                                 },
//                               ),
//                               CustomButton(
//                                 text: '오락 & 게임',
//                                 onPressed: () {
//                                   print('오락 & 게임 클릭!!!!!!!!');
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: Container(
//           margin: EdgeInsets.only(bottom: 9),
//           padding: EdgeInsets.only(left: 10, right: 10),
//           child: SizedBox(
//             width: double.infinity,
//             height: 50,
//             child: ElevatedButton(
//               onPressed: () {
//                 Get.to(Root());
//               },
//               style: ElevatedButton.styleFrom(
//                   splashFactory: NoSplash.splashFactory,
//                   // backgroundColor: Colors.yellow
//                   backgroundColor: Color(0xFFFFD200)),
//               child: const Text('완료',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 20,
//                     fontFamily: 'Roboto',
//                     fontWeight: FontWeight.bold,
//                     fontStyle: FontStyle.normal,
//                     letterSpacing: 0,
//                     wordSpacing: 0,
//                     height: 1.0,
//                     shadows: [],
//                     decoration: TextDecoration.none,
//                   )),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
