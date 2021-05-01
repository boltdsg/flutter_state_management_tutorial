import 'package:flutter_state_management/store/reducer.dart';
import "package:redux/redux.dart";
import 'package:redux_thunk/redux_thunk.dart';

class UpdateQuoteAction {
  String _quote;

  String get quote => this._quote;

  UpdateQuoteAction(this._quote);
}

ThunkAction<AppState> getRandomQuote = (Store<AppState> store) async {
  store.dispatch(new UpdateQuoteAction("Updated New Quote"));
};
