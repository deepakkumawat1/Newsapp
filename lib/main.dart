import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'NewsApp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map data;
  List userData;

  Future myfunc() async {
    var response = await http.get(
        'https://newsapi.org/v2/everything?q=bitcoin&from=2019-12-17&sortBy=publishedAt&apiKey=3fdfa59687744fda89805df2c3615794');
    data = json.decode(response.body);

    setState(() {
      userData = data['articles'];
    });
  }

  @override
  void initState() {
    super.initState();
    myfunc();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body:

      Column(


              children: <Widget>[


                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(

                        itemCount: userData == null ? 0 : userData.length
                        ,
                        itemBuilder:(context,index){
                          return Stack(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                //height: 300.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4.0,bottom: 8.0),
                                  child: Material(
                                     color: Colors.white,
                                    elevation: 14.0,
                                    shadowColor: Colors.black ,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap:()async{
                                            await FlutterWebBrowser.openWebPage(url: "${userData[index]['url']}", androidToolbarColor: Colors.deepPurple);


                                                },
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child:  Text("${userData[index]['title']}",style:TextStyle(fontSize: 20, fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.bold,
                                                  color: Colors.blue,) ,),
                                              ),
                                              SizedBox(height: 10.0,),


                                              Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  height: 200,
                                                  child:userData[index]['urlToImage'] != null?

                                                  Image.network('${userData[index]['urlToImage']}',fit: BoxFit.cover,): Text("Image not found"),
                                                ),


                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],

                          );


                        } ),
                  ),
                ),


              ],
            ),




    );
  }
}
