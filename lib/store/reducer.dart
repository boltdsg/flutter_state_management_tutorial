import 'package:flutter_state_management/store/actions.dart';
import "package:redux/redux.dart";
import "../main.dart";

class AppState {
  final int count;
  final int clickCount;
  final String quote;

  AppState({this.count, this.clickCount, this.quote});

  AppState copyWith({count, clickCount, quote}) {
    return AppState(
        count: count ?? this.count,
        clickCount: clickCount ?? this.clickCount,
        quote: quote ?? this.quote);
  }
}

/* Reducers */
AppState counterReducer(AppState state, dynamic action) {
  switch (action) {
    case Types.Increment:
      return state.copyWith(count: state.count + 1);
  }
  return state;
}

AppState updateQuoteReducer(AppState state, dynamic action) {
  if (action is UpdateQuoteAction) {
    return state.copyWith(quote: action.quote);
  }
  return state;
}

final reducers =
    combineReducers<AppState>([counterReducer, updateQuoteReducer]);
