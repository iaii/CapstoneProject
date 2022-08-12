# CapstoneProject

ActivityX is a mood-based activity recommender.

Time spent: 240 hours spent in total

## User Stories

- [x] User sees an app icon on the home screen and a styled launch screen.
- [x] User input infomation about how they are feeling and how their day was. Emotion tags would be 
- [x] Depending on the inf.
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


## Complext Feature - Content-based Filtering Recommendation System
### What is Content-Based Filtering? - recommender system algorithm
Content-based filtering is a type of Machine Learning recommender system algorithm that attempts to make recommendations based on user preferences and product features (in my case it would be activity features).

### Database Design
- User Database: stores basic information about the user such as their age and what activities they have previously selected.
- Activity Database:  Stores all the potential activities that could be recommended to the user. Each activity has associated features that helps in determining which activity the user would like the best

### Drawbacks to the design + How they have been addressed
- User needs to input all the data if they want to add a new activity
- Does not take into account how other users have responded to these activities. This can be addressed by implementing Collaborative Filtering, a Machine Learning algorithm.

Although there are some drawbacks to this design, the pros of this design far outweigh the fact that the user might be slightly inconvenienced because they need to provide more data and avoid implementing more complex ML algorithms. More importantly, implementing a content-based algorithm in comparison to a collaborative algorithm is better suited for this application as my model does not need any data about other users (which would be very hard to manually make hundreds of test users) since the recommendations are specific to this user. As a result, it is a lot easier to scale my algorithm that recommends niche activities that very few other users are interested in.


## Complex Feature 2 - Animations
### Sad Animation
- If the primary emotion is sad, when selecting what activity the user wants to do raindrops fall.
- The user can catch the raindrops by tapping on them
- If the user is able to catch all the raindrops the screen changes into something happier.
- The objective of this is make the user feel a little better through the game

### Happy Animation
- If the primary emotion is happy, a bunch of randomly sized happy pictures will appear from the bottom right corner

### How are the animations complex?
- Each animation, the sad and happy animations, are coded from the scratch
- The sad animations have a gesture feature where if they are tapped it is removed from the screen. In order to accomplish this a custom UI View was created in order to detect if the user tapped on the screen or raindrop
- Each animation has a model that stores random values for thier positions
- All the animations are removed at the end to increase effieciency

