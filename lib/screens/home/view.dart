import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_gpt/screens/home/dio_helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List chat = [];

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff343541),
      appBar: AppBar(
          title: Text("Chat GPT"),
          backgroundColor: Color(0xff343541),
          centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(physics: BouncingScrollPhysics(),
              padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
              itemCount: chat.length,
              itemBuilder: (context, index) {
                if (index % 2 == 0) {
                  return Padding(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 10),
                    child: ListTile(
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: Text(
                        chat[index],
                      ),
                      leading: Icon(
                        Icons.account_circle,
                        size: 40,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff444654)),
                    child: ListTile(
                        title: AnimatedTextKit(
                            repeatForever: false,
                            totalRepeatCount: 1,
                            animatedTexts: [TyperAnimatedText(chat[index])]),
                        leading: Icon(
                          Icons.ac_unit,
                          size: 40,
                        )),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.all(12),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff444654)),
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: textController,
                      decoration: InputDecoration.collapsed(
                        hintText: "type here",
                      ),
                    ),
                  )),
                  IconButton(
                      onPressed: () {
                        getChat();
                        textController.clear();
                      },
                      icon: Icon(Icons.send))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  getChat() {
    if (textController.text.isNotEmpty) {
      setState(() {
        chat.add(textController.text);
      });
      DioHelper.postData(url: "completions", data: {
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "user", "content": "${textController.text}"}
        ]
      }).then((value) {
        if (value.statusCode == 200) {
          setState(() {
            chat.add(value.data["choices"][0]["message"]["content"]);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(value.statusMessage.toString())));
        }
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please type Message")));
    }
  }
}
