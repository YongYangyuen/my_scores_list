import 'package:flutter/material.dart';
import 'package:my_scores_list/presentation/add_screen.dart';
import 'package:my_scores_list/presentation/show_screen.dart';
import 'config/routes.dart';

void main() {
  runApp(MyApp());
}

List names = ['JJ', 'Poon', 'Geng', 'John'];
List scores = [80, 77, 85, 60];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My List',
      onGenerateRoute: _registerRouteWithParameters,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'My List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);

  void updateData(String name, int score) {
    if (isEdit) {
      names[editIndex] = name;
      scores[editIndex] = score;
    } else {
      names.add(name);
      scores.add(score);
    }
    isEdit = false;
  }

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        automaticallyImplyLeading: false,
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              ListTile(
                onTap: () => Navigator.of(context).pushNamed(
                    AppRoutes.pageShowData,
                    arguments: ShowParameters(index)),
                leading: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                title: Text(
                  names[index],
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                trailing: Text(
                  scores[index].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 55,
                  ),
                ),
              ),
              Divider(), //                           <-- Divider
            ],
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          myControllerTextName.clear(),
          textScore = '',
          Navigator.of(context).pushNamed(AppRoutes.pageAddData,
              arguments: AddParameters("Add Data")),
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Route _registerRouteWithParameters(RouteSettings settings) {
  if (settings.name == AppRoutes.pageShowData) {
    return MaterialPageRoute(builder: (context) {
      ShowParameters parameter = settings.arguments;
      return ShowScreen(index: parameter.index);
    });
  }
  if (settings.name == AppRoutes.pageAddData) {
    return MaterialPageRoute(builder: (context) {
      AddParameters parameter = settings.arguments;
      return AddScreen(title: parameter.title);
    });
  }
}
