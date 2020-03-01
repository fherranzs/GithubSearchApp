# GithubSearchApp
This iOS application allows consumes Github API and displays lists of users based on their username. When the user taps on one user, the application shows its profile, with information regarding the connections of the user (followers and following) and its repositories. It also shows a list of repositories and followers.

# Application functioning
1. The application provides a Search Bar where the user can input a username.
<img src="https://user-images.githubusercontent.com/26417044/75630149-5b44d780-5be8-11ea-9fc2-dd46955173f5.png" alt="drawing" width="200"/>
2. When the user inputs a text and clicks on Search/Enter, the app will return a list of users whose username matches the text.
<img src="https://user-images.githubusercontent.com/26417044/75630267-78c67100-5be9-11ea-849a-5fe6370a870c.png" alt="drawing" width="200"/>
3. After clicking on one of the users, the app will provide the details for that users, including lists of repositories and followers.
<img src="https://user-images.githubusercontent.com/26417044/75630340-4c5f2480-5bea-11ea-9728-a756dd3ee318.png" alt="drawing" width="200"/>

# Miscellaneous
This application has been realized using a MVVM design patter, whose structure is shown in the image below. The view models are in charge of retriving the data from the Github API and preparing it for the views.

<img src="https://user-images.githubusercontent.com/26417044/75630559-11f68700-5bec-11ea-8398-0f77b6fd8736.png" alt="drawing" width="200"/>
