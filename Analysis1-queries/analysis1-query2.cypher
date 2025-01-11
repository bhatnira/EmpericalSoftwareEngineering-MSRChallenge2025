
MATCH (release:Release)-[dep:dependency]->(artifact:Artifact)
WITH release, COUNT(dep) AS dependencies_count, apoc.date.format(release.timestamp, 'ms', 'yyyy') AS release_year
WITH release_year, avg(dependencies_count) AS average_dependencies
RETURN release_year, average_dependencies
ORDER BY release_year
