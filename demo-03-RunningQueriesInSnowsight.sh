
				demo-03-RunningQueriesInSnowsight


SELECT * FROM MOVIES;

# Show the results and the visualization on the right hand-side of the results

Rating 

Budget

# Walk through the visualizations

# Perform some filtering operations using these visualizations


SELECT id, title, release_date, director_id, budget 
FROM MOVIES WHERE budget >= 260000000;

# Let's plot this result and analyse
# Click on Chart, make sure we disable Query and Objects so that the charts look bigger
# Choose the following:
	# Chart type - Bar
	# Data:
		# Budget 
		# X-Axis - Title
	# Appearance:
		# Order bars by - Bar size
		# Order direction - Ascending
		# Series direction - Ascending
	# Tick on both Label X-Axis and Label Y-Axis


SELECT
    *
FROM
    MOVIES
WHERE
    release_date between '2012-01-01' and '2012-12-31';


SELECT
    MAX(release_date),
    COUNT(*)
FROM
    MOVIES
GROUP BY
    :datebucket(release_date)
ORDER BY
    MAX(release_date) ASC

# Change the group by option using the drop down
# Change to Quarter and show result
# Change to Year and show result

SELECT
    *
FROM
    movies
WHERE
    release_date = :daterange
ORDER BY
    release_date;


# Now we see it shows 'Query produced no results'
# Now on the top left side it is written 'Last day'. CLick on that and change that to 'All time'
# Now we see all the rows are displayed
# Now click on 'Custom' instead of 'All time' and choose Jan 01 2016 to Dec 1 2016
# Now we can see all the movies in the selected range


SELECT * FROM directors 
WHERE name = 'James Cameron' 
OR name ='Luc Besson' 
OR name ='John Woo';

# Click on Query Details -> ... -> Query Profile

# Show the query execution graph


SELECT * FROM directors 
WHERE name LIKE 'Steven%';


SELECT title, directors.name 
FROM movies JOIN directors ON directors.id = movies.director_id
WHERE directors.name LIKE 'Steven%'
ORDER BY directors.name;


# Click on Query Details -> ... -> Query Profile

# Show the query execution graph

# Run the same query again - results will be retrieved from cache

# Click on Query Details -> ... -> Query Profile

# Show the query execution graph - will show results reuse














