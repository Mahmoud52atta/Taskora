import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/app_images.dart';
import 'package:to_do_app/core/utils/font_styles.dart';

class ItemTask extends StatelessWidget {
  const ItemTask({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.9,
      child: Row(
        children: [
          Expanded(
            child: Image.asset(
              Assets.imagesImage2,
              scale: 3.5,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.42,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        'Grocery Shopping',
                        style: FontStyles.fontStyleBold24(context),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: const Color(0xffFFE4F2),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        'Waiting',
                        style: FontStyles.fontStyleMedium12(context)
                            .copyWith(color: const Color(0xffFF7D53)),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.01,
                    ),
                    Image.asset(
                      Assets.imagesFrame5,
                      scale: 3.5,
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.42,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    'This application is designed for s has been tahtnf ajscfakgcvdvcajdvhcajhvclajhdvchajsvjasvcjhdvcadvcjdvcjav',
                    style: FontStyles.fontStyleRegular14(context),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.42,
                        child: Row(
                          children: [
                            Image.asset(
                              Assets.imagesFlage,
                              scale: 5.5,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Medium',
                              style: FontStyles.fontStyleMedium12(context)
                                  .copyWith(
                                      color: const Color(
                                        0xff5F33E1,
                                      ),
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),

                    // SizedBox(
                    //   width: MediaQuery.sizeOf(context).width * 0.31,
                    // ),
                    Text(
                      '30/12/2022',
                      style: FontStyles.fontStyleRegular14(context),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
