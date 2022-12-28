DROP DATABASE IF EXISTS recipes;
CREATE DATABASE recipes;
USE recipes;

--
-- Table structure for table ingredient_list
--

DROP TABLE IF EXISTS ingredientList;
CREATE TABLE ingredientList (
  recipeID int(11) NOT NULL default '0',
  ingredientID int(11) NOT NULL default '0',
  quantity double default NULL,
  CONSTRAINT ingredientList_pk PRIMARY KEY(recipeID,ingredientID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table data for table ingredient_list
--

INSERT INTO ingredientList VALUES (1,1,1.5),(1,2,1),(1,3,1),(1,4,1),(1,5,0.5),(1,6,0.125),(1,7,1),(1,8,0.5),(1,9,1),(1,10,1),(1,11,0.125),(2,6,0.125),(2,10,2),(2,18,1),(2,22,1),(2,23,0.5),(2,24,0.25),(2,25,0.25),(2,26,1),(2,27,1),(2,28,0.125),(2,29,0.25),(2,30,0.25),(2,31,1),(2,32,1),(3,13,4),(3,15,2.5),(3,16,0.75),(3,17,21),(3,18,1),(3,20,0.5),(3,21,1),(4,5,0.125),(4,9,0.25),(4,21,1),(4,33,1),(4,34,2),(4,35,1),(4,36,1),(4,37,1),(4,38,0.125),(4,39,0.25),(4,40,0.25),(5,10,1),(5,13,1),(5,20,2.5),(5,23,0.125),(5,31,0.125),(5,32,0.25),(5,41,3),(5,42,0.125),(5,43,0.5);


--
-- Table structure for table ingredient
--

DROP TABLE IF EXISTS ingredient;
CREATE TABLE ingredient (
  ingredientID int(11) NOT NULL,
  name varchar(100) default NULL,
  cost double default NULL,
  type varchar(20) default NULL,
  CONSTRAINT ingredient_pk PRIMARY KEY(ingredientID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table data for table ingredient
--

INSERT INTO ingredient VALUES (1,'beef cube steak',3,'beef'),(2,'onion, sliced into thin rings',0.5,'vegetable'),(3,'green bell pepper, sliced in rings',0.5,'vegetable'),(4,'Italian seasoned bread crumbs',0.1,'bread'),(5,'grated Parmesan cheese',5,'cheese'),(6,'olive oil',5,'oil'),(7,'spaghetti sauce',3,'sauce'),(8,'shredded mozzarella cheese',3,'cheese'),(9,'angel hair pasta',1,'pasta'),(10,'garlic',0.1,'vegetable'),(11,'butter',2,'oil'),(12,'whole egg',0.15,'egg'),(13,'egg yolk',0.15,'egg'),(14,'egg white',0.15,'egg'),(15,'milk',0.2,'dairy'),(16,'sugar',0.2,'sugar'),(17,'biscuit',0.2,'bread'),(18,'lemon zest',0.5,'fruit'),(19,'orange zest',0.5,'fruit'),(20,'flour',0.5,'bread'),(21,'heavy cream',1,'fat'),(22,'linguini ',1,'pasta'),(23,'Italian seasoning ',0.15,'herb'),(24,'dried thyme',0.15,'herb'),(25,'red pepper flakes',0.15,'herb'),(26,'crushed tomatoes',1,'vegetable'),(27,'black olives',1,'vegetable'),(28,'baby clams',3,'fish'),(29,'salad shrimp',10,'fish'),(30,'scallops',8,'fish'),(31,'salt',0.01,'herb'),(32,'black pepper',0.05,'herb'),(33,'fish fumet',10,'fish'),(34,'lobster',18,'fish'),(35,'bouillon',1,'sauce'),(36,'white wine',10,'wine'),(37,'chervil',10,'wine'),(38,'tarragon',5,'herb'),(39,'shallots',3,'vegetable'),(40,'mustard',2,'condiment'),(41,'whole chicken',1.75,'chicken'),(42,'paprika',5,'herb'),(43,'beer',1,'alcohol');


--
-- Table structure for table nutrition
--

DROP TABLE IF EXISTS nutrition;
CREATE TABLE nutrition (
  name varchar(100) NOT NULL default '',
  quantity double default NULL,
  unit varchar(20) default NULL,
  recipeID int(11) NOT NULL default '0',
  CONSTRAINT nutrition_pk PRIMARY KEY(recipeID,name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table data for table nutrition
--

INSERT INTO nutrition VALUES ('calories',1167,'calories',1),('carbohydrates',45,'grams',1),('fat',23,'grams',1),('protein',32,'grams',1),('calories',532,'calories',2),('carbohydrates',59,'grams',2),('fat',12,'grams',2),('protein',29,'grams',2),('calories',612,'calories',3),('carbohydrates',45,'grams',3),('fat',49,'grams',3),('protein',4,'grams',3),('calories',1215,'calories',4),('carbohydrates',67,'grams',4),('fat',57,'grams',4),('protein',57,'grams',4),('calories',750,'calories',5),('carbohydrates',45,'grams',5),('fat',30,'grams',5),('protein',30,'grams',5);


--
-- Table structure for table recipe
--

DROP TABLE IF EXISTS recipe;
CREATE TABLE recipe (
  recipeID int(11) NOT NULL,
  source varchar(60) default NULL,
  comments varchar(255) default NULL,
  name varchar(100) default NULL,
  numServings int(11) default NULL,
  CONSTRAINT recipe_pk PRIMARY KEY(recipeID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table data for table recipe
--


INSERT INTO recipe VALUES (1,'julia Childs','','Beef Parmesan with Garlic Angel Hair Pasta',4),(2,'Mom','','Linguine Pescadoro',4),(3,'Mom','','Zuppa Inglese',4),(4,'Paul Prudhome','','Lobster Thermadore',4),(5,'Cooks.Com','','Crispy Fried Chicken',4);

--
-- Table structure for table step
--

DROP TABLE IF EXISTS step;
CREATE TABLE step (
  stepNumber int(11) NOT NULL default '0',
  stepDescription varchar(255) default NULL,
  recipeID int(11) NOT NULL default '0',
  CONSTRAINT step_pk PRIMARY KEY(recipeID,stepNumber)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table data for table steps
--

INSERT INTO step VALUES (1,'Preheat oven to 350 degrees F (175 degrees C).',1),(2,'Cut cube steak into serving size pieces. Coat meat with the bread crumbs and parmesan cheese. Heat olive oil in a large frying pan, and saute 1 teaspoon of the garlic for 3 minutes.',1),(3,'Quick fry (brown quickly on both sides) meat. Place meat in a casserole baking dish, slightly overlapping edges. Place onion rings and peppers on top of meat, and pour marinara sauce over all',1),(4,'Bake at 350 degrees F (175 degrees C) for 30 to 45 minutes, depending on the thickness of the meat. Sprinkle mozzarella over meat and leave in the oven till bubbly.',1),(5,'Boil pasta al dente. Drain, and toss in butter and 1 teaspoon garlic. For a stronger garlic taste, season with garlic powder. Top with grated parmesan and parsley for color. Serve meat and sauce atop a mound of pasta!',1),(1,'In a heavy saucepan over medium heat saute garlic in olive oil until garlic softens.',2),(2,'Add Italian seasoning, thyme, crushed red pepper flakes, crushed tomatoes, black olives, and the juice from both cans of clams. Simmer for 15 minutes.',2),(3,'Mix in canned clams, shrimp, scallops, lemon zest, and salt and pepper to taste.',2),(4,'Simmer for an additional 15 minutes or until shrimp and clams are cooked.',2),(5,'In a large pot of boiling salted water cook linguini until al dente. Drain.',2),(6,'Toss cooked and drained linguine pasta over seafood sauce. Serve warm.',2),(1,'Warm up the milk in a nonstick sauce pan',3),(2,'In a large bowl beat the egg yolks with the sugar, add the flour and combine the ingredients until well mixed.',3),(3,'Add the milk, a little bit at the time to the egg mixture, mixing well.',3),(4,'Put the mixture into the sauce pan and cook it on the stove at a medium low heat. Mix the cream continuously with a wooden spoon. When it starts to thicken remove it from the heat and pour it on a large plate to cool off.',3),(5,'Stir the cream now and then so that the top doesn\'t harden.',3),(6,'Dip quickly both sides of the lady fingers in the liquor. Layer them one at the time in a glass bowl large enough to contain 7 biscuits.',3),(7,'Spread 1/3 of the cream and repeat the layer with lady fingers. Finish with the cream.',3),(1,'Split the live lobsters in two, lengthwise. Crack the shell of the claws and remove the gills.',4),(2,'Season the lobster halves with salt and roast in the oven for 15-20 minutes. Remove and dice the flesh from the claws and tails.',4),(3,'Prepare the stock using equal portions of meat juices, fish fumet, and white wine flavored with chervil, tarragon and chopped shallots.',4),(4,'Boil it down to a concentrated consistency, then add heavy cream and English mustard.',4),(5,'Boil the sauce for a few minutes, then whisk in some fresh butter (cold cut into cubes and in 1/3 of the volume of the sauce).',4),(6,'Pour a little of this sauce in the shells of the lobsters. Fill the shells with the flesh of the lobsters.',4),(7,'Cover with the remainder of the sauce, sprinkle with a little Parmesan cheese and brown rapidly in a very hot oven.',4),(1,'Combine flour and seasonings in bowl.',5),(2,'Combine egg yolks and beer.',5),(3,'Add gradually to dry ingredients.',5),(4,'Heat oil in deep fryer to 365 degrees.',5),(5,'Moisten chicken pieces. Dip in seasoned flour, then batter, then back in seasoned flour.',5),(6,'Fry in hot oil 15 to 18 minutes until well browned. Drain on paper.',5);

