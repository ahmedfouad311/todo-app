// related functions to fireStore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/home/data/todo.dart';

// bt5aleni 22dar 2adef function 3ala class already mawgod
extension MyDateExtension on DateTime {
  DateTime getDateOnly() {
    return DateTime(this.year, this.month, this.day);
  }
}

CollectionReference<Todo> getTodosCollectionWithConverter() {
  return FirebaseFirestore.instance.
  collection(Todo.COLLECTION_KEY).
  withConverter<Todo>(
    fromFirestore: (snapshot, _) => Todo.fromJson(snapshot.data()!),
    toFirestore: (todoItem, _) => todoItem.toJson(),
  );
}

Future<void> addTodoToFirestore(String title, String description,
    DateTime dateTime) {
  CollectionReference<
      Todo> collectionReference = getTodosCollectionWithConverter();
  DocumentReference<Todo> documentReference = collectionReference.doc();
  //bt3ml create le object gded be id gded 3l4an law 3ayz 23ml generate le el id bta3 el doc

  Todo todoItem = Todo(id: documentReference.id,
      title: title,
      description: description,
      dateTime: dateTime
  );

  return documentReference.set(todoItem);
}

Future<void> deleteTodo(Todo item) {
  CollectionReference<
      Todo> collectionReference = getTodosCollectionWithConverter();
  DocumentReference<Todo> documentReference = collectionReference.doc(item.id);
  //law kont sebtaha fadya zai el fo2 kan ha3ml create le doc gdeda be id gded bas hna 3l4an
  // 7atet id mo3ayan fa hayro7 ygeb el doc de
  return documentReference.delete();
}

editIsDone(Todo item) {
  CollectionReference<
      Todo> collectionReference = getTodosCollectionWithConverter();
  collectionReference.doc(item.id).update(
      {'isDone': item.isDone ? false : true});
}