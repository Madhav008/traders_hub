
import 'package:rxdart/rxdart.dart';
import 'package:trades_club/model/closeorders.dart';
import 'package:trades_club/repository/repository.dart';

class CloseTradesBlocList  {
  Repository _repository = new Repository();

  BehaviorSubject<CloseOrders> _subject = BehaviorSubject<CloseOrders>();


getClose(var id) async {
    CloseOrders response = await _repository.getClose(id);
    _subject.sink.add(response);
  }


  dispose() {
    _subject.close();


  }

  BehaviorSubject<CloseOrders> get subject => _subject;


  
}
final closeTradesbloc = CloseTradesBlocList();

/* (profit*10)/volume*100 */