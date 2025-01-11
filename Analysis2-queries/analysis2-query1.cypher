// Count releases and libraries per year
MATCH (lib:Artifact)-[:relationship_AR]->(rel:Release)
WITH rel, lib, apoc.date.format(rel.timestamp, 'ms', 'yyyy') AS year
RETURN year,
COUNT(DISTINCT lib) AS libraries_per_year,
COUNT(DISTINCT rel) AS releases_per_year
ORDER BY year ASC
