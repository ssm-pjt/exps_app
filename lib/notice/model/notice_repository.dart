import 'notice_data.dart';

class NoticeRepository {
  List<NoticeData> getList() {
    List<NoticeData> list = [];

    list.add(NoticeData(
      title: '시스템 개선 및 점검 안내', 
      content: '''
안녕하세요. OOOO 코리아입니다.
보다 나은 서비스를 제공해 드리고자 아래와 같이 시스템 작업을 진행합니다.

- 일자 및 시간 : 2022년 2월 10일 (목) 00시 00분 ~ 02시 00분
- 대상 서비스 : 홈페이지 / APP / GEAR / Bixby / 삼성카드 스타벅스 오더 / 신한PayFAN 스타벅스오더 / 네이버 주문 / 스타벅스 현대카드 발급 서비스

해당 점검 시간 중 웹/앱 및 외부 채널 서비스 이용에 불편사항이 발생할 수 있는 점 양해 부탁 드립니다.
감사합니다.
''',
      date: '2022.02.08 12:00',
      unread: true));
    list.add(NoticeData(title: '주말 시스템 작업', content: '작업일시: 2022년 2월 10일 (목)\n작업내용: 시스템 업그레이드 작업\n\n ', date: '2022.02.08 12:00', unread: false));
    list.add(NoticeData(title: '법인카드 사용안내', content: '하나, \n둘,\n셋,\n\n이상', date: '2022.02.08 12:00', unread: false));

    return list;
  }
}
