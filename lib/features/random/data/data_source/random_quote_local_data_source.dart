import 'dart:convert';

import 'package:clean_architecture/core/error/exceptions.dart';
import 'package:clean_architecture/core/utils/app_strings.dart';
import 'package:clean_architecture/features/random/data/models/quote_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class RandomQuoteLocalDataSource{
  Future<QuoteModel> getLastRandomQuote();

  Future<void> cacheQuote(QuoteModel quoteModel);

}

class RandomQuoteLocalDataSourceImpl implements RandomQuoteLocalDataSource{

  final SharedPreferences sharedPreferences;

  RandomQuoteLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<QuoteModel> getLastRandomQuote() {
    final jsonString = sharedPreferences.getString(AppStrings.cachedKey) ;
    if(jsonString != null){
      final cachedRandomQuote = Future.value(QuoteModel.fromJson(json.decode(jsonString)));
      return cachedRandomQuote;
    }else{
      throw CacheExceptions();
    }
  }

  @override
  Future<void> cacheQuote(QuoteModel quoteModel) {
   return sharedPreferences.setString(
       AppStrings.cachedKey,
       json.encode(quoteModel));
  }

}