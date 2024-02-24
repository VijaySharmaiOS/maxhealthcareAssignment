# Instructions to run the app
To run this application, simply clone the repository to your local machine and open the project in Xcode. Ensure you have an active internet connection as the app fetches data from an API. Build and run the project on a simulator or a physical device running iOS 13.0 or later

# Design/architectural decisions you made and why
This project follows the MVVM (Model-View-ViewModel) architectural pattern. The TopicsRootModel acts as a model to manipulate data fetched from the API. The TopicViewModel class handles API requests, displaying success or error messages accordingly. This separation of concerns ensures a clean and maintainable codebase, facilitating easier testing and scalability

# Any challenges you faced and how you overcame them
One challenge encountered was a black screen after creating a RootViewController with a navigation controller. Overcoming this, setting the view controller's background color to white resolved the issue.

# Demo Video Link
 https://drive.google.com/file/d/1D7i1FhrL5STTkUTNqJCq7RW743PvUxvM/view?usp=share_link
