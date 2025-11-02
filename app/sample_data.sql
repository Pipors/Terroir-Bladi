-- PostgreSQL INSERT statements for Prisma schema
-- Execute in order due to foreign key dependencies

-- Clear existing data (optional - uncomment if needed)
-- TRUNCATE TABLE "reviews", "order_items", "orders", "products", "categories", "cooperatives", "users" RESTART IDENTITY CASCADE;

-- 1. Insert Users (10 records)
INSERT INTO "users" (
    id, email, password, role, "isActive", "firstName", "lastName", phone, avatar, "preferredLanguage", "createdAt", "updatedAt"
) VALUES 
('user_001', 'admin@startup.ma', '$2b$10$hashedpassword1', 'SUPER_ADMIN', true, 'Ahmed', 'Benali', '+212600123456', 'https://example.com/avatar1.jpg', 'ar', NOW(), NOW()),
('user_002', 'coop1@startup.ma', '$2b$10$hashedpassword2', 'COOPERATIVE', true, 'Fatima', 'Zahra', '+212600234567', 'https://example.com/avatar2.jpg', 'ar', NOW(), NOW()),
('user_003', 'coop2@startup.ma', '$2b$10$hashedpassword3', 'COOPERATIVE', true, 'Youssef', 'Alami', '+212600345678', 'https://example.com/avatar3.jpg', 'fr', NOW(), NOW()),
('user_004', 'coop3@startup.ma', '$2b$10$hashedpassword4', 'COOPERATIVE', true, 'Aicha', 'Bennis', '+212600456789', 'https://example.com/avatar4.jpg', 'ar', NOW(), NOW()),
('user_005', 'customer1@gmail.com', '$2b$10$hashedpassword5', 'CUSTOMER', true, 'Hassan', 'Idrissi', '+212600567890', 'https://example.com/avatar5.jpg', 'ar', NOW(), NOW()),
('user_006', 'customer2@gmail.com', '$2b$10$hashedpassword6', 'CUSTOMER', true, 'Khadija', 'Amrani', '+212600678901', NULL, 'fr', NOW(), NOW()),
('user_007', 'customer3@hotmail.com', '$2b$10$hashedpassword7', 'CUSTOMER', true, 'Omar', 'Tazi', '+212600789012', 'https://example.com/avatar7.jpg', 'en', NOW(), NOW()),
('user_008', 'customer4@yahoo.com', '$2b$10$hashedpassword8', 'CUSTOMER', true, 'Nadia', 'Benjelloun', '+212600890123', NULL, 'ar', NOW(), NOW()),
('user_009', 'customer5@outlook.com', '$2b$10$hashedpassword9', 'CUSTOMER', false, 'Rachid', 'Lahlou', '+212600901234', 'https://example.com/avatar9.jpg', 'ar', NOW(), NOW()),
('user_010', 'customer6@gmail.com', '$2b$10$hashedpassword10', 'CUSTOMER', true, 'Samira', 'Bennani', '+212601012345', 'https://example.com/avatar10.jpg', 'fr', NOW(), NOW());

-- 2. Insert Cooperatives (3 cooperatives for the COOPERATIVE role users)
INSERT INTO "cooperatives" (
    id, "userId", name_ar, name_fr, name_en, description_ar, description_fr, description_en,
    region, city, address, phone, email, website, "establishedYear", "memberCount", "licenseNumber",
    "isVerified", "isActive", logo, "coverImage", specialties, certifications, "createdAt", "updatedAt"
) VALUES 
('coop_001', 'user_002', 'تعاونية أركان الصحراء', 'Coopérative Argan du Sahara', 'Sahara Argan Cooperative', 
 'تعاونية متخصصة في إنتاج زيت الأركان الطبيعي', 'Coopérative spécialisée dans la production d''huile d''argan naturelle', 'Cooperative specialized in natural argan oil production',
 'Souss-Massa', 'Agadir', 'Hay Mohammadi, Agadir', '+212528123456', 'contact@argansahara.ma', 'https://argansahara.ma', 
 2010, 45, 'LIC-2010-001', true, true, 'https://example.com/coop1_logo.jpg', 'https://example.com/coop1_cover.jpg',
 '["زيت الأركان", "مستحضرات التجميل", "المنتجات الطبيعية"]', '["عضوي", "تجارة عادلة"]', NOW(), NOW()),

('coop_002', 'user_003', 'تعاونية التمور الملكية', 'Coopérative Dattes Royales', 'Royal Dates Cooperative',
 'تعاونية متخصصة في إنتاج وتسويق التمور المغربية', 'Coopérative spécialisée dans la production et commercialisation des dattes marocaines', 'Cooperative specialized in production and marketing of Moroccan dates',
 'Drâa-Tafilalet', 'Zagora', 'Quartier Amezrou, Zagora', '+212528234567', 'info@datesroyales.ma', 'https://datesroyales.ma',
 2015, 32, 'LIC-2015-002', true, true, 'https://example.com/coop2_logo.jpg', 'https://example.com/coop2_cover.jpg',
 '["التمور", "المجول", "المنتجات المجففة"]', '["عضوي", "إيكوسيرت"]', NOW(), NOW()),

('coop_003', 'user_004', 'تعاونية الحرف التقليدية', 'Coopérative Artisanat Traditionnel', 'Traditional Crafts Cooperative',
 'تعاونية متخصصة في الحرف التقليدية المغربية', 'Coopérative spécialisée dans l''artisanat traditionnel marocain', 'Cooperative specialized in Moroccan traditional crafts',
 'Fès-Meknès', 'Fès', 'Médina de Fès', '+212535345678', 'artisanat@tradcraft.ma', 'https://tradcraft.ma',
 2008, 28, 'LIC-2008-003', false, true, 'https://example.com/coop3_logo.jpg', 'https://example.com/coop3_cover.jpg',
 '["السجاد", "الفخار", "الجلود", "النسيج"]', '["حرفي أصيل", "تراث مغربي"]', NOW(), NOW()),

('coop_004', 'user_005', 'تعاونية زيت الزيتون الأطلسية', 'Coopérative Huile d’Olive de l’Atlas', 'Atlas Olive Oil Cooperative',
 'تعاونية تهتم بإنتاج زيت الزيتون البكر الممتاز من جبال الأطلس', 
 'Coopérative dédiée à la production d’huile d’olive vierge extra des montagnes de l’Atlas', 
 'Cooperative focused on producing extra virgin olive oil from the Atlas Mountains',
 'Marrakech-Safi', 'Marrakech', 'Douar Tamesloht, Marrakech', '+212524567890', 'contact@atlasolive.ma', 'https://atlasolive.ma',
 2012, 38, 'LIC-2012-004', true, true, 'https://example.com/coop4_logo.jpg', 'https://example.com/coop4_cover.jpg',
 '["زيت الزيتون", "المنتجات الفلاحية", "الزراعة المستدامة"]', '["إيكوسيرت", "منتج محلي"]', NOW(), NOW()),

('coop_005', 'user_006', 'تعاونية النحل السعيد', 'Coopérative Miel Heureux', 'Happy Honey Cooperative',
 'تعاونية متخصصة في إنتاج العسل الطبيعي ومشتقاته', 
 'Coopérative spécialisée dans la production de miel naturel et ses dérivés', 
 'Cooperative specialized in producing natural honey and its derivatives',
 'Béni Mellal-Khénifra', 'Béni Mellal', 'Douar Aït Ouarda, Béni Mellal', '+212523678901', 'info@mielheureux.ma', 'https://mielheureux.ma',
 2018, 26, 'LIC-2018-005', true, true, 'https://example.com/coop5_logo.jpg', 'https://example.com/coop5_cover.jpg',
 '["العسل", "شمع النحل", "منتجات عضوية"]', '["عضوي", "منتج طبيعي 100%"]', NOW(), NOW()),

('coop_006', 'user_007', 'تعاونية نساء الأطلس للنسيج', 'Coopérative Femmes de l’Atlas pour le Tissage', 'Atlas Women Weaving Cooperative',
 'تعاونية نسائية متخصصة في النسيج والصناعات اليدوية التقليدية', 
 'Coopérative féminine spécialisée dans le tissage et l’artisanat traditionnel', 
 'Women’s cooperative specializing in weaving and traditional handicrafts',
 'Tanger-Tétouan-Al Hoceïma', 'Chefchaouen', 'Village Akchour, Chefchaouen', '+212539987654', 'women@atlasweaving.ma', 'https://atlasweaving.ma',
 2009, 40, 'LIC-2009-006', false, true, 'https://example.com/coop6_logo.jpg', 'https://example.com/coop6_cover.jpg',
 '["النسيج", "الصوف", "الزرابي", "المنتجات اليدوية"]', '["حرفي", "تعاون نسائي"]', NOW(), NOW()),

('coop_007', 'user_008', 'تعاونية الألبان الريفية', 'Coopérative Laitière Rurale', 'Rural Dairy Cooperative',
 'تعاونية تهتم بإنتاج الألبان الطبيعية ومشتقاتها من المزارع المحلية', 
 'Coopérative dédiée à la production de lait naturel et de ses dérivés issus des fermes locales', 
 'Cooperative focused on producing natural dairy products from local farms',
 'Casablanca-Settat', 'Settat', 'Route de Berrechid, Settat', '+212522789012', 'contact@laitrural.ma', 'https://laitrural.ma',
 2013, 52, 'LIC-2013-007', true, true, 'https://example.com/coop7_logo.jpg', 'https://example.com/coop7_cover.jpg',
 '["الحليب", "الجبن", "الزبدة"]', '["عضوي", "معتمد من وزارة الفلاحة"]', NOW(), NOW()),

('coop_008', 'user_009', 'تعاونية خزف تامكروت', 'Coopérative Poterie de Tamgroute', 'Tamgroute Pottery Cooperative',
 'تعاونية متخصصة في صناعة الخزف الأخضر التقليدي بمنطقة تامكروت', 
 'Coopérative spécialisée dans la fabrication de la poterie verte traditionnelle de Tamgroute', 
 'Cooperative specialized in crafting traditional green pottery from Tamgroute',
 'Drâa-Tafilalet', 'Zagora', 'Village Tamgroute, Zagora', '+212528456789', 'tamgroute@poterie.ma', 'https://poterie-tamgroute.ma',
 2005, 22, 'LIC-2005-008', true, true, 'https://example.com/coop8_logo.jpg', 'https://example.com/coop8_cover.jpg',
 '["الخزف", "الفخار التقليدي", "التحف اليدوية"]', '["تراث مغربي", "منتج حرفي"]', NOW(), NOW()),

('coop_009', 'user_010', 'تعاونية الأعشاب العضوية المغربية', 'Coopérative Herbes Bio Maroc', 'Moroccan Organic Herbs Cooperative',
 'تعاونية متخصصة في زراعة وتسويق الأعشاب الطبية والعطرية العضوية', 
 'Coopérative spécialisée dans la culture et la commercialisation des herbes médicinales et aromatiques biologiques', 
 'Cooperative specialized in growing and marketing organic medicinal and aromatic herbs',
 'Oriental', 'Oujda', 'Zone agricole Sidi Yahya, Oujda', '+212536890123', 'info@herbesbio.ma', 'https://herbesbio.ma',
 2017, 34, 'LIC-2017-009', true, false, 'https://example.com/coop9_logo.jpg', 'https://example.com/coop9_cover.jpg',
 '["الأعشاب الطبية", "الزيوت العطرية", "المنتجات العضوية"]', '["إيكوسيرت", "تجارة عادلة"]', NOW(), NOW());


-- 3. Insert Categories (10 categories with some hierarchy)
INSERT INTO "categories" (
    id, name_ar, name_fr, name_en, description_ar, description_fr, description_en,
    slug, icon, image, color, "parentId", "isActive", featured, "createdAt", "updatedAt"
) VALUES 
('cat_001', 'الزيوت الطبيعية', 'Huiles Naturelles', 'Natural Oils', 'زيوت طبيعية عضوية', 'Huiles naturelles biologiques', 'Organic natural oils',
 'natural-oils', '🫒', 'https://example.com/cat_oils.jpg', '#8B4513', NULL, true, true, NOW(), NOW()),

('cat_002', 'زيت الأركان', 'Huile d''Argan', 'Argan Oil', 'زيت الأركان المغربي الأصلي', 'Huile d''argan marocaine authentique', 'Authentic Moroccan argan oil',
 'argan-oil', '🌟', 'https://example.com/cat_argan.jpg', '#FFD700', 'cat_001', true, true, NOW(), NOW()),

('cat_003', 'التمور والفواكه المجففة', 'Dattes et Fruits Séchés', 'Dates and Dried Fruits', 'تمور وفواكه مجففة طبيعية', 'Dattes et fruits séchés naturels', 'Natural dates and dried fruits',
 'dates-dried-fruits', '🌴', 'https://example.com/cat_dates.jpg', '#8B4513', NULL, true, true, NOW(), NOW()),

('cat_004', 'تمور المجول', 'Dattes Medjool', 'Medjool Dates', 'تمور المجول الفاخرة', 'Dattes Medjool de luxe', 'Premium Medjool dates',
 'medjool-dates', '👑', 'https://example.com/cat_medjool.jpg', '#8B0000', 'cat_003', true, true, NOW(), NOW()),

('cat_005', 'الحرف التقليدية', 'Artisanat Traditionnel', 'Traditional Crafts', 'حرف تقليدية مغربية أصيلة', 'Artisanat traditionnel marocain authentique', 'Authentic Moroccan traditional crafts',
 'traditional-crafts', '🎨', 'https://example.com/cat_crafts.jpg', '#B8860B', NULL, true, false, NOW(), NOW()),

('cat_006', 'السجاد والنسيج', 'Tapis et Textile', 'Carpets and Textiles', 'سجاد ومنسوجات يدوية', 'Tapis et textiles artisanaux', 'Handmade carpets and textiles',
 'carpets-textiles', '🧶', 'https://example.com/cat_carpets.jpg', '#800080', 'cat_005', true, false, NOW(), NOW()),

('cat_007', 'مستحضرات التجميل', 'Cosmétiques', 'Cosmetics', 'مستحضرات تجميل طبيعية', 'Cosmétiques naturels', 'Natural cosmetics',
 'cosmetics', '💄', 'https://example.com/cat_cosmetics.jpg', '#FF69B4', NULL, true, false, NOW(), NOW()),

('cat_008', 'العسل والمربى', 'Miel et Confitures', 'Honey and Jams', 'عسل طبيعي ومربيات منزلية', 'Miel naturel et confitures artisanales', 'Natural honey and homemade jams',
 'honey-jams', '🍯', 'https://example.com/cat_honey.jpg', '#FFA500', NULL, true, false, NOW(), NOW()),

('cat_009', 'التوابل والأعشاب', 'Épices et Herbes', 'Spices and Herbs', 'توابل وأعشاب طبيعية', 'Épices et herbes naturelles', 'Natural spices and herbs',
 'spices-herbs', '🌿', 'https://example.com/cat_spices.jpg', '#228B22', NULL, true, false, NOW(), NOW()),

('cat_010', 'منتجات الفخار', 'Poterie', 'Pottery', 'فخار مغربي تقليدي', 'Poterie marocaine traditionnelle', 'Traditional Moroccan pottery',
 'pottery', '🏺', 'https://example.com/cat_pottery.jpg', '#8B4513', 'cat_005', true, false, NOW(), NOW());

-- 4. Insert Products (10 products)
INSERT INTO "products" (
    id, sku, name_ar, name_fr, name_en, description_ar, description_fr, description_en,
    price, "originalPrice", currency, stock, "minStock", unit, weight, dimensions,
    "isActive", featured, "bestSeller", "newProduct", organic,
    tags, specifications, images, "cooperativeId", "categoryId", "createdAt", "updatedAt"
) VALUES 
('prod_001', 'ARG-OIL-250ML-001', 'زيت الأركان الطبيعي 250مل', 'Huile d''Argan Naturelle 250ml', 'Natural Argan Oil 250ml',
 'زيت الأركان المغربي الأصلي المضغوط على البارد', 'Huile d''argan marocaine authentique pressée à froid', 'Authentic Moroccan cold-pressed argan oil',
 299.00, 350.00, 'MAD', 50, 10, 'bottle', 0.25, '{"length": 5, "width": 5, "height": 15}',
 true, true, true, false, true,
 '["طبيعي", "عضوي", "مضغوط على البارد", "للبشرة", "للشعر"]', '{"Origin": "Essaouira", "Extraction": "Cold Pressed", "Certification": "Organic"}',
 '["https://example.com/prod1_1.jpg", "https://example.com/prod1_2.jpg"]', 'coop_001', 'cat_002', NOW(), NOW()),

('prod_002', 'DATE-MEDJOOL-1KG-001', 'تمور المجول الفاخرة 1كغ', 'Dattes Medjool Premium 1kg', 'Premium Medjool Dates 1kg',
 'تمور المجول الطبيعية الفاخرة من واحات زاكورة', 'Dattes Medjool naturelles premium des oasis de Zagora', 'Premium natural Medjool dates from Zagora oasis',
 180.00, 220.00, 'MAD', 30, 5, 'kg', 1.0, '{"length": 20, "width": 15, "height": 8}',
 true, true, true, false, true,
 '["مجول", "فاخر", "طبيعي", "زاكورة", "حلو"]', '{"Origin": "Zagora", "Variety": "Medjool", "Grade": "Premium"}',
 '["https://example.com/prod2_1.jpg", "https://example.com/prod2_2.jpg", "https://example.com/prod2_3.jpg"]', 'coop_002', 'cat_004', NOW(), NOW()),

('prod_003', 'CARPET-BERBER-MED-001', 'سجادة بربرية متوسطة', 'Tapis Berbère Moyen', 'Medium Berber Carpet',
 'سجادة بربرية تقليدية محبوكة يدوياً', 'Tapis berbère traditionnel tissé à la main', 'Traditional handwoven Berber carpet',
 1200.00, 1500.00, 'MAD', 8, 2, 'piece', 5.0, '{"length": 200, "width": 150, "height": 2}',
 true, false, false, true, false,
 '["بربري", "يدوي", "تقليدي", "أصيل", "صوف"]', '{"Material": "Wool", "Technique": "Handwoven", "Pattern": "Traditional Berber"}',
 '["https://example.com/prod3_1.jpg", "https://example.com/prod3_2.jpg"]', 'coop_003', 'cat_006', NOW(), NOW()),

('prod_004', 'ARGAN-COSM-CREAM-001', 'كريم الأركان للوجه', 'Crème Visage à l''Argan', 'Argan Face Cream',
 'كريم طبيعي للوجه بزيت الأركان', 'Crème naturelle pour le visage à l''huile d''argan', 'Natural face cream with argan oil',
 89.00, NULL, 'MAD', 25, 5, 'jar', 0.05, '{"length": 6, "width": 6, "height": 4}',
 true, false, false, true, true,
 '["طبيعي", "أركان", "مرطب", "للوجه", "مضاد للشيخوخة"]', '{"Skin Type": "All Types", "Main Ingredient": "Argan Oil", "Volume": "50ml"}',
 '["https://example.com/prod4_1.jpg"]', 'coop_001', 'cat_007', NOW(), NOW()),

('prod_005', 'HONEY-PURE-500G-001', 'عسل طبيعي خالص 500غ', 'Miel Pur Naturel 500g', 'Pure Natural Honey 500g',
 'عسل طبيعي خالص من الجبال المغربية', 'Miel naturel pur des montagnes marocaines', 'Pure natural honey from Moroccan mountains',
 120.00, NULL, 'MAD', 40, 8, 'jar', 0.5, '{"length": 8, "width": 8, "height": 10}',
 true, false, true, false, true,
 '["عسل", "طبيعي", "جبلي", "خالص", "مغربي"]', '{"Source": "Mountain Flowers", "Type": "Multifloral", "Region": "Middle Atlas"}',
 '["https://example.com/prod5_1.jpg", "https://example.com/prod5_2.jpg"]', 'coop_002', 'cat_008', NOW(), NOW()),

('prod_006', 'POTTERY-TAGINE-LRG-001', 'طاجين فخاري كبير', 'Tajine en Terre Cuite Grand', 'Large Clay Tagine',
 'طاجين فخاري تقليدي كبير الحجم', 'Tajine traditionnel en terre cuite de grande taille', 'Traditional large clay tagine',
 250.00, NULL, 'MAD', 15, 3, 'piece', 3.5, '{"length": 35, "width": 35, "height": 20}',
 true, false, false, false, false,
 '["طاجين", "فخار", "تقليدي", "طبخ", "مغربي"]', '{"Material": "Clay", "Size": "Large", "Diameter": "35cm"}',
 '["https://example.com/prod6_1.jpg"]', 'coop_003', 'cat_010', NOW(), NOW()),

('prod_007', 'SPICE-MIX-RAS-001', 'خليط راس الحانوت', 'Mélange Ras El Hanout', 'Ras El Hanout Spice Mix',
 'خليط التوابل المغربي التقليدي راس الحانوت', 'Mélange d''épices marocain traditionnel Ras El Hanout', 'Traditional Moroccan Ras El Hanout spice blend',
 45.00, NULL, 'MAD', 60, 10, 'package', 0.1, '{"length": 10, "width": 5, "height": 15}',
 true, false, false, false, true,
 '["توابل", "راس الحانوت", "مغربي", "تقليدي", "خليط"]', '{"Ingredients": "20+ spices", "Origin": "Morocco", "Weight": "100g"}',
 '["https://example.com/prod7_1.jpg"]', 'coop_002', 'cat_009', NOW(), NOW()),

('prod_008', 'ARGAN-OIL-100ML-001', 'زيت الأركان الصغير 100مل', 'Huile d''Argan Petite 100ml', 'Small Argan Oil 100ml',
 'زيت الأركان الطبيعي عبوة صغيرة للسفر', 'Huile d''argan naturelle petit format pour voyage', 'Natural argan oil travel size',
 150.00, NULL, 'MAD', 75, 15, 'bottle', 0.1, '{"length": 4, "width": 4, "height": 12}',
 true, false, false, false, true,
 '["أركان", "صغير", "سفر", "طبيعي", "عضوي"]', '{"Size": "Travel", "Volume": "100ml", "Type": "Cosmetic Grade"}',
 '["https://example.com/prod8_1.jpg"]', 'coop_001', 'cat_002', NOW(), NOW()),

('prod_009', 'DATE-DEGLET-500G-001', 'تمور دقلة نور 500غ', 'Dattes Deglet Nour 500g', 'Deglet Nour Dates 500g',
 'تمور دقلة نور الطبيعية الشفافة', 'Dattes Deglet Nour naturelles translucides', 'Natural translucent Deglet Nour dates',
 80.00, NULL, 'MAD', 45, 8, 'package', 0.5, '{"length": 18, "width": 12, "height": 6}',
 true, false, false, false, true,
 '["دقلة نور", "شفاف", "طبيعي", "حلو", "صحي"]', '{"Variety": "Deglet Nour", "Quality": "Premium", "Origin": "Oasis"}',
 '["https://example.com/prod9_1.jpg"]', 'coop_002', 'cat_003', NOW(), NOW()),

('prod_010', 'TEXTILE-SCARF-SLK-001', 'وشاح حريري مطرز', 'Foulard Soie Brodé', 'Embroidered Silk Scarf',
 'وشاح حريري مطرز بخيوط ذهبية', 'Foulard en soie brodé de fils dorés', 'Silk scarf embroidered with golden threads',
 320.00, 400.00, 'MAD', 12, 2, 'piece', 0.05, '{"length": 180, "width": 90, "height": 0.1}',
 true, true, false, true, false,
 '["حرير", "مطرز", "فاخر", "ذهبي", "أنيق"]', '{"Material": "Silk", "Technique": "Hand Embroidered", "Thread": "Golden"}',
 '["https://example.com/prod10_1.jpg", "https://example.com/prod10_2.jpg"]', 'coop_003', 'cat_006', NOW(), NOW());

-- 5. Insert Orders (10 orders)
INSERT INTO "orders" (
    id, "orderNumber", "userId", status, subtotal, "shippingCost", tax, total,
    "shippingAddress", "paymentMethod", "paymentStatus", "trackingNumber", "createdAt", "updatedAt"
) VALUES 
('order_001', 'ORD-2024-001', 'user_005', 'DELIVERED', 299.00, 30.00, 0.00, 329.00,
 '{"firstName": "Hassan", "lastName": "Idrissi", "address": "Rue 10, Hay Riad", "city": "Rabat", "region": "Rabat-Salé-Kénitra", "phone": "+212600567890"}',
 'cash_on_delivery', 'paid', 'TRK-001-2024', NOW() - INTERVAL '10 days', NOW() - INTERVAL '5 days'),

('order_002', 'ORD-2024-002', 'user_006', 'SHIPPED', 180.00, 25.00, 0.00, 205.00,
 '{"firstName": "Khadija", "lastName": "Amrani", "address": "Avenue Mohammed V", "city": "Casablanca", "region": "Casablanca-Settat", "phone": "+212600678901"}',
 'bank_transfer', 'paid', 'TRK-002-2024', NOW() - INTERVAL '3 days', NOW() - INTERVAL '2 days'),

('order_003', 'ORD-2024-003', 'user_007', 'CONFIRMED', 1200.00, 50.00, 0.00, 1250.00,
 '{"firstName": "Omar", "lastName": "Tazi", "address": "Residence Al Manar", "city": "Fès", "region": "Fès-Meknès", "phone": "+212600789012"}',
 'cash_on_delivery', 'pending', NULL, NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day'),

('order_004', 'ORD-2024-004', 'user_008', 'PENDING', 89.00, 20.00, 0.00, 109.00,
 '{"firstName": "Nadia", "lastName": "Benjelloun", "address": "Quartier Gueliz", "city": "Marrakech", "region": "Marrakech-Safi", "phone": "+212600890123"}',
 'cash_on_delivery', 'pending', NULL, NOW() - INTERVAL '6 hours', NOW() - INTERVAL '6 hours'),

('order_005', 'ORD-2024-005', 'user_010', 'DELIVERED', 370.00, 35.00, 0.00, 405.00,
 '{"firstName": "Samira", "lastName": "Bennani", "address": "Boulevard Zerktouni", "city": "Casablanca", "region": "Casablanca-Settat", "phone": "+212601012345"}',
 'bank_transfer', 'paid', 'TRK-005-2024', NOW() - INTERVAL '15 days', NOW() - INTERVAL '10 days'),

('order_006', 'ORD-2024-006', 'user_005', 'CANCELLED', 250.00, 30.00, 0.00, 280.00,
 '{"firstName": "Hassan", "lastName": "Idrissi", "address": "Rue 10, Hay Riad", "city": "Rabat", "region": "Rabat-Salé-Kénitra", "phone": "+212600567890"}',
 'cash_on_delivery', 'failed', NULL, NOW() - INTERVAL '20 days', NOW() - INTERVAL '18 days'),

('order_007', 'ORD-2024-007', 'user_006', 'DELIVERED', 165.00, 25.00, 0.00, 190.00,
 '{"firstName": "Khadija", "lastName": "Amrani", "address": "Avenue Mohammed V", "city": "Casablanca", "region": "Casablanca-Settat", "phone": "+212600678901"}',
 'cash_on_delivery', 'paid', 'TRK-007-2024', NOW() - INTERVAL '8 days', NOW() - INTERVAL '4 days'),

('order_008', 'ORD-2024-008', 'user_007', 'SHIPPED', 45.00, 15.00, 0.00, 60.00,
 '{"firstName": "Omar", "lastName": "Tazi", "address": "Residence Al Manar", "city": "Fès", "region": "Fès-Meknès", "phone": "+212600789012"}',
 'bank_transfer', 'paid', 'TRK-008-2024', NOW() - INTERVAL '2 days', NOW() - INTERVAL '1 day'),

('order_009', 'ORD-2024-009', 'user_008', 'DELIVERED', 320.00, 30.00, 0.00, 350.00,
 '{"firstName": "Nadia", "lastName": "Benjelloun", "address": "Quartier Gueliz", "city": "Marrakech", "region": "Marrakech-Safi", "phone": "+212600890123"}',
 'cash_on_delivery', 'paid', 'TRK-009-2024', NOW() - INTERVAL '12 days', NOW() - INTERVAL '7 days'),

('order_010', 'ORD-2024-010', 'user_010', 'CONFIRMED', 230.00, 25.00, 0.00, 255.00,
 '{"firstName": "Samira", "lastName": "Bennani", "address": "Boulevard Zerktouni", "city": "Casablanca", "region": "Casablanca-Settat", "phone": "+212601012345"}',
 'bank_transfer', 'pending', NULL, NOW() - INTERVAL '12 hours', NOW() - INTERVAL '12 hours');

-- 6. Insert Order Items (corresponding to the orders above)
INSERT INTO "order_items" (
    id, "orderId", "productId", quantity, price, total
) VALUES 
('item_001', 'order_001', 'prod_001', 1, 299.00, 299.00),
('item_002', 'order_002', 'prod_002', 1, 180.00, 180.00),
('item_003', 'order_003', 'prod_003', 1, 1200.00, 1200.00),
('item_004', 'order_004', 'prod_004', 1, 89.00, 89.00),
('item_005', 'order_005', 'prod_001', 1, 299.00, 299.00),
('item_006', 'order_005', 'prod_008', 1, 150.00, 150.00),
('item_007', 'order_006', 'prod_006', 1, 250.00, 250.00),
('item_008', 'order_007', 'prod_009', 2, 80.00, 160.00),
('item_009', 'order_008', 'prod_007', 1, 45.00, 45.00),
('item_010', 'order_009', 'prod_010', 1, 320.00, 320.00),
('item_011', 'order_010', 'prod_008', 1, 150.00, 150.00),
('item_012', 'order_010', 'prod_009', 1, 80.00, 80.00);

-- 7. Insert Reviews (10 reviews)
INSERT INTO "reviews" (
    id, "userId", "productId", rating, comment, verified, "createdAt", "updatedAt"
) VALUES 
('review_001', 'user_005', 'prod_001', 5, 'منتج ممتاز، زيت الأركان طبيعي ومفيد جداً للبشرة', true, NOW() - INTERVAL '5 days', NOW() - INTERVAL '5 days'),
('review_002', 'user_006', 'prod_002', 5, 'Dattes de très bonne qualité, très sucrées et délicieuses', true, NOW() - INTERVAL '2 days', NOW() - INTERVAL '2 days'),
('review_003', 'user_007', 'prod_004', 4, 'Good cream, makes my skin soft. Could be a bit more moisturizing.', false, NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day'),
('review_004', 'user_008', 'prod_010', 5, 'وشاح جميل جداً، الحرير ناعم والتطريز رائع', true, NOW() - INTERVAL '7 days', NOW() - INTERVAL '7 days'),
('review_005', 'user_010', 'prod_001', 4, 'Bonne huile d''argan, un peu chère mais de qualité', true, NOW() - INTERVAL '10 days', NOW() - INTERVAL '10 days'),
('review_006', 'user_005', 'prod_008', 4, 'حجم مناسب للسفر، نفس جودة العبوة الكبيرة', false, NOW() - INTERVAL '3 days', NOW() - INTERVAL '3 days'),
('review_007', 'user_006', 'prod_009', 5, 'Dattes Deglet Nour parfaites, bien sucrées et moelleuses', true, NOW() - INTERVAL '4 days', NOW() - INTERVAL '4 days'),
('review_008', 'user_007', 'prod_007', 5, 'Amazing spice blend! Perfect for Moroccan cooking.', false, NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day'),
('review_009', 'user_008', 'prod_005', 4, 'عسل طبيعي لذيذ، لكن السعر مرتفع قليلاً', false, NOW() - INTERVAL '6 days', NOW() - INTERVAL '6 days'),
('review_010', 'user_010', 'prod_002', 5, 'Les meilleures dattes Medjool que j''ai goûtées !', false, NOW() - INTERVAL '8 days', NOW() - INTERVAL '8 days');

-- Verification queries (optional - uncomment to check data)
-- SELECT 'Users' as table_name, COUNT(*) as count FROM "users"
-- UNION ALL SELECT 'Cooperatives', COUNT(*) FROM "cooperatives"
-- UNION ALL SELECT 'Categories', COUNT(*) FROM "categories"
-- UNION ALL SELECT 'Products', COUNT(*) FROM "products"
-- UNION ALL SELECT 'Orders', COUNT(*) FROM "orders"
-- UNION ALL SELECT 'Order Items', COUNT(*) FROM "order_items"
-- UNION ALL SELECT 'Reviews', COUNT(*) FROM "reviews";