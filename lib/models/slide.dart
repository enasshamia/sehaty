import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;

  final String description;

  Slide({
    @required this.imageUrl,

    @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/3.png',
 
    description: 'إذا تم تشخيص إصابتك بالسرطان ، فإن العثور على طبيب ، وعيادة علاجية لرعاية مرضى السرطان يعد خطوة مهمة للحصول على أفضل علاج ممكن.',
  ),
  Slide(
    imageUrl: 'assets/2.png',

    description: 
    'سيكون لديك العديد من الأشياء التي يجب مراعاتها عند اختيار الطبيب. من المهم أن تشعر بالراحة مع الاختصاصي الذي تختاره لأنك ستعمل عن كثب مع ذلك الشخص لاتخاذ قرارات بشأن علاج السرطان.',
  ),
  Slide(
    imageUrl: 'assets/1.png',

    description: '  يسهل التطبيق اختيار الطبيب المناسب وحجز موعد معه لزيارة عيادة الطبيب وتشخيص الحالة المرضية.',
  ),
];