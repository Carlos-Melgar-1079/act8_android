import 'package:flutter/material.dart';
import 'package:act_8_android/data/Sample.dart';
import 'package:act_8_android/helper/Colorsys.dart';
import 'package:act_8_android/models/Post.dart';
import 'package:act_8_android/pages/SinglePost.dart';
import 'package:act_8_android/pages/SingleUser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorsys.lightGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colorsys.lightGrey,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: Colorsys.darkGray,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildSearchBox(),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "For you",
                    style: TextStyle(
                        color: Colorsys.darkGray,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  _buildRecommendationTab(),
                  const SizedBox(height: 30),
                  _buildPost(Sample.postOne),
                  _buildPost(Sample.postTwo),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          Text(
            "Best place to\nFind awesome photos",
            style: TextStyle(
                fontSize: 22,
                color: Colorsys.darkGray,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Container(
            height: 50,
            padding:
                const EdgeInsets.only(left: 20, right: 3, top: 3, bottom: 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Search for photo",
                        hintStyle: TextStyle(color: Colorsys.grey),
                        border: InputBorder.none),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  height: double.infinity,
                  minWidth: 50,
                  elevation: 0,
                  color: Colorsys.orange,
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRecommendationTab() {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colorsys.lightGrey))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Recommend",
                style: TextStyle(
                    color: Colorsys.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Container(
                width: 50,
                padding: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colorsys.orange, width: 3))),
              )
            ],
          ),
          const SizedBox(width: 20),
          Text(
            "Likes",
            style: TextStyle(
                color: Colorsys.grey,
                fontWeight: FontWeight.w500,
                fontSize: 15),
          )
        ],
      ),
    );
  }

  Widget _buildPost(Post post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: <Widget>[
          _buildPostHeader(post),
          _buildPostImages(post),
        ],
      ),
    );
  }

  Widget _buildPostHeader(Post post) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleUser(user: post.user)));
      },
      child: Row(
        children: <Widget>[
          Hero(
            transitionOnUserGestures: true,
            tag: post.user!.username,
            child: CircleAvatar(
              maxRadius: 28,
              backgroundImage: NetworkImage(post.user!.profilePicture),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  post.user!.name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      post.location,
                      style: TextStyle(fontSize: 13, color: Colorsys.grey),
                    ),
                    Text(
                      post.dateAgo,
                      style: TextStyle(fontSize: 13, color: Colorsys.grey),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPostImages(Post post) {
    return Container(
      height: 300,
      padding: const EdgeInsets.only(top: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: post.photos.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SinglePost(
                            post: post,
                            image: post.photos[index],
                          )));
            },
            child: AspectRatio(
              aspectRatio: 1.2 / 1,
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    post.photos[index],
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child:
                            const Icon(Icons.broken_image, color: Colors.grey),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
