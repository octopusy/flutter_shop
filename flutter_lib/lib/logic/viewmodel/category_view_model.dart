import 'package:flutter/material.dart';
import 'package:flutter_lib/model/category.dart';

/**
 *精选推荐
    商务文具
    家居生活
    数码家电
    工艺收藏
    妈咪宝贝
    包装材料
    食品保健
    箱包皮具
    户外运动
    汽车周边


 */
class CategoryViewModel {
  List<Category> categorysItems;

  CategoryViewModel({this.categorysItems});

  getCategory() => <Category>[
        Category(
          image:
              "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          name: "精选推荐",
          categories: getSubCategory(),
        ),
        Category(
          image:
              "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          name: "商务文具",
          categories: getSubCategory1(),
        ),
        Category(
          image:
              "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          name: "家居生活",
          categories: getSubCategory(),
        ),
        Category(
          image:
              "https://gd2.alicdn.com/imgextra/i1/842112630/TB2Su1sxkKWBuNjy1zjXXcOypXa_!!842112630.jpg",
          name: "数码家电",
          categories: getSubCategory1(),
        ),
        Category(
          image:
              "https://mosaic01.ztat.net/vgs/media/packshot/pdp-zoom/N1/94/4E/00/4G/11/N1944E004-G11@10.jpg",
          name: "工艺收藏",
          categories: getSubCategory(),
        ),
        Category(
          image:
              "https://mosaic01.ztat.net/vgs/media/pdp-gallery/DI/12/2G/0H/5K/11/DI122G0H5-K11@10.jpg",
          name: "妈咪宝贝",
          categories: getSubCategory1(),
        ),
        Category(
          image:
              "https://mosaic02.ztat.net/vgs/media/packshot/pdp-zoom/YO/15/2M/00/6Q/11/YO152M006-Q11@6.jpg",
          name: "包装材料",
          categories: getSubCategory(),
        ),
        Category(
          image:
              "https://mosaic01.ztat.net/vgs/media/pdp-zoom/VE/12/1C/1B/RQ/11/VE121C1BR-Q11@15.jpg",
          name: "食品保健",
          categories: getSubCategory1(),
        ),
        Category(
          image:
              "https://mosaic01.ztat.net/vgs/media/pdp-zoom/ON/32/1B/0B/JG/11/ON321B0BJ-G11@8.jpg",
          name: "箱包皮具",
          categories: getSubCategory(),
        ),
        Category(
          image:
              "https://mosaic01.ztat.net/vgs/media/pdp-zoom/M6/61/1B/02/9A/11/M6611B029-A11@13.jpg",
          name: "户外运动",
          categories: getSubCategory1(),
        ),
      ];

  getSubCategory() => <Category>[
        Category(
            image:
                "https://mosaic02.ztat.net/vgs/media/pdp-zoom/LE/22/1D/02/2A/12/LE221D022-A12@16.1.jpg",
            name: "THE PERFECT"),
        Category(
          image:
              "https://mosaic02.ztat.net/vgs/media/catalog-lg/AD/58/1D/00/9Q/12/AD581D009-Q12@13.jpg",
          name: "AQUALETTE",
        ),
        Category(
          image:
              "https://mosaic01.ztat.net/vgs/media/pdp-zoom/PY/52/2D/01/FG/11/PY522D01F-G11@8.jpg",
          name: "ROBI CHECK",
        ),
        Category(
          image:
              "https://mosaic01.ztat.net/vgs/media/pdp-zoom/AD/12/2S/07/QN/11/AD122S07Q-N11@8.jpg",
          name: "TREF OVER HOOD",
        ),
        Category(
          image:
              "https://mosaic01.ztat.net/vgs/media/packshot/pdp-zoom/N1/94/4E/00/4G/11/N1944E004-G11@10.jpg",
          name: "BACKPACK VILLAIN 4",
        ),
        Category(
          image:
              "https://mosaic01.ztat.net/vgs/media/pdp-gallery/DI/12/2G/0H/5K/11/DI122G0H5-K11@10.jpg",
          name: "THYTAN",
        ),
        Category(
          image:
              "https://mosaic02.ztat.net/vgs/media/packshot/pdp-zoom/YO/15/2M/00/6Q/11/YO152M006-Q11@6.jpg",
          name: "Watch",
        ),
        Category(
          image:
              "https://mosaic01.ztat.net/vgs/media/pdp-zoom/VE/12/1C/1B/RQ/11/VE121C1BR-Q11@15.jpg",
          name: "VMKANA",
        ),
        Category(
          image:
              "https://mosaic01.ztat.net/vgs/media/pdp-zoom/ON/32/1B/0B/JG/11/ON321B0BJ-G11@8.jpg",
          name: "ONLTHAI FRILL",
        ),
        Category(
          image:
              "https://mosaic01.ztat.net/vgs/media/pdp-zoom/M6/61/1B/02/9A/11/M6611B029-A11@13.jpg",
          name: "HIGH HEELS",
        ),
      ];

  getSubCategory1() => <Category>[
    Category(
        image:
        "https://gd3.alicdn.com/imgextra/i3/2873137436/TB2R7juDeySBuNjy1zdXXXPxFXa_!!2873137436.jpg",
        name: "THE PERFECT"),
    Category(
      image:
      "https://gd3.alicdn.com/imgextra/i3/2873137436/TB2R7juDeySBuNjy1zdXXXPxFXa_!!2873137436.jpg",
      name: "AQUALETTE",
    ),
    Category(
      image:
      "https://mosaic01.ztat.net/vgs/media/pdp-zoom/PY/52/2D/01/FG/11/PY522D01F-G11@8.jpg",
      name: "ROBI CHECK",
    ),
    Category(
      image:
      "https://gd3.alicdn.com/imgextra/i3/2873137436/TB2R7juDeySBuNjy1zdXXXPxFXa_!!2873137436.jpg",
      name: "TREF OVER HOOD",
    ),
    Category(
      image:
      "https://mosaic01.ztat.net/vgs/media/packshot/pdp-zoom/N1/94/4E/00/4G/11/N1944E004-G11@10.jpg",
      name: "BACKPACK VILLAIN 4",
    ),
    Category(
      image:
      "https://mosaic01.ztat.net/vgs/media/pdp-gallery/DI/12/2G/0H/5K/11/DI122G0H5-K11@10.jpg",
      name: "THYTAN",
    ),
    Category(
      image:
      "https://mosaic02.ztat.net/vgs/media/packshot/pdp-zoom/YO/15/2M/00/6Q/11/YO152M006-Q11@6.jpg",
      name: "Watch",
    ),
    Category(
      image:
      "https://mosaic01.ztat.net/vgs/media/pdp-zoom/VE/12/1C/1B/RQ/11/VE121C1BR-Q11@15.jpg",
      name: "VMKANA",
    ),
    Category(
      image:
      "https://mosaic01.ztat.net/vgs/media/pdp-zoom/ON/32/1B/0B/JG/11/ON321B0BJ-G11@8.jpg",
      name: "ONLTHAI FRILL",
    ),
    Category(
      image:
      "https://mosaic01.ztat.net/vgs/media/pdp-zoom/M6/61/1B/02/9A/11/M6611B029-A11@13.jpg",
      name: "HIGH HEELS",
    ),
  ];
}
