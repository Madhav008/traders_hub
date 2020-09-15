import 'package:rxdart/rxdart.dart';
import 'package:trades_club/model/openorders.dart';
import 'package:trades_club/repository/repository.dart';

class OpenTradesBlocList {
  Repository _repository = new Repository();

  final PublishSubject<OpenOrders> _subject = PublishSubject<OpenOrders>();

  getMovies(var id) async {
    OpenOrders response = await _repository.getOpen(id);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  PublishSubject<OpenOrders> get subject => _subject;
}

final openTradesbloc = OpenTradesBlocList();
