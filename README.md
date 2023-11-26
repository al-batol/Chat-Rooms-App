# Chat Rooms

Chat Rooms is a collaborative application built using the Flutter framework, Firebase backend, and incorporating the BLoC state management pattern and clean architecture principles. It serves as a platform for programmers to share their programming errors and seek assistance from fellow developers in resolving these issues.

## Key Features:

### Account Creation and Authentication

- Users can create an account by signing up with their Google account or by providing their name, email, password, and password confirmation.
- If users choose to sign up with their Google account, email verification is not required. However, email and password registration requires account verification through email verification.
- Upon successful authentication, users are directed to the home screen.
  
photos for description:
- Create an account screen
![Screenshot_20231126-193631](https://github.com/al-batol/Chat-Rooms-App/assets/127296481/b0d8b0ba-bd41-4167-a53a-2fa896019c1c)
- Login screen:
![Screenshot_20231126-193627](https://github.com/al-batol/Chat-Rooms-App/assets/127296481/eaa0853a-da78-444b-ac71-479219a455ac)

### Home Screen

- The home screen serves as the central hub of Chat Rooms, displaying all the rooms created by programmers.
- Users can search for specific rooms using three search options: by name, topic, or description.
- Unverified users will see a red warning prompting them to verify their account. A "Verify Now" button triggers the email verification process.
- Verified users will not see the warning message.

-Verified user:
![Screenshot_20231126-185516](https://github.com/al-batol/Chat-Rooms-App/assets/127296481/05402dae-2347-4bec-8148-b00881947e93)
- Unverified user:
![Screenshot_20231126-193939](https://github.com/al-batol/Chat-Rooms-App/assets/127296481/eb571c3c-29ef-4d8f-8ff0-26cfa2745f69)
- Search:
![Screenshot_20231126-185524](https://github.com/al-batol/Chat-Rooms-App/assets/127296481/7044f620-858d-4bfe-a675-3183520e7867)

### Room Creation and Administration

- Users can create rooms only when signed in and with a verified email.
- The room creation screen includes three fields: room topic, room name, and room description.
- After creating a room, the user becomes the room's administrator, with the ability to edit the room's information and delete it if desired.

- Create Room Screen:
![Screenshot_20231126-185543](https://github.com/al-batol/Chat-Rooms-App/assets/127296481/ec10b29d-00c7-4941-8140-b744824f6d08)
-Update Room Screen:
![Screenshot_20231126-193749](https://github.com/al-batol/Chat-Rooms-App/assets/127296481/9f390e4f-4d0b-4f7c-a5f9-b11edc8063f0)

### Room Participation

- Once a room is created, it appears on the home screen, allowing any user to join and participate in the conversation.
- Non-account holders can browse and search for rooms but cannot send messages; they can only view the ongoing discussions.

### Account Management

- A sign-out button is available for users who wish to log out of their account.
- Upon clicking the sign-out button, users are presented with two options: "Settings" and "Log Out."
- The "Settings" option leads to the settings screen, where users can modify their avatar, name, and bio.
- Additionally, users can view the rooms they have created within the settings screen.

- Settings or Log out:
![Screenshot_20231126-193759](https://github.com/al-batol/Chat-Rooms-App/assets/127296481/5f71580b-f403-484b-8852-884d844e6677)
- Edit Profile Screen:
![Screenshot_20231126-185538](https://github.com/al-batol/Chat-Rooms-App/assets/127296481/ecf55c08-ac72-4dd3-ad17-cc6fda7844bb)
