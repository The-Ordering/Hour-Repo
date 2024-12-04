
import 'package:book_app/view/home.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Wellcoming extends StatefulWidget {
  const Wellcoming({super.key});

  @override
  State<Wellcoming> createState() => _WellcomingState();
}

class _WellcomingState extends State<Wellcoming> {
  final CarouselSliderController controller = CarouselSliderController();
  final CarouselSliderController controller2 = CarouselSliderController();

  int currentIndex  = 0 ;

  @override
  Widget build(BuildContext context) {
    double dHieght = MediaQuery.of(context).size.height;
    double dwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CarouselSlider(
            items: [
              Container(
                width: 350,
                height: 350,
                padding: EdgeInsets.all(80),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(42),
                  color: Colors.black,
                ),
                child: SizedBox(
                    child: Image.asset("assets/stickers/page1.png")),
              ),
              Container(
                width: 350,
                height: 350,
                padding: EdgeInsets.all(80),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(42),
                ),
                child: Image.asset(
                  "assets/stickers/page2.png",
                  width: 200,
                ),
              ),
              Container(
                width: 350,
                height: 350,
                padding: EdgeInsets.all(80),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(42)),
                child: Image.asset(
                  "assets/stickers/page3.png",
                  width: 200,
                ),
              ),
            ],
            carouselController: controller2,
            options: CarouselOptions(
                scrollPhysics: const NeverScrollableScrollPhysics(),
                aspectRatio: 1,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                height: dHieght * 0.4),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: CarouselSlider(
              carouselController: controller,
              items: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: dwidth,
                      child: const Text(
                        "Fuel Your Imagination, One Page at a time",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            fontFamily: "poppin"),
                      ),
                    ),
                    const SizedBox(
                      height: kDefaultFontSize,
                    ),
                    Text(
                      "Discover endless stories and immerese yoursefl in the joy of reading anytime anywhere",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black.withOpacity(0.55)),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: dwidth,
                      child: const Text(
                        "Endless Books , Endless Adventures",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            fontFamily: "poppin"),
                      ),
                    ),
                    const SizedBox(
                      height: kDefaultFontSize,
                    ),
                    Text(
                      "Turn every moment into an adventure wiith stories that inspire and entertain",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black.withOpacity(0.55)),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: dwidth,
                      child: const Text(
                        "Where Every Page Comes to Life",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            fontFamily: "poppin"),
                      ),
                    ),
                    const SizedBox(
                      height: kDefaultFontSize,
                    ),
                    Text(
                      "Dive into captivating tales and let every page take you somewhere new",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black.withOpacity(0.55)),
                    )
                  ],
                ),
              ],
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                scrollPhysics: const NeverScrollableScrollPhysics(),
                height: dHieght * 0.3,
                viewportFraction: 1,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                  color: Colors.black.withOpacity(0.2)
                ),
                margin: EdgeInsets.only(right: 20),
                height: 60,
                duration: Duration(milliseconds: 200),
                width: currentIndex !=2 ? 170 : 0,
                child: currentIndex != 2 ? Text(
                  "Skip",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.55),
                      fontWeight: FontWeight.w700,
                      fontFamily: "poppin", fontSize: 24),
                ): SizedBox(
                  width: 0,
                  height: 0,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if(currentIndex == 2 ) {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()), (route) => false,);
                    }
                    controller.nextPage(duration: const Duration(milliseconds: 500) , curve: Easing.emphasizedDecelerate);
                    controller2.nextPage(duration: const Duration(milliseconds: 800) , curve: Easing.emphasizedDecelerate);
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(10),
                  height: 60,
                  width: currentIndex != 2 ? 170: dwidth-130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    gradient: LinearGradient(colors: [Colors.black.withOpacity(0.2),Colors.black] , begin: Alignment.centerLeft , end: Alignment.centerRight)
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Next    ",
                        style: TextStyle(
                          color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: "poppin", fontSize: 24),
                      ),
                      Image(image: AssetImage("assets/icons/arrow.png") , height: 40)
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
