import 'dart:io';

import 'package:brandNamesApp/models/band_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BandModel> bands = [
    BandModel(id: '1', name: 'Metallica', votes: 5),
    BandModel(id: '2', name: 'Queen', votes: 4),
    BandModel(id: '3', name: 'Red Hot Chili Peppers', votes: 5),
    BandModel(id: '4', name: 'Dream Theater', votes: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Band Names',
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, index) => _bandTile(bands[index])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: addNewBand,
        elevation: 1,
      ),
    );
  }

  Widget _bandTile(BandModel band) {
    return Dismissible(
      onDismissed: (direction) {
        print('Eliminado: ${band.id}');
      },
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.only(left: 8),
        color: Colors.red,
        child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                Text(
                  'Borrar banda',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            )),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textEditingController = new TextEditingController();

    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Nombre Banda: '),
            content: TextField(
              controller: textEditingController,
            ),
            actions: [
              MaterialButton(
                child: Text('Agregar'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandToList(textEditingController.text),
              )
            ],
          );
        },
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Nombre Banda: '),
            content: CupertinoTextField(
              controller: textEditingController,
            ),
            actions: [
              CupertinoDialogAction(
                child: Text('Agregar'),
                isDefaultAction: true,
                onPressed: () => addBandToList(textEditingController.text),
              ),
              CupertinoDialogAction(
                  child: Text('Cancelar'),
                  isDestructiveAction: true,
                  onPressed: () => Navigator.pop(context)),
            ],
          );
        },
      );
    }
  }

  void addBandToList(String bandName) {
    if (bandName.length > 2) {
      // se puede agregar
      print(bandName);
      this.bands.add(new BandModel(
          id: DateTime.now().toString(), name: bandName, votes: 0));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
