#  MovieShelf
A movie browsing app for iOS built with SwiftUI and the TMDB API.

Features
Home: hero banner (a random trending movie) and horizontal lanes: Popular, Now Playing, Upcoming, Top Rated. Each lane has a "See All" button.
See All: paginated grid (next page loads as you reach the end), sorting, tap to open details.
Movie details: full movie info, add/remove from the Watchlist.
Search: debounced text search. Below the search field there are genre capsules; tapping one shows that genre's movies in the same screen (it reuses the See All screen).
Watchlist: persisted locally with SwiftData, multi-select deletion, sorting.
Architecture
MVVM with @Observable view models (@MainActor).
Networking
TMDBEndpoints enum describes every request (path + query items), URLs are built with URLComponents.
TMDBService exposes one generic fetch<T: Decodable>(_:) (request → validate → decode) and is hidden behind APIClientProtocol, so view models never depend on the real network.
State: LoadingState<T> (idle / loading / loaded / error) drives every screen.
Persistence is isolated
SDWatchListItem is a SwiftData model storing a snapshot (id, title, poster URL, rating, release date), so the list needs no extra network calls and works offline.
WatchlistRepository wraps ModelContext. Writes (add / remove / contains) go through it, so SwiftData is imported in only a few files.
Reads use @Query in the Watchlist screen (automatic UI updates).
The repository reaches screens through a custom Environment key. Existing initializers did not have to change.
Reuse: MovieCategory (popular, now playing, upcoming, top rated, genre) drives one SeeAllViewModel / SeeAllView for all lists. SortOption holds the sorting logic once for See All and Search.
Testing
Unit tests use Swift Testing.
FakeApi is a stub of APIClientProtocol with a queue of canned responses and a log of requested endpoints.
Covered: HomePageViewModel, SeeAllViewModel (first page, pagination appends, end of list, errors, retry), MovieDetailViewModel (loading, errors, watchlist toggle), SortOption.
The watchlist toggle test uses the real repository on an in-memory SwiftData container.
Run with Cmd + U in Xcode.
Known limitations and trade-offs
Sorting works only on already loaded pages, because TMDB list endpoints return a fixed order page by page.
Poster loading in the Watchlist uses a workaround: the cell reloads AsyncImage on appear, because the first load was cancelled when the cell was re-created right after being inserted. The root cause was not tracked down.
The Watchlist stores a snapshot, so a saved poster or rating can become outdated.
The FakeApi response queue depends on request order, so tests must change if the loading order in a view model changes.
The genre list is hardcoded, not fetched from TMDB.
Getting started
Requirements: Xcode 18 or later (uses Swift Testing and @Entry). Minimum iOS version: fill in your deployment target.
Clone the repository.
Create a TMDB account and copy your API Read Access Token (v4) from the API settings page.
Copy Secrets.example.xcconfig to Secrets.xcconfig and put your token in it. Secrets.xcconfig is ignored by git.
Open MovieShelf.xcodeproj and run.
Roadmap
Fetch genres from TMDB.
Load Home lanes in parallel.
Put the repository behind a protocol and test it in isolation.
Attribution
This product uses the TMDB API but is not endorsed or certified by TMDB.


