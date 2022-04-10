// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:backspace/pages/Notification.dart';
import 'package:backspace/pages/add-post.dart';
import 'package:backspace/pages/newsfeed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:backspace/helper/demo_values.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:sticky_float_button/sticky_float_button.dart';

import '../components/newsFeed/post-body/posts-text.dart';
import '../components/newsFeed/post-header/user-icon-name.dart';

final usersRef = FirebaseFirestore.instance
    .collection('UserData'); //database reference object

class Feed extends StatelessWidget {
  // const Feed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List timelinePosts =[];


// getFollowing() async {
//     QuerySnapshot snapshot = await followersRef
//         .document(currentUser.id)
//         .collection('userFollowing')
//         .getDocuments();
//     setState(() {
//       followingList = snapshot.documents.map((doc) => doc.documentID).toList();
//       print(followingList);
//     });
//   }

// getTimeline()async{

// List posts = [];
//    for( int i=0; i< followingList.length; i++)
// {
//     QuerySnapshot snapshot = await postsRef
//         .collections('posts/${followingList[i]}/userPosts')
//         .orderBy('timestamp', descending: true)
//         .getDocuments();
//     posts+= snapshot.data.documents.map((doc) => {'id':doc.documentID,...doc.data}).toList();
// }
//     setState(() {
//       timelinePosts = timeLinePosts + posts;
//     });
//   }

    // var postsData =  GetAllPostsContent();

    return Scaffold(
      // GetAllPostsContent();
      backgroundColor: Color(0xffDADADA),
      drawer: const MyDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('News Feed'),
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: MyDelegate(),
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const Noti()),
                    // );
                  },
                  icon: Icon(Icons.search, color: Colors.black))),
          // Icon(Icons.search, color: Colors.black)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Noti()),
                  );
                },
              ))
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      body: ListView(
        children: <Widget>[
          // for(var i=0;i<5;i++){   Post(
          //           userName: "Bill Gates",
          //           userimage: "assets/images/bill-gates.jpg",
          //           time: "5 min",
          //           //PostImg: "",
          //         ),},
            // list.
            FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                future: GetAllPostsContent(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    // Text txt = Text(
                    //   snapshot.data?.data()["about"],
                    return CircularProgressIndicator();
                  } else {
                    // final data = (snapshot.data as String);
                    //email
                    //post content
                    //post image
                    //
                    // int l = snapshot.data?.length();
                    // for (var i = 0; i < snapshot.data?.length;)
                    // snapshot.data?.forEach((element) {
                    //   Post(
                    //     userName: "Bill Gates",
                    //     userimage: "assets/images/bill-gates.jpg",
                    //     time: "5 min",
                    //     PostImg: "",
                    //   );
                    // });
                    return Text("data");
                  }


                  // return Post(
                  //   userName: "Bill Gates",
                  //   userimage: "assets/images/bill-gates.jpg",
                  //   time: "5 min",
                  //   PostImg: "",
                  // );
                }
          // }
                //   Post(
                //     userName: "Bill Gates",
                //     userimage: "assets/images/bill-gates.jpg",
                //     time: "5 min",
                //     //PostImg: "",
                //   ),

                //   Post(
                //     userName: "Bill Gates",
                //     userimage: "assets/images/bill-gates.jpg",
                //     time: "5 min",
                //     PostImg: "assets/images/keys.jpg",
                //   ),

                //   // AddPostForm(),
                //   // AddPost(),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPostPage()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.grey,
      ),
    );
  }
}

// final databaseRef = FirebaseFirestore.instance.collection('UserData'); //database reference object
// Future<void> getData() async {
//     // Get docs from collection reference
//     QuerySnapshot querySnapshot = await databaseRef.get();

//     // Get data from docs and convert map to List
//     final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

//     print(allData);
// }

newPage(context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Noti()),
  );
}

class Post extends StatelessWidget {
  final String userName;
  final String userimage;
  final String time;
  final String? PostImg;

  const Post(
      {required this.userName,
      required this.userimage,
      required this.time,
      this.PostImg});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 10)),
          UserIconName(
            userImage: userimage,
            username: userName,
            postTime: time,
          ),
          const PostBody(postSummary: DemoValues.postSummary),
          if (PostImg != null) Image.asset(PostImg!),
          Divider(height: 1),
          const PostFooter(),
        ],
      ),
    );
  }
}

// Display Like and Comment Post Footer Bar
class PostFooter extends StatefulWidget {
  const PostFooter({Key? key}) : super(key: key);

  @override
  _PostFooter createState() => _PostFooter();
}

class _PostFooter extends State<PostFooter> {
  @override
  Widget build(BuildContext context) {
    var x = 1;
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.thumb_up_alt_outlined),
          onPressed: () {
            // showSearch(
            //   context: context,
            //   delegate: CustomSearchDelegate(),);
            // Set State for Likes and update db.
          },
        ),
        Text(x.toString()),
        const Padding(padding: EdgeInsets.only(right: 70)),
        const Padding(padding: EdgeInsets.only(left: 70.0)),
        Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.comment),
              onPressed: () {
                // pass
              },
            )),
        const Text('Comment', style: TextStyle(fontFamily: "Poppins")),
      ],
    );
  }
}

class AddPostForm extends StatefulWidget {
  final TextEditingController postcontentController;

  final Function(File)? changeState;

  const AddPostForm({
    Key? key,
    this.changeState,
    required this.postcontentController,
  }) : super(key: key);

  @override
  AddPostFormState createState() => AddPostFormState();
}

class AddPostFormState extends State<AddPostForm> {
  final _formKey = GlobalKey<FormState>();
  File? image;

  Future handleChoosefromgallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
      widget.changeState!(imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future handleTakephoto() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
      widget.changeState!(imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
            // mainAxisSize: MainAxisSize.min, // added line
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: widget.postcontentController,
                  onTap: () {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Add Post",
                    fillColor: const Color(0xfff9f9fa),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    handleTakephoto();
                  }, //Open Camera here
                  icon: const Icon(Icons.camera_alt_outlined)),
              IconButton(
                  onPressed: handleChoosefromgallery, //Open Gallery here
                  icon: const Icon(Icons.photo)),
            ]),
      ),
    ));
  }
}

class MyDelegate extends SearchDelegate {
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null), icon: Icon(Icons.arrow_back));

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
              // query = '';
            },
            icon: Icon(Icons.clear))
      ];

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          query,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      );
  // TODO: implement buildResults
  // throw UnimplementedError();

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = [
      // 'Zeerak1',
      // 'Zeerak2',
      // 'Zeerak3',
      // 'Zeerak4',
    ];

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final sug = suggestions[index];
        return ListTile(
          title: Text(sug),
          onTap: () {
            query = sug;
            showResults(context);
          },
        );
      },
    );
    // TODO: implement buildSuggestions
    // throw UnimplementedError();
  }
}

Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
    GetAllPostsContent() async {
  var posts = await FirebaseFirestore.instance.collection("Posts").get();
  // posts.docs.forEach((element) async {
  //   // print(element);
  //   print(element["content"]);
  //   var users = await FirebaseFirestore.instance
  //       .collection("UserData")
  //       .where("email", isEqualTo: element["email"])
  //       .get();
  //   print(users.docs[0]["email"]);
  //   posts.docs[0]["username"].;
  //   // = users.docs[0]["username"];

  //   // element["username"] = "print("\n")";
  // });
  // posts.forEach((s)=>print(s));
  // var s = ref.docs;
  return posts.docs;
}

NameImage(email) async {
  var posts = await FirebaseFirestore.instance
      .collection("UserData")
      .where("email", isEqualTo: email)
      .get();
  String s = posts.docs[0]["username"];
  String d = posts.docs[0]["imageURL"];
  return [posts.docs[0]["username"], posts.docs[0]["imageURL"]];
}
