# WishLinks 
A collaborative wishlist app that auto-fills item details from product links

---

## Overview

**WishLinks** is a work-in-progress SwiftUI app that makes creating and sharing wishlists effortless. Whether you're planning a group event, organizing a potluck, or just tracking your own shopping list, WishLinks streamlines the process. Paste a product URL and the app instantly extracts the item's title, price, and image — no manual entry needed.

WishLists can be private and personalized, or collaborative and shareable — perfect for birthdays, team events, holiday gift exchanges, and more.

---

## Screenshots / Mockups

>  _More to come as development continues — these are early designs!_

| Home Screen | Add Item To Wishlist Flow |
|-------------|----------------|
| <img width="368" height="699" alt="Screenshot 2025-09-09 at 10 31 39 AM" src="https://github.com/user-attachments/assets/431671e1-9499-43b8-a534-157108ae6657" />| <img width="314" height="699" alt="IMG_1670" src="https://github.com/user-attachments/assets/f3e1e8dd-1983-4515-aae2-33cfc6320b95" /> |

Note that the avatr pixel pictures in the circles are not part of the app and are just for display purposes! Avatars source:https://www.avatarsinpixels.com
---

## Features

- Paste product links to auto-fill title, price, and image
- Create multiple personal or shared wishlists
- Collaborate with friends or coworkers in real time
- Assign items to others for purchase or contribution
- Responsive and modern SwiftUI interface (in progress!)

---



##  Tech Stack

- SwiftUI
- OpenGraph scraping for link metadata (custom)
- Firebase Auth + Firestore (planned)

---

## Project Status

 **Currently in development.**  
Core functionality is being built incrementally and will be updated regularly.

---

##  Acknowledgements

- Inspired by collaborative tools like Pinterest, Google Docs, and Apple Reminders
- Uses [AsyncImage](https://developer.apple.com/documentation/swiftui/asyncimage) for remote image loading
