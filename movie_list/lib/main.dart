import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}

@immutable
class Film {
  final String id;
  final String title;
  final String description;
  final bool isFavourite;

  const Film({required this.id, required this.title, required this.description, required this.isFavourite});

  Film copy({required bool isFavourite}) => Film(
        id: id,
        title: title,
        description: description,
        isFavourite: isFavourite,
      );
  @override
  String toString() => 'Film (id:$id), '
      'title: $title, '
      'description: $description, '
      'isFavourite: $isFavourite, ';

  @override
  bool operator ==(covariant Film other) => id == other.id && isFavourite == other.isFavourite;
  @override
  int get hashCode => Object.hashAll([id, isFavourite]);
}

const allFilms = [
  Film(
    id: '1',
    title: 'Inception',
    description: 'A thief who enters the dreams of others to steal their secrets.',
    isFavourite: true,
  ),
  Film(
    id: '2',
    title: 'The Shawshank Redemption',
    description: 'Two imprisoned men bond over several years, finding solace and eventual redemption through acts of common decency.',
    isFavourite: true,
  ),
  Film(
    id: '3',
    title: 'The Dark Knight',
    description:
        'When the menace known as The Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
    isFavourite: true,
  ),
  Film(
    id: '4',
    title: 'Pulp Fiction',
    description:
        'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.',
    isFavourite: true,
  ),
  Film(
    id: '5',
    title: 'Forrest Gump',
    description:
        'The presidencies of Kennedy and Johnson, the Vietnam War, the Watergate scandal, and other historical events unfold from the perspective of an Alabama man with an IQ of 75.',
    isFavourite: true,
  ),
  Film(
    id: '6',
    title: 'The Matrix',
    description: 'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.',
    isFavourite: true,
  ),
  Film(
    id: '7',
    title: 'The Godfather',
    description: 'An organized crime dynasty\'s aging patriarch transfers control of his clandestine empire to his reluctant son.',
    isFavourite: true,
  ),
  Film(
    id: '8',
    title: 'Schindler\'s List',
    description:
        'In German-occupied Poland during World War II, industrialist Oskar Schindler gradually becomes concerned for his Jewish workforce after witnessing their persecution by the Nazis.',
    isFavourite: true,
  ),
  Film(
    id: '9',
    title: 'The Lord of the Rings: The Return of the King',
    description:
        'Gandalf and Aragorn lead the World of Men against Sauron\'s army to draw his gaze from Frodo and Sam as they approach Mount Doom with the One Ring.',
    isFavourite: true,
  ),
  Film(
    id: '10',
    title: 'Fight Club',
    description: 'An insomniac office worker and a devil-may-care soap maker form an underground fight club that evolves into something much, much more.',
    isFavourite: true,
  ),
  Film(
    id: '11',
    title: 'Goodfellas',
    description:
        'The story of Henry Hill and his life in the mob, covering his relationship with his wife Karen Hill and his mob partners Jimmy Conway and Tommy DeVito in the Italian-American crime syndicate.',
    isFavourite: true,
  ),
  Film(
    id: '12',
    title: 'The Silence of the Lambs',
    description:
        'A young FBI cadet must receive the help of an incarcerated and manipulative cannibal killer to help catch another serial killer, a madman who skins his victims.',
    isFavourite: true,
  ),
  Film(
    id: '13',
    title: 'The Usual Suspects',
    description:
        'A sole survivor tells of the twisty events leading up to a horrific gun battle on a boat, which began when five criminals met at a seemingly random police lineup.',
    isFavourite: true,
  ),
  Film(
    id: '14',
    title: 'The Green Mile',
    description:
        'The lives of guards on Death Row are affected by one of their charges: a black man accused of child murder and rape, yet who has a mysterious gift.',
    isFavourite: true,
  ),
  Film(
    id: '15',
    title: 'The Departed',
    description: 'An undercover cop and a mole in the police attempt to identify each other while infiltrating an Irish gang in South Boston.',
    isFavourite: true,
  ),
  Film(
    id: '16',
    title: 'Gladiator',
    description: 'A former Roman General sets out to exact vengeance against the corrupt emperor who murdered his family and sent him into slavery.',
    isFavourite: true,
  ),
  Film(
    id: '17',
    title: 'Saving Private Ryan',
    description:
        'Following the Normandy Landings, a group of U.S. soldiers go behind enemy lines to retrieve a paratrooper whose brothers have been killed in action.',
    isFavourite: true,
  ),
  Film(
    id: '18',
    title: 'The Prestige',
    description:
        'After a tragic accident, two stage magicians engage in a battle to create the ultimate illusion while sacrificing everything they have to outwit each other.',
    isFavourite: true,
  ),
  Film(
    id: '19',
    title: 'The Sixth Sense',
    description: 'A boy who communicates with spirits seeks the help of a disheartened child psychologist.',
    isFavourite: true,
  ),
  Film(
    id: '20',
    title: 'The Avengers',
    description:
        'Earth\'s mightiest heroes must come together and learn to fight as a team if they are to stop the mischievous Loki and his alien army from enslaving humanity.',
    isFavourite: true,
  ),
];

class FilmsNotifier extends StateNotifier<List<Film>> {
  FilmsNotifier() : super(allFilms);
  void update(Film film, bool isFavourite) {
    state = state
        .map(
          (thisFilm) => thisFilm.id == film.id ? thisFilm.copy(isFavourite: isFavourite) : thisFilm,
        )
        .toList();
  }
}

enum FavouriteStatus {
  all,
  favourite,
  notFavourite,
}

final favouriteStatusProvider = StateProvider<FavouriteStatus>((_) => FavouriteStatus.all);

final allFilmsProvider = StateNotifierProvider<FilmsNotifier, List<Film>>((_) => FilmsNotifier());

final favouriteFilmProvider = Provider<Iterable<Film>>(
  (ref) => ref
      .watch(
        allFilmsProvider,
      )
      .where((film) => film.isFavourite),
);

final notFavouriteFilmProvider = Provider<Iterable<Film>>(
  (ref) => ref
      .watch(
        allFilmsProvider,
      )
      .where((film) => !film.isFavourite),
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Films'),
      ),
      body: Column(
        children: [
          const FilterWidget(),
          Consumer(
            builder: (context, ref, child) {
              final filter = ref.watch(favouriteStatusProvider);
              switch (filter) {
                case FavouriteStatus.all:
                  return FilmsList(
                    provider: allFilmsProvider,
                  );
                case FavouriteStatus.favourite:
                  return FilmsList(
                    provider: favouriteFilmProvider,
                  );
                case FavouriteStatus.notFavourite:
                  return FilmsList(
                    provider: notFavouriteFilmProvider,
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}

class FilmsList extends ConsumerWidget {
  final AlwaysAliveProviderBase<Iterable<Film>> provider;
  const FilmsList({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final films = ref.watch(provider);
    return Expanded(
      child: ListView.builder(
        itemCount: films.length,
        itemBuilder: (context, index) {
          final film = films.elementAt(index);
          final favouriteIcon = film.isFavourite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border);
          return ListTile(
            title: Text(film.title),
            subtitle: Text(film.description),
            trailing: IconButton(
              icon: favouriteIcon,
              onPressed: () {
                final isFavourite = !film.isFavourite;
                ref.read(allFilmsProvider.notifier).update(film, isFavourite);
              },
            ),
          );
        },
      ),
    );
  }
}

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return DropdownButton(
        value: ref.watch(favouriteStatusProvider),
        items: FavouriteStatus.values
            .map(
              (fs) => DropdownMenuItem(
                value: fs,
                child: Text(
                  fs.toString().split('.').last,
                ),
              ),
            )
            .toList(),
        onChanged: (fs) {
          ref.read(favouriteStatusProvider.notifier).state = fs!;
        },
      );
    });
  }
}
