# CapstoneProject

ActivityX is a mood-based activity recommender.

Time spent: 240 hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User sees an app icon on the home screen and a styled launch screen.
- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.
- [x] User sees an error message when there's a networking error.
- [x] User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

The following **optional** features are implemented:

- [ ] User can tap a poster in the collection view to see a detail screen of that movie
- [ ] User can search for a movie.
- [ ] All images fade in as they are loading.
- [ ] User can view the large movie poster by tapping on a cell.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [ ] Customize the selection effect of the cell.
- [ ] Customize the navigation bar.
- [ ] Customize the UI.
- [ ] Run your app on a real device.


# Complext Feature - Content-based Filtering
### What is Content-Based Filtering? - recommender system algorithm
Content-based filtering is a type of recommender system algorithm that attempts to make recommendations based on user preferences and product features (in my case it would be activity features).

# Summary: I have 2 databases:
User Database: stores basic information about the user such as their age and what activities they have previously selected.
Activity Database:  Stores all the potential activities that could be recommended to the user. Each activity has associated features that helps in determining which activity the user would like the best

# User needs to input all the data if they want to add a new activity
Does not take into account how other users have responded to these activities. This can be addressed by implementing Collaborative Filtering, a Machine Learning algorithm.
Although there are some drawbacks to this design, the pros of this design far outweigh the fact that the user might be slightly inconvenienced because they need to provide more data and avoid implementing more complex ML algorithms. More importantly, implementing a content-based algorithm in comparison to a collaborative algorithm is better suited for this application as my model does not need any data about other users (which would be very hard to manually make hundreds of test users) since the recommendations are specific to this user. As a result, it is a lot easier to scale my algorithm that recommends niche activities that very few other users are interested in [3].


