import 'package:flutter/material.dart';

class User1 extends StatelessWidget {
  const User1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text('사용자 정보', style: TextStyle(
          color: Colors.black54,
          fontSize: 15,
          fontWeight: FontWeight.bold,)),
      ),
      body: ListView(
        children: [
          ListTile(

            leading: Text("성명",  style: TextStyle(fontWeight: FontWeight.bold),),
            title: Container(
              padding: EdgeInsets.zero,
              width: 100,
              height: 50,
              margin: EdgeInsets.zero,
              child: const TextField(
                maxLength: 12,
                style: TextStyle(fontSize: 14, color: Colors.blue,),
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(hintText: '',
                    border: OutlineInputBorder(),
                ),

              )
            )
          ),

          ListTile(
              leading: Text("이메일", style: TextStyle(fontWeight: FontWeight.bold),),
              title: Container(
                  padding: EdgeInsets.zero,
                  width: 100,
                  height: 50,
                  child: const TextField(
                    maxLength: 100,
                    style: TextStyle(fontSize: 14, color: Colors.blue,),
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(hintText: '',
                      border: OutlineInputBorder(),
                    ),

                  )
              )
          ),

        ],
      )
    );
  }
}

class User2 extends StatelessWidget {
  const User2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text('설정', style: TextStyle(
          color: Colors.black54,
          fontSize: 15,
          fontWeight: FontWeight.bold,)),
      ),
      body: Center(child:Text('body')),
    );
  }
}

class User3 extends StatelessWidget {
  const User3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text('도움말', style: TextStyle(
          color: Colors.black54,
          fontSize: 15,
          fontWeight: FontWeight.bold,)),
      ),
      body: Center(child:Text('body')),
    );
  }
}

class User4 extends StatelessWidget {
  const User4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text('정보', style: const TextStyle(
          color: Colors.black54,
          fontSize: 15,
          fontWeight: FontWeight.bold,)),
      ),
      body: Center(child:Text('body')),
    );
  }
}