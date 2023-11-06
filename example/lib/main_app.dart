import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_pip/fl_pip.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    FlPiP().status.addListener(listener);
  }

  void listener() {
    if (FlPiP().status.value == PiPStatus.enabled) {
      FlPiP().toggle(AppState.background);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    FlPiP().status.removeListener(listener);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Future.delayed(Duration.zero, () async {
      if (state == AppLifecycleState.paused) {
        await FlPiP().enableWithEngine(
          ios: const FlPiPiOSConfig(
            path: 'assets/landscape.mp4',
            packageName: null,
          ),
          android: const FlPiPAndroidConfig(
            aspectRatio: Rational.vertical(),
          ),
        );
      }
      if(state==AppLifecycleState.resumed){
        await FlPiP().disable();
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Image(
            image: AssetImage('assets/logo.png'), width: 30, height: 30),
        PiPBuilder(builder: (PiPStatus status) {
          switch (status) {
            case PiPStatus.enabled:
              return const Text('PiPStatus enabled');
            case PiPStatus.disabled:
              return builderDisabled;
            case PiPStatus.unavailable:
              return buildUnavailable;
          }
        }),
        ElevatedButton(
            onPressed: () async {
              final state = await FlPiP().isAvailable;
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: state
                        ? const Text('PiP available')
                        : const Text('PiP unavailable')));
              }
            },
            child: const Text('PiPStatus isAvailable')),
      ])));

  Widget get builderDisabled =>
      Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('PiPStatus disabled'),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              FlPiP().enable(
                ios: const FlPiPiOSConfig(
                  path: 'assets/landscape.mp4',
                  packageName: null,
                ),
                android: const FlPiPAndroidConfig(
                  aspectRatio: Rational.maxLandscape(),
                ),
              );
            },
            child: const Text('Enable PiP')),
        ElevatedButton(
            onPressed: () {
              FlPiP().enableWithEngine(
                ios: const FlPiPiOSConfig(
                  path: 'assets/landscape.mp4',
                  packageName: null,
                ),
              );
            },
            child: const Text('Enable PiP with Engine')),
      ]);

  Widget get buildUnavailable => ElevatedButton(
      onPressed: () async {
        final state = await FlPiP().isAvailable;
        if (!mounted) return;
        if (!state) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('PiP unavailable')));
        }
      },
      child: const Text('PiP unavailable',),);
}

class PiPMainApp extends StatefulWidget {
  const PiPMainApp({super.key});

  @override
  State<PiPMainApp> createState() => _PiPMainAppState();
}

class _PiPMainAppState extends State<PiPMainApp> {
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 100,
    height: 200,
    child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: CarouselSlider(
                items: imgList
                    .map(
                      (e) => Image.network(e),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 400,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                ),),
          ),
        ),
  );
}
