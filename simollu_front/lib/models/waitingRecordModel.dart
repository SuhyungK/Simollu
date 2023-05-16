class WaitingRecordModel {
  int? waitingSeq;
  String? userSeq;
  int? restaurantSeq;
  int? waitingPersonCnt;
  int? waitingNo;
  String? restaurantName;
  String? waitingStatusRegistDate;
  int? waitingStatusContent;

  WaitingRecordModel(
      {
        this.waitingSeq,
        this.userSeq,
        this.restaurantSeq,
        this.waitingPersonCnt,
        this.waitingNo,
        this.restaurantName,
        this.waitingStatusRegistDate,
        this.waitingStatusContent
      });

  WaitingRecordModel.fromJson(Map<String, dynamic> json)
    : waitingSeq = json['waitingSeq'],
      userSeq = json['userSeq'],
      restaurantSeq = json['restaurantSeq'],
      waitingPersonCnt = json['waitingPersonCnt'],
      waitingNo = json['waitingNo'],
      restaurantName = json['restaurantName'],
      waitingStatusRegistDate = json['waitingStatusRegistDate'],
      waitingStatusContent = json['waitingStatusContent'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['waitingSeq'] = waitingSeq;
    data['userSeq'] = userSeq;
    data['restaurantSeq'] = restaurantSeq;
    data['waitingPersonCnt'] = waitingPersonCnt;
    data['waitingNo'] = waitingNo;
    data['restaurantName'] = restaurantName;
    data['waitingStatusRegistDate'] = waitingStatusRegistDate;
    data['waitingStatusContent'] = waitingStatusContent;
    return data;
  }
}
