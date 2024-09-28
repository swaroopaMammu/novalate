import 'package:flutter/material.dart';

class StoryReaderScreen extends StatelessWidget {
  const StoryReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:    Text(' The Girl and the Dragon',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),
        bottom: PreferredSize(preferredSize: const Size.fromHeight(20),child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Written by swaroopa ',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16)),
        ),
      )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(width: double.infinity,
                height: 300,
          decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              border: Border.all(
                color: Colors.black,
                width: 4,
              ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(4, 4),
              ),
            ],),
                child: Image.asset('assets/images/spirited_away.jpeg', fit: BoxFit.cover)),
            Text('On a quiet evening, in a small village nestled between rolling hills, a boy named Arin discovered an old key buried under a tree in his backyard. The key was unlike any he had ever seen—ornate and shimmering with a faint, golden light. Curious, he held it up to the setting sun, wondering what it could unlock. \n That night, he dreamt of a door hidden deep within the forest, covered in ivy and forgotten by time. The next morning, with the key in his pocket and determination in his heart, Arin set off into the woods. He followed the path from his dream, winding deeper into the forest than he had ever gone before. Just as the sun began to dip below the trees, he found it—the door, exactly as he had seen it.\n On a quiet evening, in a small village nestled between rolling hills, a boy named Arin discovered an old key buried under a tree in his backyard. The key was unlike any he had ever seen—ornate and shimmering with a faint, golden light. Curious, he held it up to the setting sun, wondering what it could unlock. \n That night, he dreamt of a door hidden deep within the forest, covered in ivy and forgotten by time. The next morning, with the key in his pocket and determination in his heart, Arin set off into the woods. He followed the path from his dream, winding deeper into the forest than he had ever gone before. Just as the sun began to dip below the trees, he found it—the door, exactly as he had seen it. '
                    ,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),
                    textAlign: TextAlign.justify,
                    softWrap: true)

          ],
        ),
      ),
    );
  }
}
