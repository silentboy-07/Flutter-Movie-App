

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp/Services/services.dart';
import 'package:moviesapp/Model/model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> nowShowing;
  late Future<List<Movie>> upComing;
  late Future<List<Movie>> popularMovies;
  late Future<List<Movie>> topRated;

  @override
  void initState() {
    super.initState();
    nowShowing = APIservice().getNowShowing();
    upComing = APIservice().getUpComing();
    popularMovies = APIservice().getPopular();
    topRated = APIservice().gettopRated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Movie App",
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        leading: const Icon(Icons.menu, color: Color(0xFF0F172A)),
        actions: const [
          Icon(Icons.search_rounded, color: Color(0xFF0F172A)),
          SizedBox(width: 12),
          Icon(Icons.notifications, color: Color(0xFF0F172A)),
          SizedBox(width: 12),
        ],
      ),

 
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF9FAFB), Color(0xFFF1F5F9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle("Now Showing"),
                const SizedBox(height: 12),
                _movieCarousel(nowShowing),

                const SizedBox(height: 28),
                _sectionTitle("Up Coming Movies"),
                _horizontalMovieList(upComing),

                const SizedBox(height: 28),
                _sectionTitle("Popular Movies"),
                _horizontalMovieList(popularMovies),

                const SizedBox(height: 28),
                _sectionTitle("Top Rated Movies"),
                _horizontalMovieList(topRated),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _sectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 22,
          decoration: BoxDecoration(
            color: const Color(0xFF475569),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }


  Widget _movieCarousel(Future<List<Movie>> future) {
    return FutureBuilder<List<Movie>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final movies = snapshot.data!;

        return CarouselSlider.builder(
          itemCount: movies.length,
          itemBuilder: (context, index, _) {
            return _movieCard(movies[index]);
          },
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 1.7,
            autoPlayAnimationDuration: const Duration(seconds: 5),
          ),
        );
      },
    );
  }


  Widget _horizontalMovieList(Future<List<Movie>> future) {
    return SizedBox(
      height: 250,
      child: FutureBuilder<List<Movie>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final movies = snapshot.data!;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return _movieCard(movies[index], width: 180);
            },
          );
        },
      ),
    );
  }


  Widget _movieCard(Movie movie, {double width = double.infinity}) {
    final imagePath = movie.backDropPath ?? movie.posterPath;

    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: imagePath != null
            ? DecorationImage(
                image: NetworkImage(
                  "https://image.tmdb.org/t/p/original$imagePath",
                ),
                fit: BoxFit.cover,
              )
            : null,
        color: Colors.grey.shade300,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
       
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

      
          Positioned(
            bottom: 12,
            left: 10,
            right: 10,
            child: Text(
              movie.title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
