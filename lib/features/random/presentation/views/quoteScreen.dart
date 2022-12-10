
// ignore_for_file: file_names

import 'package:clean_architecture/core/utils/app_colors.dart';
import 'package:clean_architecture/core/widgets/error_design.dart';
import 'package:clean_architecture/features/random/presentation/cubit/states.dart';
import 'package:clean_architecture/features/random/presentation/widgets/quote_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_strings.dart';
import '../cubit/cubit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class QuoteScreen extends StatefulWidget {
  const QuoteScreen({Key? key}) : super(key: key);

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();


}

class _QuoteScreenState extends State<QuoteScreen> {
  getRandomQuote()=> BlocProvider.of<RandomQuoteCubit>(context).getRandomQuote();
  @override
  initState(){
    super.initState();
    getRandomQuote();
  }
  Widget designQuote() {
    return  BlocBuilder<RandomQuoteCubit,RandomQuoteStates>(
      builder: (BuildContext context, state) {
        if(state is LoadingRandomQuoteStates){
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primary,
            ),
          );
        }
        else if(state is ErrorRandomQuoteStates){
          return  ErrorDesign(
              onPressed : getRandomQuote(),
          );
        }
        else if(state is SuccessRandomQuoteStates){
          return Column(
            children:  [
              QuoteContent(
                quote: state.quote,
              ),
              InkWell(
                onTap: (){
                  getRandomQuote();
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsetsDirectional.symmetric(vertical: 15),
                    padding: const EdgeInsetsDirectional.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: (){},
                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        else {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primary,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
        onRefresh: (){
          return getRandomQuote();
        },
        child: Scaffold(
          appBar: AppBar(
            title:  const Text(AppStrings.appName),
          ),
          body: designQuote(),
        ));
  }
}
