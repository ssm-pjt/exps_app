
import 'package:uuid/uuid.dart';

import 'card_data.dart';

class CardRepository {

  getCardList() {
    List<CardData> card_list = [];

    card_list.add(new CardData(
      id: Uuid().v4().toString().substring(0, 18),
      apprAmt: 1000,
      apprTot: 1000,
      apprNo: '00000013',
      apprDt: '20220213',
      apprTm: '120123',
      cardNo: '1234-1234-1234-1234',
      merchant: '미니스톱 한강양화2점',
      userId: 'test',
      merchantAddr: '서울 영등포구 노들로 147',
      type: 'C',
      status: 'U',
    ));
    card_list.add(new CardData(
      id: Uuid().v4().toString().substring(0, 18),
      apprAmt: 2000,
      apprTot: 2000,
      apprNo: '00000012',
      apprDt: '20220212',
      apprTm: '120223',
      cardNo: '1234-1234-1234-1234',
      merchant: '세븐일레븐 당산역 본점',
      userId: 'test',
      merchantAddr: '서울 영등포구 당산로 237 ',
      type: 'R',
      status: 'U',
    ));
    card_list.add(new CardData(
      id: Uuid().v4().toString().substring(0, 18),
      apprAmt: 3000,
      apprTot: 3000,
      apprNo: '00000011',
      apprDt: '20220211',
      apprTm: '130101',
      cardNo: '1234-1234-1234-1234',
      merchant: '세븐일레븐 여의나루점',
      userId: 'test',
      merchantAddr: '서울 영등포구 여의동로 지하 343 ',
      type: 'C',
      status: 'U',
    ));
    card_list.add(new CardData(
      id: Uuid().v4().toString().substring(0, 18),
      apprAmt: 3000,
      apprTot: 3000,
      apprNo: '00000010',
      apprDt: '20220210',
      apprTm: '151445',
      cardNo: '1234-1234-1234-1234',
      merchant: 'GS25점 에이스  문래점',
      userId: 'test',
      merchantAddr: '서울특별시 영등포구 경인로 775 에이스하이테크시티',
      type: 'C',
      status: 'U',
    ));
    card_list.add(new CardData(
      id: Uuid().v4().toString().substring(0, 18),
      apprAmt: 4000,
      apprTot: 4000,
      apprNo: '00000009',
      apprDt: '20220209',
      apprTm: '180353',
      cardNo: '1234-1234-1234-1234',
      merchant: 'GS25 연신내 으뜸점',
      userId: 'test',
      merchantAddr: '서울 은평구 연서로28길 6',
      type: 'R',
      status: 'U',
    ));
    card_list.add(new CardData(
      id: Uuid().v4().toString().substring(0, 18),
      apprAmt: 6000,
      apprTot: 6000,
      apprNo: '00000008',
      apprDt: '20220208',
      apprTm: '124030',
      cardNo: '1234-1234-1234-1234',
      merchant: 'CU 영등포 에이스점',
      userId: 'test',
      merchantAddr: '서울특별시 영등포구 경인로 775 에이스하이테크시티',
      type: 'C',
      status: 'U',
    ));
    card_list.add(new CardData(
      id: Uuid().v4().toString().substring(0, 18),
      apprAmt: 10000,
      apprTot: 10000,
      apprNo: '00000007',
      apprDt: '20220207',
      apprTm: '113012',
      cardNo: '1234-1234-1234-1234',
      merchant: '파리바게뜨 문래역점',
      userId: 'test',
      merchantAddr: '서울 영등포구 당산로 34 1층',
      type: 'C',
      status: 'U',
    ));
    card_list.add(new CardData(
      id: Uuid().v4().toString().substring(0, 18),
      apprAmt: 20000,
      apprTot: 20000,
      apprNo: '00000006',
      apprDt: '20220206',
      apprTm: '113133',
      cardNo: '1234-1234-1234-1234',
      merchant: '파리바게뜨 문래역점',
      userId: 'test',
      merchantAddr: '서울 영등포구 당산로 34 1층',
      type: 'R',
      status: 'U',
    ));
    card_list.add(new CardData(
      id: Uuid().v4().toString().substring(0, 18),
      apprAmt: 30000,
      apprTot: 30000,
      apprNo: '00000005',
      apprDt: '20220205',
      apprTm: '113559',
      cardNo: '1234-1234-1234-1234',
      merchant: '파리바게뜨 문래역점',
      userId: 'test',
      merchantAddr: '서울 영등포구 당산로 34 1층',
      type: 'R',
      status: 'U',
    ));
    card_list.add(new CardData(
      id: Uuid().v4().toString().substring(0, 18),
      apprAmt: 30000,
      apprTot: 30000,
      apprNo: '00000004',
      apprDt: '20220204',
      apprTm: '134010',
      cardNo: '1234-1234-1234-1234',
      merchant: '파리바게뜨 문래역점',
      userId: 'test',
      merchantAddr: '서울 영등포구 당산로 34 1층',
      type: 'R',
      status: 'U',
    ));
    card_list.add(new CardData(
      id: Uuid().v4().toString().substring(0, 18),
      apprAmt: 30000,
      apprTot: 30000,
      apprNo: '00000003',
      apprDt: '20220203',
      apprTm: '113821',
      cardNo: '1234-1234-1234-1234',
      merchant: '파리바게뜨 문래역점',
      userId: 'test',
      merchantAddr: '서울 영등포구 당산로 34 1층',
      type: 'R',
      status: 'U',
    ));
    card_list.add(new CardData(
      id: Uuid().v4().toString().substring(0, 18),
      apprAmt: 30000,
      apprTot: 30000,
      apprNo: '00000002',
      apprDt: '20220202',
      apprTm: '150000',
      cardNo: '1234-1234-1234-1234',
      merchant: '파리바게뜨 문래역점',
      userId: 'test',
      merchantAddr: '서울 영등포구 당산로 34 1층',
      type: 'C',
      status: 'U',
    ));
    card_list.add(new CardData(
      id: Uuid().v4().toString().substring(0, 18),
      apprAmt: 30000,
      apprTot: 30000,
      apprNo: '00000001',
      apprDt: '20220201',
      apprTm: '142230',
      cardNo: '1234-1234-1234-1234',
      merchant: '파리바게뜨 문래역점',
      userId: 'test',
      merchantAddr: '서울 영등포구 당산로 34 1층',
      type: 'R',
      status: 'U',
    ));
    card_list.add(new CardData(
      id: Uuid().v4().toString().substring(0, 18),
      apprAmt: 1000000,
      apprTot: 1000000,
      apprNo: '00000001',
      apprDt: '20220201',
      apprTm: '175010',
      cardNo: '1234-1234-1234-1234',
      merchant: '홈플러스 문래점',
      userId: 'test',
      merchantAddr: '서울특별시 영등포구 당산로 42',
      type: 'R',
      status: 'U',
    ));

    return card_list;

  }


}