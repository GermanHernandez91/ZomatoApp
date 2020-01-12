# ZomatoApp

iOS app to list restaurants from your current location using Zomato public API and authenticate users with firebase

Users can access to the app without an account, they just need to set up their location and they will be redirect to the main screen which is a list of cuisines and restaurants from your current area.

Users can see restaurant details, gallery and reviews. They can also create an account, login, delete the account.

THIS APP IS JUST FOR DEVELOPMENT PURPOSES.

## Configuration

In order to use your own zomato public api key, you need to create a file under Utilities called Environment and it should looks like this:

```
struct Environment {
    struct Variables {
        static let zomatoApiKey = ""
    }
}
```

## Features

* No third libraries
* No storyboards
* MVC architecture
* Following apple styleguides
* Location permissions
* Access to Zomato public API
* Use of new UICollectionViewDiffableDataSource
