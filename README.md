# CapstoneProject

ActivityX is a mood-based activity recommender.

Time spent: 240 hours spent in total

Due to merge conflicts, if possible please look at this latest code: [CapstoneProject-main.zip](https://github.com/iaii/CapstoneProject/files/9329375/CapstoneProject-main.zip)

## User Stories

- [x] User sees an app icon on the home screen and a styled launch screen.
- [x] User input infomation about how they are feeling and how their day was. The mood will be determined from the text given 
- [x] Recommendations on what activity they should do will be provided 
- [x] User can select what activity they want to
- [x] The selected activity will be saved and displayed in a calendar view
- [x] User sees an error message when there's a networking error.
- [x] User can add thier own custome activities for any emotion.
- [x] User change the associated emotion with the activity 

MetaU Expectations:

- [x] User can sign up, login, logout, and have persistant login 
- [x] You can sign up with a new user profile
- [x] Your app provides multiple opportunities for you to overcome difficult/ambiguous technical problems (more below)
- [x] Your app interacts with a database (e.g. Parse).
- [x] API integration.
- [x] Your app has multiple views
- [x] Your app uses at least one gesture
- [x] Your app incorporates at least one external library to add visual polish
- [x] Your app uses at least one animation (e.g. fade in/out, e.g. animating a view growing and shrinking)

## Complext Feature - Content-based Filtering Recommendation System
### What is Content-Based Filtering? - recommender system algorithm
Content-based filtering is a type of Machine Learning recommender system algorithm that attempts to make recommendations based on user preferences and product features (in my case it would be activity features).

### Database Design
- User Database: stores basic information about the user such as their age and what activities they have previously selected.
- Activity Database:  Stores all the potential activities that could be recommended to the user. Each activity has associated features that helps in determining which activity the user would like the best

<img width="614" alt="image" src="https://user-images.githubusercontent.com/19788746/184416114-15982827-247e-4556-8403-01ef0df43ce0.png">
<img width="605" alt="image" src="https://user-images.githubusercontent.com/19788746/184416213-48177b9f-844a-4f85-8eb5-61f1236fec0e.png">
<img width="579" alt="image" src="https://user-images.githubusercontent.com/19788746/184416306-c63f1df6-6343-4958-bbfe-daadd3a1b9ae.png">

### Drawbacks to the design + How they have been addressed
- User needs to input all the data if they want to add a new activity
- Does not take into account how other users have responded to these activities. This can be addressed by implementing Collaborative Filtering, a Machine Learning algorithm.

Although there are some drawbacks to this design, the pros of this design far outweigh the fact that the user might be slightly inconvenienced because they need to provide more data and avoid implementing more complex ML algorithms. More importantly, implementing a content-based algorithm in comparison to a collaborative algorithm is better suited for this application as my model does not need any data about other users (which would be very hard to manually make hundreds of test users) since the recommendations are specific to this user. As a result, it is a lot easier to scale my algorithm that recommends niche activities that very few other users are interested in.

More infomation: https://docs.google.com/document/d/1G2D86viD2N7oJD8tYDsEopoVEnaMv5hFkadu33NsdPc/edit#

## Complex Feature #2 - Animations
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


https://user-images.githubusercontent.com/19788746/184415305-9a281340-d101-4612-b218-3abeacd0acc9.mp4







https://user-images.githubusercontent.com/19788746/184417444-92e45168-2030-418b-a2c7-a92c703392d7.mp4





https://user-images.githubusercontent.com/19788746/184417459-20d63055-a5d8-4ecd-9c09-2f662b5226cd.mp4

