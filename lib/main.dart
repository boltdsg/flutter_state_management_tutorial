import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_state_management/store/actions.dart';
import 'package:flutter_state_management/store/reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

// type of actions
enum Types { Click, Increment, AddQuote }

// Connect Store
final store = new Store<AppState>(reducers,
    initialState: AppState(count: 0, clickCount: 0, quote: "Default Quote"),
    middleware: [thunkMiddleware]);

void main() {
  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
        store: store,
        child: MaterialApp(
            theme: ThemeData.dark(),
            title: "Simple title",
            home: Scaffold(
              appBar: AppBar(
                title: Text("Flutter State management"),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    StoreConnector<AppState, int>(
                        converter: (store) => store.state.count,
                        builder: (_, count) {
                          return Text("$count");
                        }),
                    StoreConnector<AppState, String>(
                        converter: (store) => store.state.quote,
                        builder: (_, quote) {
                          return Text(
                            "$quote",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 30.0),
                          );
                        }),

                    // generate quote button
                    StoreConnector<AppState, GenerateQuote>(
                      converter: (store) =>
                          () => store.dispatch(getRandomQuote),
                      builder: (_, generateQuoteCallback) {

                        // ignore: deprecated_member_use
                        return new FlatButton(
                            color: Colors.lightBlue,
                            onPressed: generateQuoteCallback,
                            child: new Text("Change Quote"));
                      },
                    )
                  ],
                ),
              ),
              floatingActionButton: StoreConnector<AppState, IncrementCounter>(
                converter: (store) => () => store.dispatch(Types.Increment),
                builder: (_, incrementCallback) {
                  return new FloatingActionButton(
                    onPressed: incrementCallback,
                    tooltip: 'Increment',
                    child: new Icon(Icons.add),
                  );
                },
              ),
            )));
  }
}

typedef void IncrementCounter();
typedef void GenerateQuote();
