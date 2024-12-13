import 'package:bookia_app/core/functions/navigation.dart';
import 'package:bookia_app/core/widgets/custom_elevated_button.dart';
import 'package:bookia_app/features/home/data/models/get_arrivals_books_response/product.dart';
import 'package:bookia_app/features/home/presentation/bloc/home_event.dart';
import 'package:bookia_app/features/home/presentation/page/book_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/functions/dialogs.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_style.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class PopularBooksList extends StatefulWidget {
  const PopularBooksList({super.key});

  @override
  State<PopularBooksList> createState() => _PopularBooksListState();
}

class _PopularBooksListState extends State<PopularBooksList> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetNewArrivalsBookEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      buildWhen: (pervious, current) =>
          current is NewArrivalsBooksLoadedState ||
          current is NewArrivalsBooksLoadingState,
      listener: (context,state){
        if(state is AddCartLoadingState){
          showLoadingDialog(context);
        }else if (state is AddCartLoadedState) {
          Navigator.pop(context);
          showAppDialog(context, "Added to Cart", DialogType.success);
        }
      },
      builder: (context, state) {
        if (state is NewArrivalsBooksLoadedState) {
          var bookList = context.read<HomeBloc>().newArrivalBooks;
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Popular Books",
                      style: getFont24TextStyle(context),
                    )
                  ],
                ),
                const Gap(20),
                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bookList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 11,
                            crossAxisSpacing: 11,
                            mainAxisExtent: 280),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: GridBookItem(book: bookList[index]),
                        onTap: () {
                          pushTo(
                              context,
                              BookDetailsScreen(
                                product: bookList[index],
                              ));
                        },
                      );
                    }),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class GridBookItem extends StatelessWidget {
  const GridBookItem({super.key, required this.book});
  final Product book;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Expanded(
            child: Hero(
              tag: book.id.toString(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  book.image ?? '',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Gap(10),
          Text(
            book.name ?? '',
            style: getFont14TextStyle(context),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(10),
          Row(
            children: [
              Text(
                "${book.priceAfterDiscount?.toStringAsFixed(1)} EGP",
                style: getFont14TextStyle(context),
              ),
              const Gap(10),
              Expanded(
                  child: CustomElevatedButton(
                      radius: 4,
                      backGroundColor: AppColors.darkColor,
                      height: 30,
                      text: "Buy",
                      onPressed: () {
                        context
                            .read<HomeBloc>()
                            .add(AddCartEvent(productId: book.id ?? 0));
                      }))
            ],
          )
        ],
      ),
    );
  }
}
