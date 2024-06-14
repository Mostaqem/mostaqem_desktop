import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/home/widgets/surah_widget.dart';

import '../../shared/widgets/back_button.dart';
import '../../shared/widgets/window_bar.dart';
import '../navigation/widgets/player_widget.dart';
import 'data/reciters_data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RecitersScreen extends StatelessWidget {
  RecitersScreen({super.key});
  final List<Reciter> reciters = [
    Reciter(
        id: 19,
        name: "احمد ابن علي العجمي",
        imageURL:
            'https://www.elaosboa.com/wp-content/uploads/2023/02/elaosboa57091.jpg'),
    Reciter(
        id: 3,
        name: "عبدالرحمن السديسي",
        imageURL:
            'https://saudipedia.com/saudipedia/uploads/images/2024/02/04/thumbs/400x400/89199.jpg'),
    Reciter(
        id: 4,
        name: "ابو بكر الشاطري",
        imageURL:
            'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgnQ-YhtIuoCecErD9yfP6JjM-x-axHzEwl_WB9twwWZF6uxYYCFB_cw6El8c2C6YVTpLmYD-KHGXh6bvQE8vvqxK2iKFpMsAIy8I31QCbic07irveROCCAlnNqQwghVCAZs_5MczE8LhLy/s1600/Abo-Bakr.jpg'),
    Reciter(
        id: 5,
        name: "هاني الرفاعي",
        imageURL:
            "https://tvquran.com/uploads/authors/images/%D9%87%D8%A7%D9%86%D9%8A%20%D8%A7%D9%84%D8%B1%D9%81%D8%A7%D8%B9%D9%8A.jpg"),
    Reciter(
        id: 6,
        name: "خليل الحصري",
        imageURL:
            'https://i1.sndcdn.com/artworks-000037504497-6g5fx7-t500x500.jpg'),
    Reciter(
        id: 7,
        name: "مشاري العفاسي",
        imageURL:
            'https://misharialafasy.net/wp-content/uploads/2014/09/Untitled-3-01.jpg'),
    Reciter(
        id: 8,
        name: "محمد المنشاوي",
        imageURL:
            'https://i1.sndcdn.com/artworks-000348771846-u8dd5n-t240x240.jpg'),
    Reciter(
        id: 10,
        name: "سعود الشريم",
        imageURL:
            'https://yt3.googleusercontent.com/ONFtSRz0jZyr67_NcPTOmPZgse6WRY_LWo_avT_JTml6OuNqDQ1HOov7S1AKuvODN2cAKwTXu0A=s900-c-k-c0x00ffffff-no-rj'),
    Reciter(
        id: 11,
        name: "عبدالمحسن القاسم",
        imageURL: 'https://i.ytimg.com/vi/axi0bhmtMQs/maxresdefault.jpg'),
    Reciter(
        id: 52,
        name: "ماهر المعيقلي",
        imageURL:
            'https://mf.b37mrtl.ru/media/pics/2023.08/original/64d7ceed4236046a8c41c7e5.jpg'),
    Reciter(
        id: 1,
        name: "عبد الباسط",
        imageURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPQ0hAwXQVlDpsp6luCsLbgCWQRY9UqOkf458PUQXgnoolduTQNlhq-fJSZz1npW6lmeg&usqp=CAU"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WindowBarBox(),
          const Align(alignment: Alignment.topLeft, child: AppBackButton()),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "اختيار الشيخ",
              style: TextStyle(fontSize: 22),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                child: GridView.builder(
                  itemCount: reciters.length,
                  cacheExtent: 50,
                  gridDelegate:
                      const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200),
                  itemBuilder: (context, index) {
                    reciters.sort((a, b) => a.name
                        .toLowerCase()
                        .compareTo(b.name.toLowerCase()));
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Consumer(builder: (context, ref, child) {
                        return Card(
                            child: InkWell(
                          onTap: () async {
                            final surahID = ref.read(surahIDProvider);
                            ref.read(reciterProvider.notifier).state = (
                              name: reciters[index].name,
                              id: reciters[index].id
                            );
                            ref.read(seekIDProvider(
                                surahID: surahID,
                                reciterName: reciters[index].name,
                                reciterID: reciters[index].id));
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: 120,
                                  width: 200,
                                  imageUrl: reciters[index].imageURL),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(reciters[index].name)
                            ],
                          ),
                        ));
                      }),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
