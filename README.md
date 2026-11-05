# GoCrave On-Demand Food Delivery Platform

---
> [!IMPORTANT]
> **Repository Status: Temporarily Paused (Focusing on AquaTech)**
> 
> Active development on the **GoCrave On-Demand Food Delivery Platform** is currently suspended. Engineering efforts and strategic focus have been fully transitioned to the **AquaTech** initiative. This repository is preserved in its latest stable release state.
---

**GoCrave** is a multi-role food delivery platform connecting **Customers**, **Restaurant Merchants**, **Delivery Riders**, and **Super Admins** within a single application.

Built using **Flutter** and **Dart** for the client application, backed by a **Node.js** and Express.js REST API with a PostgreSQL database.

---

## Key Features

### Customer Portal
- **Menu & Categories:** Explore food items by category with price filtering.
- **Location Picker:** Interactive OpenStreetMap pin-selection for delivery addresses.
- **Cart & Checkout:** Item management, delivery fee calculation, and promo vouchers.
- **Live Order Tracking:** Real-time progress monitoring from placement to delivery.
- **Communication:** Direct chat and voice call options with assigned delivery riders.
- **Wallet & Rewards:** In-app balance, transaction history, and daily check-in rewards.

### Merchant Portal
- **Kitchen Pipeline:** Manage order flow across `Incoming`, `Preparing`, and `Ready`.
- **Menu & Stock Management:** Create menu items and toggle real-time availability.
- **Direct Messaging:** Communicate with customers and assigned riders.

### Rider Portal
- **Delivery Tasks:** View available orders with pickup and delivery locations.
- **Workflow Steps:** Track progress from order acceptance to customer arrival.
- **Proof of Delivery:** Upload photo proof upon completing deliveries.
- **Earnings & Wallet:** Track completed deliveries and request GCash payouts.

### Admin Command Center
- **Overview & Analytics:** Monitor live operations, order volume, and revenue trends.
- **Status Monitoring:** Real-time counts for Pending, Assigned, In Progress, On Delivery, and Completed orders.
- **Master Fleet Map:** Real-time city-wide multi-rider live tracking map.
- **PDF Export Suite:** Generate, print, and share real-world synced executive PDF reports.
- **Rider Verification:** Review and verify submitted government IDs and driver licenses.
- **Notification Hub:** Alerts for order updates, verification requests, and daily totals.

### Design & User Interface
- **Material Design 3:** Modern rounded cards, elevation shadows, and clean typography.
- **GoCrave Theme:** GoCrave Orange (`#FF5622`) branding across all screens.
- **Responsive Layout:** Optimized for Android smartphones, foldables, and tablets.

---

## Tech Stack & Tools

| Technology / Tool | Version | Application Role |
| --- | --- | --- |
| **Flutter** | 3.27.0 | Multi-platform mobile app framework |
| **Dart** | 3.6.0 | Programming language |
| **Node.js** | 22.x | Backend server runtime |
| **Express.js** | 4.21.0 | RESTful API framework |
| **PostgreSQL** | 16.x | Relational SQL database |
| **Flutter Map** | 7.0.2 | OpenStreetMap tile rendering |
| **latlong2** | 0.9.1 | Geographic coordinates & calculations |
| **Google Fonts** | 6.2.1 | Typography (Poppins font) |
| **Android Studio** | Ladybug 2026.1.2 | Primary IDE |
| **Postman** | 11.x | API testing and endpoint debugging |
