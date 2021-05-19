CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT d.name AS name, s.size AS size
         FROM dogs AS d, sizes AS s
         WHERE d.height > s.min and d.height <= s.max;

-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_height AS
  SELECT p.child FROM parents p, dogs d
         WHERE p.parent = d.name
         ORDER BY d.height DESC;

-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT a.name as aname, b.name as bname, a.size as size
         FROM parents as pa, parents as pb, size_of_dogs as a, size_of_dogs as b
         WHERE pa.child = a.name and pb.child = b.name and
               pa.parent = pb.parent and a.size = b.size and
               a.name < b.name;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT aname || ' and ' || bname || ' are ' || size || ' siblings'
         FROM siblings;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks_helper(dogs, stack_height, last_height);

-- Add your INSERT INTOs here
INSERT INTO stacks_helper SELECT name, height, height FROM dogs;
INSERT INTO stacks_helper SELECT
       s.dogs || ', '|| d.name, s.stack_height + d.height, d.height
       FROM stacks_helper s, dogs d
       WHERE d.height > s.last_height;

INSERT INTO stacks_helper SELECT
       s.dogs || ', '|| d.name, s.stack_height + d.height, d.height
       FROM stacks_helper s, dogs d
       WHERE d.height > s.last_height;

INSERT INTO stacks_helper SELECT
       s.dogs || ', '|| d.name, s.stack_height + d.height, d.height
       FROM stacks_helper s, dogs d
       WHERE d.height > s.last_height;

-- SELECT * from stacks_helper;

CREATE TABLE stacks AS
  SELECT dogs, stack_height FROM stacks_helper
         WHERE stack_height > 170
         GROUP BY stack_height;
