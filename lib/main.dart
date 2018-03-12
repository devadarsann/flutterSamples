import 'package:flutter/material.dart';
const String _name="Devadarsan";
void main(){
  runApp(new FriendlyChatApp());
}

class FriendlyChatApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(title: "FriendlyChatApp",home: new ChatScreen(),);
  }

}

class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textEditingController = new TextEditingController();
final List<ChatMessage> _messages=<ChatMessage>[];


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(appBar: new AppBar(
      title: new Text("Friendly Chat"),
      ),
    body: new Column(
      children: <Widget>[
        new Flexible(
          child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_,int index)=>_messages[index],
            itemCount: _messages.length,
          ),
        ),
        new Divider(height:1.0,),
        new Container(
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor
          ),
          child: _buildTextComposer(),
        )
      ],
    ),);
  }

  Widget _buildTextComposer() {
    return new IconTheme(data: new IconThemeData(
        color: Theme
            .of(context)
            .accentColor
    ), child: new Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        children: <Widget>[
          new Flexible(child: new TextField(
            controller: _textEditingController,
            onSubmitted: _handleSubmitted,
            decoration: new InputDecoration.collapsed(
                hintText: "Send message"),),),
          new Container(
            margin: new EdgeInsets.symmetric(horizontal: 4.0),
            child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textEditingController.text)),
          )
        ],
      ),
    ));
  }


  void _handleSubmitted(String text){
    _textEditingController.clear();
    ChatMessage message=new ChatMessage(
      text: text,
      animationController: new AnimationController(
        duration: new Duration(microseconds: 700),
        vsync: this
      ),);
    setState((){
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  @override
  void dispose() {
    for(ChatMessage message in _messages){
      message.animationController.dispose();
    }
    super.dispose();
  }

}

class ChatMessage extends StatelessWidget{

  final String text;
  final AnimationController animationController;
  ChatMessage({this.text,this.animationController});
  
  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
          margin: const EdgeInsets.only(right: 16.0),
          child: new CircleAvatar(child: new Text(_name[0]),),
          ),
            new Expanded(
              child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                new Text(_name,style: Theme.of(context).textTheme.subhead,),
                new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(text),
                )
                ],
              ),
            )
          ],
        ),
      ),
    );


  }

}