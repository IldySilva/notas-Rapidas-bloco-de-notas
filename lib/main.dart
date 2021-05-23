import 'package:ListTodo/Interface/addBox.dart';
import 'package:ListTodo/Interface/telanova.dart';
import 'package:ListTodo/controller/Service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'DataBase/todosModel.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseAdMob.instance
  //     .initialize(appId: "ca-app-pub-1728802505275402~9005622283");
  runApp(GetMaterialApp(
    home: App(),
    debugShowCheckedModeBanner: false,
  ));

  // myBanner
  //   // typically this happens well before the ad is shown
  //   ..load()
  //   ..show(

  //       // Positions the banner ad 60 pixels from the bottom of the screen
  //       anchorOffset: 0,
  //       // Positions the banner ad 10 pixels from the center of the screen to the right
  //       horizontalCenterOffset: 0.0,
  //       // Banner Position
  //       anchorType: AnchorType.top);
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Crud crud = Get.put(Crud());
  @override
  void initState() {
    super.initState();
    crud.getAll();
    crud.getUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              child: Icon(Icons.add),
              onPressed: () {
                addTodo(context);
              },
            ),
          ),
          body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(top: Get.height / 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Get.height / 90),
                    child: Row(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.black,
                                child: Text(
                                  crud.totalCriado.string,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                            Padding(
                                padding: EdgeInsets.only(left: Get.width / 95)),
                            Container(
                                width: Get.width / 4.9,
                                child: AutoSizeText(
                                  "Tarefas Criadas",
                                  maxFontSize: 14,
                                  minFontSize: 12,
                                  maxLines: 2,
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.green,
                                child: Text(crud.totalFeitos.string)),
                            Padding(
                                padding: EdgeInsets.only(left: Get.width / 95)),
                            Container(
                                width: Get.width / 4.9,
                                child: AutoSizeText(
                                  "Tarefas Completas",
                                  maxFontSize: 14,
                                  minFontSize: 12,
                                  maxLines: 2,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          iconSize: 28,
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteAll(context)),
                      IconButton(
                        iconSize: 28,
                        icon: Icon(Icons.info),
                        onPressed: () => Get.to(TelaNova()),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Flexible(
              flex: 2,
              child: Container(
                child: crud.totalCriado.value == 0
                    ? Text("Adicione Tarefas a fazer")
                    : ListView.builder(
                        itemCount: crud.allTodos.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: ListTile(
                                  onTap: () {
                                    showInfo(
                                      context,
                                      crud.allTodos[index],
                                    );
                                    debugPrint(crud.allTodos[index].desc);
                                  },
                                  onLongPress: () =>
                                      deleteBox(context, crud.allTodos[index]),
                                  trailing: IconButton(
                                    icon: (Icon(
                                        crud.allTodos[index].isDone == "sim"
                                            ? Icons.done
                                            : Icons.circle,
                                        color:
                                            crud.allTodos[index].isDone == "sim"
                                                ? Colors.green
                                                : Colors.black)),
                                    onPressed: () async {
                                      print(crud.allTodos[index].id);
                                      crud.todos.nome =
                                          crud.allTodos[index].nome;
                                      crud.todos.desc =
                                          crud.allTodos[index].desc;

                                      crud.todos.isDone = "sim";
                                      crud.todos.id = crud.allTodos[index].id;

                                      await crud.service.update(crud.todos);
                                      crud.todos = Todos();
                                      crud.updating();
                                      print("updateed");
                                    },
                                  ),
                                  title: Text(crud.allTodos[index].nome,
                                      style: TextStyle(
                                          color: crud.allTodos[index].isDone ==
                                                  "sim"
                                              ? Colors.grey
                                              : Colors.black,
                                          decoration:
                                              crud.allTodos[index].isDone ==
                                                      "sim"
                                                  ? TextDecoration.lineThrough
                                                  : null))));
                        },
                      ),
              ),
            ),
          ])),
    );
  }
}

// MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//   keywords: <String>['flutterio', 'beautiful apps'],
//   contentUrl: 'https://flutter.io',

//   childDirected: false,

//   // or MobileAdGender.female, MobileAdGender.unknown
//   testDevices: <String>[], // Android emulators are considered test devices
// );

// BannerAd myBanner = BannerAd(
//   // Replace the testAdUnitId with an ad unit id from the AdMob dash.
//   // https://developers.google.com/admob/android/test-ads
//   // https://developers.google.com/admob/ios/test-ads
//   adUnitId: BannerAd.testAdUnitId,
//   size: AdSize.smartBanner,
//   targetingInfo: targetingInfo,
//   listener: (MobileAdEvent event) {
//     print("BannerAd event is $event");
//   },
// );
