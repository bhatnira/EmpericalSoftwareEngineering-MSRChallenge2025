// Calculate the average number of dependencies per library per year
MATCH (lib:Artifact)-[:relationship_AR]->(rel:Release)
WITH lib, rel, apoc.date.format(rel.timestamp, 'ms', 'yyyy') AS year


// Find all dependencies of each release
MATCH (rel)-[dep:dependency]->(depLib:Artifact)
WITH lib, year, COUNT(dep) AS numDependencies


// Aggregate the data by year
WITH year, AVG(numDependencies) AS avgDependenciesPerLibrary
RETURN year, avgDependenciesPerLibrary
ORDER BY year ASC




// Calculate the average number of dependencies per library per quarter
MATCH (lib:Artifact)-[:relationship_AR]->(rel:Release)
WITH lib, rel,
apoc.date.format(rel.timestamp, 'ms', 'yyyy') AS year,
CASE
WHEN apoc.date.format(rel.timestamp, 'ms', 'MM') IN ['01', '02', '03'] THEN 'Q1'
WHEN apoc.date.format(rel.timestamp, 'ms', 'MM') IN ['04', '05', '06'] THEN 'Q2'
WHEN apoc.date.format(rel.timestamp, 'ms', 'MM') IN ['07', '08', '09'] THEN 'Q3'
WHEN apoc.date.format(rel.timestamp, 'ms', 'MM') IN ['10', '11', '12'] THEN 'Q4'
END AS quarter


// Find all dependencies of each release
MATCH (rel)-[dep:dependency]->(depLib:Artifact)
WITH lib, year, quarter, COUNT(dep) AS numDependencies


// Aggregate the data by year and quarter
WITH year + '-' + quarter AS year_quarter, AVG(numDependencies) AS avgDependenciesPerLibrary
RETURN year_quarter, avgDependenciesPerLibrary
ORDER BY year_quarter ASC
