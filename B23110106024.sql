CREATE DATABASE library_db;
CREATE TABLE books(
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    year_published INT,
    isAvailable BOOLEAN,
    price NUMERIC(10, 2),
    publication VARCHAR(255)
);

INSERT INTO books(title, author, year_published, isAvailable, price, publication)
values
    ('The Great Escape', 'John Maxwell', 2010, true, 499.00, 'Penguin'),
('A Tale of Two Cities', 'Charles Dickens', 1859, true, 299.00, 'HarperCollins'),
('1984', 'George Orwell', 1949, true, 549.00, 'ABC'),
('The Book Thief', 'Markus Zusak', 2005, false, 599.00, 'XYZ'),
('To Kill a Mockingbird', 'Harper Lee', 1960, true, 449.00, 'Penguin'),
('The Silent Patient', 'Alex Michaelides', 2019, true, 559.00, 'XYZ'),
('Brave New World', 'Aldous Huxley', 1932, false, 325.00, 'RandomHouse'),
('The Midnight Library', 'Matt Haig', 2020, true, 599.00, 'Vintage'),
('The Alchemist', 'Paulo Coelho', 1988, true, 349.00, 'HarperCollins'),
('The Kite Runner', 'Khaled Hosseini', 2003, false, 379.00, 'ABC'),
('Atomic Habits', 'James Clear', 2018, true, 499.00, 'Penguin'),
('The Psychology of Money', 'Morgan Housel', 2020, true, 529.00, 'HarperBusiness'),
('Sapiens', 'Yuval Noah Harari', 2011, true, 569.00, 'Vintage'),
('Ikigai', 'Francesc Miralles', 2016, true, 289.00, 'Penguin'),
('Deep Work', 'Cal Newport', 2016, false, 475.00, 'ABC');

SELECT * FROM books
WHERE year_published > 2000;

-- 6. Select books priced under 599.00, ordered by price descending
SELECT * FROM books
WHERE price < 599.00
ORDER BY price DESC;


-- 7. Select top 3 most expensive book
SELECT * FROM books
ORDER BY price DESC
LIMIT 3;

-- 8. Select 2 books skipping first 2, ordered by year descending
SELECT * FROM books
ORDER BY year_published DESC
OFFSET 2
LIMIT 2;

-- 9. Select all books from publication 'XYZ', ordered by title 
SELECT * FROM books
WHERE publication = 'XYZ'
ORDER BY title ASC;





