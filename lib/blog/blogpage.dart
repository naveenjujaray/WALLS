import 'package:Walls/bloc/navigation_bloc/dashboard_navigation.dart';
import 'package:Walls/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:Walls/blog/addpost.dart';
import 'package:Walls/blog/postmodel.dart';
import 'package:Walls/pages/widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:Walls/blog/postview.dart';
import 'package:timeago/timeago.dart' as timeago;

class BlogPage extends StatefulWidget with NavigationStates,DashboardStates{
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "posts";
  List<Post> postsList = <Post>[];


  @override
  void initState() {
    _database.reference().child(nodeName).onChildAdded.listen(_childAdded);
    _database.reference().child(nodeName).onChildRemoved.listen(_childRemoves);
    _database.reference().child(nodeName).onChildChanged.listen(_childChanged);


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.black87,
        child: Column(
          children: <Widget>[
            Visibility(
              visible: postsList.isEmpty,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),

            Visibility(
              visible: postsList.isNotEmpty,
              child: Flexible(
                  child: FirebaseAnimatedList(
                      query: _database.reference().child('posts'),
                      itemBuilder: (_, DataSnapshot snap, Animation<double> animation, int index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.black,
                            child: ListTile(
                              title: ListTile(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PostView(postsList[index])));
                                },
                                title: Text(
                                  postsList[index].title,
                                  style: TextStyle(
                                      color: Colors.white,fontSize: 22.0, fontWeight: FontWeight.bold),
                                ),
                                trailing: Text(
                                  timeago.format(DateTime.fromMillisecondsSinceEpoch(postsList[index].date)),
                                  style: TextStyle(fontSize: 14.0, color: Colors.grey),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(bottom: 14.0),
                                child: Text(postsList[index].body, style: TextStyle(color: Colors.white,fontSize: 18.0),),
                              ),
                            ),
                          ),
                        );
                      })),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPost()));
        },
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        backgroundColor: Colors.blueAccent,
        tooltip: "add a post",
      ),
    );
  }

  _childAdded(Event event) {
    setState(() {
      postsList.add(Post.fromSnapshot(event.snapshot));
    });
  }

  void _childRemoves(Event event) {
    var deletedPost = postsList.singleWhere((post){
      return post.key == event.snapshot.key;
    });

    setState(() {
      postsList.removeAt(postsList.indexOf(deletedPost));
    });
  }

  void _childChanged(Event event) {
    var changedPost = postsList.singleWhere((post){
      return post.key == event.snapshot.key;
    });

    setState(() {
      postsList[postsList.indexOf(changedPost)] = Post.fromSnapshot(event.snapshot);
    });
  }
}