# GoCrave On-Demand Food Delivery Platform

[![Flutter](https://img.shields.io/badge/Flutter-3.27.0-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.6.0-0175C2?style=flat-square&logo=dart&logoColor=white)](https://dart.dev/)
[![Node.js](https://img.shields.io/badge/Node.js-22.x-339933?style=flat-square&logo=node.js&logoColor=white)](https://nodejs.org/)
[![Express.js](https://img.shields.io/badge/Express.js-4.21.0-000000?style=flat-square&logo=express&logoColor=white)](https://expressjs.com/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16.x-4169E1?style=flat-square&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Material Design](https://img.shields.io/badge/Material_Design-3-757575?style=flat-square&logo=materialdesign&logoColor=white)](https://m3.material.io/)
[![Flutter Map](https://img.shields.io/badge/Flutter_Map-7.0.2-1C7C54?style=flat-square&logo=openstreetmap&logoColor=white)](https://pub.dev/packages/flutter_map)
[![Google Fonts](https://img.shields.io/badge/Google_Fonts-Poppins-4285F4?style=flat-square&logo=googlefonts&logoColor=white)](https://fonts.google.com/specimen/Poppins)

**GoCrave** is a multi-role food delivery platform that connects **Customers**, **Restaurant Merchants**, **Delivery Riders**, and **Super Admins** through a unified application.

Built with Flutter and Dart, with a Node.js and Express.js REST API and a PostgreSQL database, the platform supports food ordering, restaurant operations, delivery coordination, order tracking, and administrative management.

---

## Features

### Customer Features
- **Food Menu & Categories:** Browse food categories, explore menu items, and filter by price.
- **Location Picker:** Select delivery addresses using an interactive OpenStreetMap interface.
- **Cart & Checkout:** Manage item quantities, calculate delivery fees, and apply voucher discounts.
- **Order Tracking:** Follow order progress from placement to completion.
- **In-App Communication:** Chat and voice call with assigned delivery riders.
- **Wallet & Rewards:** View wallet balances, transaction history, and daily check-in rewards.

### Restaurant Merchant Features
- **Kitchen Order Pipeline:** Manage incoming orders, preparation, and ready-for-pickup orders.
- **Menu & Inventory Management:** Create food items and update stock availability.
- **Merchant Communication:** Communicate with customers and assigned riders.

### Delivery Rider Features
- **Assigned Deliveries:** View delivery tasks with relevant order and location details.
- **Active Task Workflow:** Update delivery progress from acceptance and store pickup to customer arrival.
- **Proof of Delivery:** Submit photo evidence when completing deliveries.
- **Earnings & Wallet:** Track delivery earnings, review completed deliveries, and submit GCash withdrawal requests.

### Administrative Control Panel
- **Operations Dashboard:** Monitor orders, delivery activity, and rider assignments.
- **Financial Analytics:** Review order volume, revenue trends, and performance across daily, weekly, and monthly periods.
- **Order Status Overview:** Track Pending, Assigned, In Progress, On Delivery, and Completed orders.
- **Rider Verification:** Review submitted rider licenses and government-issued IDs.
- **Notifications Center:** View alerts for orders, rider verification, and revenue milestones.

### User Interface
- **Material Design 3:** Rounded cards, subtle shadows, and consistent typography.
- **GoCrave Branding:** Orange primary color (`#F14802`) across the application.
- **Responsive Layouts:** Adaptive interfaces for Android smartphones, foldables, and tablets.

---

## Technologies

| Technology | Version | Purpose |
| --- | --- | --- |
| **Flutter** | 3.27.0 | Cross-platform application framework |
| **Dart** | 3.6.0 | Application programming language |
| **Node.js** | 22.x | Backend runtime |
| **Express.js** | 4.21.0 | REST API development |
| **PostgreSQL** | 16.x | Relational database |
| **Flutter Map** | 7.0.2 | Map rendering and location markers |
| **latlong2** | 0.9.1 | Geographic coordinates and distance calculations |
| **Google Fonts** | 6.2.1 | Typography and Poppins font integration |

### Development Tools

| Tool | Version | Purpose |
| --- | --- | --- |
| **Android Studio** | Ladybug 2026.1.2 | Application development |
| **Flutter CLI** | 3.27.0 | Build, analysis, and hot reload |
| **Postman** | 11.x | API testing |
| **Git** | 2.x | Version control |

---

## Responsive Design

The interface adapts to different Android screen sizes through flexible layouts, mobile content width constraints, and tablet-friendly arrangements. The goal is to keep navigation, order details, and management tools usable across supported devices.

---

## Project Purpose

GoCrave aims to simplify food ordering and delivery coordination by bringing customers, restaurants, riders, and administrators into one platform.

---

## Development Status

![In Development](https://img.shields.io/badge/Status-In%20Development-F14802?style=flat-square)

Development is ongoing, with current work focused on connecting the Flutter application to the Node.js and Express.js API and integrating PostgreSQL-backed data operations.

