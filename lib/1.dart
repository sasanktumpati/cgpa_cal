import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

const semList = ['1 - 1','1 - 2','2 - 1','2 - 2','3 - 1','3 - 2','4 - 1','4 - 2'];

class DropdownSem extends StatefulWidget {
  const DropdownSem({Key? key}) : super(key: key);

  @override
  _DropdownSemState createState() => _DropdownSemState();
}

class _DropdownSemState extends State<DropdownSem> {
  var selectedSem = semList.first;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.only(left: 15, right: 25, top: 3, bottom: 3),
    decoration: BoxDecoration(
      color: const Color(0xFFfafafa),
      border: Border.all(color: Colors.black, width: 1),
      borderRadius: BorderRadius.circular(15),
    ),
    child: DropdownButton(
      value: selectedSem,
      onChanged: (String? newSem) => setState(() => selectedSem = newSem!),
      items: semList.map((e) => DropdownMenuItem(
        value: e,
        child: Text(e, style: const TextStyle(fontFamily: 'noto', color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
      )).toList(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: PreferredSize(
      preferredSize: const Size.fromHeight(85),
      child: Padding(
        padding: const EdgeInsets.only(top: 11),
        child: AppBar(
          title: const DropdownSem(),
          backgroundColor: const Color(0xFFfafafa),
          elevation: 0,
          toolbarHeight: 60,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.analytics, size: 30, color: Colors.black)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings, size: 30, color: Colors.black)),
          ],
        ),
      ),
    ),

    //Body

    body: Table(

    ),


  );
}
