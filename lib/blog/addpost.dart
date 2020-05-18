import 'package:Walls/blog/PostService.dart';
import 'package:Walls/blog/postmodel.dart';
import 'package:Walls/pages/homepage.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final GlobalKey<FormState> formkey = new GlobalKey();
  Post post = Post(0, " ", " ",);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text("Add Feedback"),
        elevation: 0.0,
      ),
      body: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                      labelText: "Feedback",
                      labelStyle: TextStyle(color: Colors.blueAccent,fontSize: 25),
                      hintText: 'Title',
                      hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white.withOpacity(0.2),
                    filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(20),
                          ),
                          borderSide: BorderSide(
                          color: Colors.lightBlueAccent
                      )),
                    border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(20),
                        ),
                        borderSide: BorderSide()
                    ),
                  ),
                  onSaved: (val) => post.title = val,
                  // ignore: missing_return
                  validator: (val){
                    if(val.isEmpty ){
                      return "title field cant be empty";
                    }else if(val.length > 40){
                      return "title cannot have more than 16 characters ";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                      labelText: "Describe your experience",
                      labelStyle: TextStyle(color: Colors.blueAccent,fontSize: 25),
                      hintText: 'Description',
                      hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white.withOpacity(0.2),
                    filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(20),
                          ),
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent
                        )),
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(20),
                          ),
                      borderSide: BorderSide()
                ),
                  ),

                  onSaved: (val) => post.body = val,
                  // ignore: missing_return
                  validator: (val){
                    if(val.isEmpty){
                      return "body field cant be empty";
                    }
                  },
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(onPressed: (){
        insertPost();
        Navigator.pop(context);
//        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      },
        child: Icon(Icons.check, color: Colors.white,),
        backgroundColor: Colors.green,
        tooltip: "add a post",),
    );
  }

  void insertPost() {
    final FormState form = formkey.currentState;
    if(form.validate()){
      form.save();
      form.reset();
      post.date = DateTime.now().millisecondsSinceEpoch;
      PostService postService = PostService(post.toMap());
      postService.addPost();
    }
  }



}