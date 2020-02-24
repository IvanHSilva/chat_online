import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main(){

  runApp(MyApp());
  createMsg('msg3', 'Davi', 'Ivan', 'Response', 'Answering your doubt', '24/02/2020');
  updateMsg('msg1', {'read': 'true'});
  //readAllMsg();
  //readMsg('msg1');
  listenMsg();
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat Online',      
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(),
    );
  }
}

void createMsg(String doc, String from, String to, String subject, String text, String date){
  Firestore.instance.collection('messages').document(doc).setData({
    'from': from,
    'to': to,
    'subject': subject,
    'text': text,
    'date': date});
}

void updateMsg(String doc, Map <String, dynamic> data) async {
  DocumentSnapshot snapshot = await Firestore.instance.collection('messages').document(doc).get();
  snapshot.reference.updateData(data);
}  

void readMsg(String doc) async {
  DocumentSnapshot snapshot = await Firestore.instance.collection('messages').document(doc).get();
  print(doc + ': ' + snapshot.data.toString());
}  

void readAllMsg() async {
  QuerySnapshot snapshot = await Firestore.instance.collection('messages').getDocuments();
  snapshot.documents.forEach((doc){
    print(doc.documentID + ': ' + doc.data.toString());
  });
}

void listenMsg() async {
  Firestore.instance.collection('messages').snapshots().listen((docs){
    print(docs.documents[0].data);
  });
}

