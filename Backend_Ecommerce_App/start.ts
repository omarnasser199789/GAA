import { PrismaClient } from '@prisma/client';
// Initialize Prisma Client
const prisma = new PrismaClient();

// Function to insert users
async function insertUsers() {
  try {
    // Define an array of user objects to insert
    const usersToInsert = [
      {
        username: 'user1',
        password: 'password1',
        deleted: false,
      },
      {
        username: 'user2',
        password: 'password2',
        deleted: false,
      },
      // Add more user objects as needed
    ];

    // Use Prisma to insert the users into the database
    const insertedUsers = await prisma.user.createMany({
      data: usersToInsert,
    });

    console.log('Inserted users:', insertedUsers);
  } catch (error) {
    console.error('Error inserting users:', error);
  }
}

// Function to generate and insert banners
async function generateAndInsertBanners() {
  try {
    // Define an array of banner objects to insert
    const bannersToInsert = [
      {
        link: 'https://google.com',
        attachmentUrl: 'https://hi-erbil.s3.amazonaws.com/Banners/Auto-Company-Ad-Banner-Design-scaled.jpg',
        isVideo: false,
        deleted: false,
        createdBy: 1, // Replace with a valid user ID from your database
      },
      {
        link: 'https://google.com',
        attachmentUrl: 'https://hi-erbil.s3.amazonaws.com/Banners/automotive-social-media-facebook-cover-banner-template_123633-432+(1).jpg',
        isVideo: true,
        deleted: false,
        createdBy: 1, // Replace with another valid user ID
      },
      {
        link: 'https://google.com',
        attachmentUrl: 'https://hi-erbil.s3.amazonaws.com/Banners/car-rental-automotive-facebook-cover-template_106176-2481.png',
        isVideo: true,
        deleted: false,
        createdBy: 1, // Replace with another valid user ID
      },
      {
        link: 'https://google.com',
        attachmentUrl: 'https://hi-erbil.s3.amazonaws.com/Banners/car-rental-sale-horizontal-banner-facebook-cover-advertising-template_177160-397.jpg',
        isVideo: true,
        deleted: false,
        createdBy: 1, // Replace with another valid user ID
      },
      {
        link: 'https://google.com',
        attachmentUrl: 'https://hi-erbil.s3.amazonaws.com/Banners/car-rental-social-media-facebook-cover-banner-design-template_751855-6.png',
        isVideo: true,
        deleted: false,
        createdBy: 1, // Replace with another valid user ID
      },
      // Add more banners with valid createdBy IDs as needed
    ];


    // Use Prisma to insert the banners into the database
    const insertedBanners = await prisma.banner.createMany({
      data: bannersToInsert,
    });

    console.log('Inserted banners:', insertedBanners);
  } catch (error) {
    console.error('Error generating and inserting banners:', error);
  }
}

// Function to generate and insert banners
async function generateAndInsertCategories() {
  try {
    // Define an array of category objects to insert
    const categoriesToInsert = [
      {
        imageUrl: 'https://hi-erbil.s3.amazonaws.com/Category/shirts.jpg',
        title_en: 'Shirts',
        title_ar: 'القمصان',
        title_ku: 'کۆمپانیای ئۆتۆمبێل',
        deleted: false,
        createdBy: 1, // Replace with a valid user ID from your database
      },
      {
        imageUrl: 'https://hi-erbil.s3.amazonaws.com/Category/shoes.jpg',
        title_en: 'Shoes',
        title_ar: 'أحذية',
        title_ku: 'کۆمپانیای ئۆتۆمبێل',
        deleted: false,
        createdBy: 1, // Replace with a valid user ID from your database
      },
      {
        imageUrl: 'https://hi-erbil.s3.amazonaws.com/Category/photo_5449429457371777631_y.jpg',
        title_en: 'yogapants',
        title_ar: 'السراويل اليوغا',
        title_ku: 'کۆمپانیای ئۆتۆمبێل',
        deleted: false,
        createdBy: 1, // Replace with a valid user ID from your database
      },

      {
        imageUrl: 'https://hi-erbil.s3.amazonaws.com/Category/photo_5449429457371777631_y.jpg',
        title_en: 'yogapants',
        title_ar: 'السراويل اليوغا',
        title_ku: 'کۆمپانیای ئۆتۆمبێل',
        deleted: false,
        parentId: 3,
        createdBy: 1, // Replace with a valid user ID from your database
      },

      
      // Add more category objects as needed
    ];

    // Use Prisma to insert the categories into the database
     const insertedCategories = await prisma.category.createMany({
      data: categoriesToInsert,
    });

    console.log('Inserted banners:', insertedCategories);
  } catch (error) {
    console.error('Error generating and inserting banners:', error);
  }
}


// Function to generate and insert products
async function generateAndInsertProducts() {
  try {
    // Define an array of product objects to insert
    const productsToInsert = [
      {
        title_en: 'Product 1',
        title_ar: 'المنتج 1',
        title_ku: 'پرۆدوکت ١',
        description_en: 'Description of Product 1',
        description_ar: 'وصف المنتج 1',
        description_ku: 'وسەرنجی پرۆدوکت ١',
        deleted: false,
        createdBy: 1, // Replace with a valid user ID from your database
        categoryId: 4, // Replace with a valid category ID
      },
      
      // Add more product objects as needed
    ];

    // Use Prisma to insert the products into the database
    const insertedProducts = await prisma.product.createMany({
      data: productsToInsert,
    });

    console.log('Inserted products:', insertedProducts);
  } catch (error) {
    console.error('Error generating and inserting products:', error);
  } finally {
    // Close the Prisma connection
    await prisma.$disconnect();
  }
}

// Function to generate and insert product attachments
async function generateAndInsertProductAttachments() {
  try {
    // Define an array of product attachment objects to insert
    const productAttachmentsToInsert = [
      {
        url: 'https://hi-erbil.s3.amazonaws.com/Products/American-Tall-Women-Georgia-HighRise-SkinnyJean-Black-back.webp',
        isVideo: false,
        productId: 1, // Replace with a valid product ID from your database
      },
      {
        url: 'https://hi-erbil.s3.amazonaws.com/Products/American-Tall-Women-Georgia-HighRise-SkinnyJean-Black-detail.webp',
        isVideo: true,
        productId: 1, // Replace with another valid product ID
      },
      {
        url: 'https://hi-erbil.s3.amazonaws.com/Products/American-Tall-Women-Georgia-HighRise-SkinnyJean-Black-full.webp',
        isVideo: true,
        productId: 1, // Replace with another valid product ID
      },
      {
        url: 'https://hi-erbil.s3.amazonaws.com/Products/American-Tall-Women-Georgia-HighRise-SkinnyJean-Black-pocket.webp',
        isVideo: true,
        productId: 1, // Replace with another valid product ID
      },
      {
        url: 'https://hi-erbil.s3.amazonaws.com/Products/American-Tall-Women-Georgia-HighRise-SkinnyJean-Black-side.webp',
        isVideo: true,
        productId: 1, // Replace with another valid product ID
      },
      // Add more product attachment objects as needed
    ];

    // Use Prisma to insert the product attachments into the database
    const insertedProductAttachments = await prisma.productAttachment.createMany({
      data: productAttachmentsToInsert,
    });

    console.log('Inserted product attachments:', insertedProductAttachments);
  } catch (error) {
    console.error('Error generating and inserting product attachments:', error);
  } finally {
    // Close the Prisma connection
    await prisma.$disconnect();
  }
}


// Function to start the process
async function start() {
  try {
    // Insert users first
    await insertUsers();

    // Generate and insert banners
    await generateAndInsertBanners();

    // Generate and insert categories
    await generateAndInsertCategories();

    // Generate and insert categories
    await generateAndInsertProducts();

    // Generate and insert ProductAttachments
    await generateAndInsertProductAttachments();

  } catch (error) {
    console.error('Error:', error);
  } finally {
    // Close the Prisma connection
    await prisma.$disconnect();
  }
}

// Call the start function to begin the process
start();
