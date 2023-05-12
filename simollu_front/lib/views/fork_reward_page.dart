import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../viewmodels/UserViewmodel.dart';

class ForkRewardPage extends StatefulWidget {
  final int fork;

  const ForkRewardPage({Key? key, required this.fork}) : super(key: key);

  @override
  State<ForkRewardPage> createState() => _ForkRewardPageState();
}

class _ForkRewardPageState extends State<ForkRewardPage> {

  UserViewModel userViewModel = UserViewModel();
  late List forkList = [];

  initForkList() async {
    forkList = await userViewModel.getForkList();
    print("for_reward_page : ");
  }

  @override
  void initState() {
    super.initState();
    initForkList().then((_) {
      setState(() {
        forkList = forkList;
        print(forkList[0]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            height: 100,
            child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.7,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(5)
                ),

                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/Fork_small.png',),
                          SizedBox(width: 10,),
                          Text('보유 포크', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: widget.fork.toString(), style: TextStyle(color: Colors.amber, fontSize: 20)),
                            TextSpan(text: "개", style: TextStyle(fontSize: 18))
                          ]
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              color: Colors.white,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _ForkHistory(
                      rewardDate: '23/04/18 (월)',
                      rewardAmount: 2000,
                      rewardState: '적립',
                    ),
                    _ForkHistory(
                      rewardDate: '23/04/17 (화)',
                      rewardAmount: 1999,
                      rewardState: '포인트 사용',
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}

class _ForkHistory extends StatelessWidget {
  final String rewardDate;
  final String rewardState;
  final int rewardAmount;

  const _ForkHistory({
    required this.rewardDate,
    required this.rewardState,
    required this.rewardAmount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.93,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 0.5
            )
          )
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Column(
            children: [
              Row(
                children: [
                  Text('$rewardDate | ', style: TextStyle(color: Colors.grey), textAlign: TextAlign.left,),
                  Text(rewardState, style: TextStyle(color: Colors.amber)),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('${NumberFormat('###,###,###,###').format(rewardAmount)}개')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
