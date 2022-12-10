import 'package:clean_architecture/features/random/domain/entities/quote.dart';

class QuoteModel extends Quote{
  const QuoteModel(
      {
        required String author,
        required String id,
        required String content,
        required String permalink}
      )  : super(
    author: author, id: id, content: content, permalink: permalink,);

     factory QuoteModel.fromJson( Map<String,dynamic> json) => QuoteModel(
      author: json['author'],
      id: json['id'],
      content: json['content'],
      permalink: json['permalink'],
  );

   Map<String , dynamic> toMap() => {
     'author': author,
    'content': content,
     'permalink':permalink,
     'id':id,
   };




}