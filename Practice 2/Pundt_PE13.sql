/*NAME: Griffin Pundt
CLASS: ISTE-230
ASSIGNMENT: PE13

-----------------------------------------------------------------------------
1)show mom you have her recipes stored*/
SELECT name
FROM recipe
WHERE source = "Mom";

/*-----------------------------------------------------------------------------
2)show recipes that have fewer than 800 calories*/
SELECT name
FROM recipe
WHERE recipeID IN (
	SELECT recipeID
	FROM nutrition
	WHERE name = "calories" and quantity < 800);
/*First finds recipeID's from nutrition that are less than 800 calories
then prints all the names of those recipeID's*/
	
	
	
/*-----------------------------------------------------------------------------
3) Print the ingredients and their quantity of the recipe starting with Beef Paremesan*/
SELECT i.name, l.quantity
FROM ingredient i
INNER JOIN ingredientlist l
ON l.recipeID = 1 and i.ingredientID = l.ingredientID;


/*-----------------------------------------------------------------------------
4) print all vegetarian dishes without beef, pork, chicken, or lamb*/
SELECT name
FROM recipe
WHERE recipeID NOT IN (
	SELECT recipeID
	FROM ingredientlist
	WHERE ingredientID in (
		SELECT ingredientID
		FROM ingredient
		WHERE type = "beef" OR type = "pork" OR type = "chicken" OR type = "lamb"));
/*First finds ingredientID's of ingredients that are meat
Then finds recipes with ingredientlists that contain those meats
Then prints names of those recipes		*/


/*-----------------------------------------------------------------------------
5)print recipes with fish that are fewer than 700 calories*/

SELECT name
FROM recipe
WHERE recipeID in (
	SELECT recipeID
	FROM ingredientlist
	WHERE ingredientID IN (
		SELECT ingredientID
		FROM ingredient
		WHERE type = "fish") AND recipeID IN (
			SELECT recipeID
			FROM nutrition
			WHERE name = "calories" AND quantity < 700));
/*First finds recipeID's of recipes that are less than 700 calories
Then finds ingredientID's of fish ingredients
Then finds recipeID's of fish recipes that are less than 700 calories
Then prints names of those recipes*/