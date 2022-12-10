import 'package:clean_architecture/features/random/data/models/quote_model.dart';
import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';

abstract class RandomQuoteRemoteDataSource{
  Future<QuoteModel> getRandomQuote();
}

class RandomQuoteRemoteDataSourceImpl implements RandomQuoteRemoteDataSource{

  ApiConsumer apiConsumer;

  RandomQuoteRemoteDataSourceImpl({
    required this.apiConsumer,
});
  @override
  Future<QuoteModel> getRandomQuote() async {
    final response = await apiConsumer.get(
      EndPoints.baseUrl,
    );
     return QuoteModel.fromJson(response);

  }

}