class Review {
  final String userName;
  final String userImage;
  final int stars;
  final String comment;
  final String? reviewImage;
  final String date;
  final String foodTitle;

  Review({
    required this.userName,
    required this.userImage,
    required this.stars,
    required this.comment,
    this.reviewImage,
    required this.date,
    required this.foodTitle,
  });
}

final List<Review> mockReviews = [
  Review(
    userName: 'John Andrew',
    userImage: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop',
    stars: 5,
    comment: 'Super sarap! Highly recommended especially the flavor of the beef. Perfect for lunch!',
    reviewImage: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=600&auto=format&fit=crop',
    date: '2 hours ago',
    foodTitle: 'Juicy Beef Burger',
  ),
  Review(
    userName: 'Maria Clara',
    userImage: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=200&auto=format&fit=crop',
    stars: 4,
    comment: 'Delicious burger but the fries were a bit cold. Still worth it!',
    reviewImage: 'https://images.unsplash.com/photo-1594212699903-ec8a3eca50f5?q=80&w=600&auto=format&fit=crop',
    date: '1 day ago',
    foodTitle: 'Juicy Beef Burger',
  ),
  Review(
    userName: 'Vic Sotto',
    userImage: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200&auto=format&fit=crop',
    stars: 3,
    comment: 'It was okay, but I expected more sauce.',
    reviewImage: 'https://images.unsplash.com/photo-1550547660-d9450f859349?q=80&w=600&auto=format&fit=crop',
    date: '2 days ago',
    foodTitle: 'Juicy Beef Burger',
  ),

  Review(
    userName: 'Chef Boy Logro',
    userImage: 'https://images.unsplash.com/photo-1583394838336-acd977736f90?q=80&w=200&auto=format&fit=crop',
    stars: 5,
    comment: 'Ping ping ping! Yum yum yum! Saktong sakto ang pepperoni at cheese.',
    reviewImage: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=600&auto=format&fit=crop',
    date: '3 days ago',
    foodTitle: 'Pepperoni Feast',
  ),
  Review(
    userName: 'Maine Mendoza',
    userImage: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=200&auto=format&fit=crop',
    stars: 4,
    comment: 'Very tasty pizza, kids loved it!',
    reviewImage: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?q=80&w=600&auto=format&fit=crop',
    date: '4 days ago',
    foodTitle: 'Pepperoni Feast',
  ),

  Review(
    userName: 'Liza Soberano',
    userImage: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop',
    stars: 5,
    comment: 'The sauce is perfect! Tastes just like how my Lola makes it.',
    reviewImage: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?q=80&w=600&auto=format&fit=crop',
    date: '2 days ago',
    foodTitle: 'Chicken Adobo',
  ),
  Review(
    userName: 'James Reid',
    userImage: 'https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?q=80&w=200&auto=format&fit=crop',
    stars: 4,
    comment: 'Good adobo, but could use a bit more garlic.',
    reviewImage: 'https://images.unsplash.com/photo-1627308595229-7830a5c91f9f?q=80&w=600&auto=format&fit=crop',
    date: '3 days ago',
    foodTitle: 'Chicken Adobo',
  ),

  Review(
    userName: 'Enrique Gil',
    userImage: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200&auto=format&fit=crop',
    stars: 5,
    comment: 'Very fresh and filling. The dressing is amazing.',
    reviewImage: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=600&auto=format&fit=crop',
    date: '5 days ago',
    foodTitle: 'Quinoa Salad Bowl',
  ),
  Review(
    userName: 'Gerald Anderson',
    userImage: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop',
    stars: 5,
    comment: 'Best salad in town. Everything is organic.',
    reviewImage: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=600&auto=format&fit=crop',
    date: '1 week ago',
    foodTitle: 'Quinoa Salad Bowl',
  ),

  Review(
    userName: 'Pia Wurtzbach',
    userImage: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=200&auto=format&fit=crop',
    stars: 5,
    comment: 'Perfect movie night snack! Generous cheese and toppings.',
    reviewImage: 'https://images.unsplash.com/photo-1513456852971-30c0b8199d4d?q=80&w=600&auto=format&fit=crop',
    date: '1 week ago',
    foodTitle: 'Nachos Supreme',
  ),

  Review(
    userName: 'Catriona Gray',
    userImage: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=200&auto=format&fit=crop',
    stars: 5,
    comment: 'The center is so gooey and rich. A must-try for chocolate lovers!',
    reviewImage: 'https://images.unsplash.com/photo-1565958011703-44f9829ba187?q=80&w=600&auto=format&fit=crop',
    date: '4 days ago',
    foodTitle: 'Chocolate Lava Cake',
  ),

  Review(
    userName: 'Kathryn Bernardo',
    userImage: 'https://images.unsplash.com/photo-1491349174775-aaafddd81942?q=80&w=200&auto=format&fit=crop',
    stars: 5,
    comment: 'So refreshing and not too sweet. Perfect for the Manila heat.',
    reviewImage: 'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?q=80&w=600&auto=format&fit=crop',
    date: '10 hours ago',
    foodTitle: 'Mango Graham Shake',
  ),

  Review(
    userName: 'Daniel Padilla',
    userImage: 'https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?q=80&w=200&auto=format&fit=crop',
    stars: 5,
    comment: 'The sourness is just right. The pork is very tender!',
    reviewImage: 'https://images.unsplash.com/photo-1625398407796-82650a8c135f?q=80&w=600&auto=format&fit=crop',
    date: '1 day ago',
    foodTitle: 'Pork Sinigang',
  ),
];
