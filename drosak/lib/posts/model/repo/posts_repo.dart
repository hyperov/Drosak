import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/firestore_names.dart';
import '../entity/post.dart';

class PostsRepo {
  Future<QuerySnapshot<Post>> getPosts(String teacherId) async {
    return FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .doc(teacherId)
        .collection(FireStoreNames.collectionTeacherPosts)
        .withConverter<Post>(
          fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        )
        .orderBy("date", descending: true)
        .get();
  }

  Future addOrEditPost(Post post, String teacherId) async {
    if (post.id == null) {
      return await FirebaseFirestore.instance
          .collection(FireStoreNames.collectionTeachers)
          .doc(teacherId)
          .collection(FireStoreNames.collectionTeacherPosts)
          .add(post.toJson());
    } else {
      return await FirebaseFirestore.instance
          .collection(FireStoreNames.collectionTeachers)
          .doc(teacherId)
          .collection(FireStoreNames.collectionTeacherPosts)
          .doc(post.id)
          .update(post.toJson());
    }
  }

  Future deletePost(String postId, String teacherId) async {
    return await FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .doc(teacherId)
        .collection(FireStoreNames.collectionTeacherPosts)
        .doc(postId)
        .delete();
  }
}
