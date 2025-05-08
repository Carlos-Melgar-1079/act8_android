import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:act_8_android/helper/Colorsys.dart';
import 'package:act_8_android/models/Post.dart';
// ignore: depend_on_referenced_packages

class SinglePost extends StatelessWidget {
  final Post? post;
  final String? image;

  const SinglePost({Key? key, this.post, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 70,
                bottom: 20,
                right: 20,
                left: 20,
              ),
              height: height / 2,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(image!))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          width: 30.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.black.withOpacity(0.2)),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            maxRadius: 25,
                            backgroundImage:
                                AssetImage(post!.user!.profilePicture),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            post!.user!.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            width: 32.0,
                            height: 32.0,
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.grey.shade600.withOpacity(0.1)),
                            child: Center(
                                child: Image.network(
                                    'https://retodiario.com/wp-content/uploads/2022/02/shutterstock_144112840.jpg')),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.network(
                          'https://retodiario.com/wp-content/uploads/2022/02/shutterstock_144112840.jpg'),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Kabul, Afghanistan",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colorsys.grey),
                      )
                    ],
                  ),
                  makeRelatedPhotos(post!)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget makeRelatedPhotos(Post post) {
    var MasonryGridView;
    return MasonryGridView.count(
      crossAxisCount: 4,
      itemCount: post.relatedPhotos!.length,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(post.relatedPhotos![index])),
            color: Colors.green),
      ),
      // staggeredTileBuilder: (int index) => StaggeredTile.count(2, index.isEven ? 3 : 2),
    );
  }
}
