import 'package:Walls/blog/editpost.dart';
import 'package:Walls/blog/postmodel.dart';
import 'package:Walls/pages/homepage.dart';
import 'package:flutter/material.dart';
import '../blog/postservice.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostView extends StatefulWidget {
  final Post post;

  PostView(this.post);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    timeago.format(DateTime.fromMillisecondsSinceEpoch(widget.post.date)),
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                ),),
              IconButton(icon: Icon(Icons.delete),
                onPressed: (){
                  PostService postService = PostService(widget.post.toMap());
                  postService.deletePost();
                  Navigator.pop(context);

                },),
              IconButton(icon: Icon(Icons.edit),
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditPost(widget.post)));
                },),
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.post.body),
          ),
        ],
      ),
    );
  }
}