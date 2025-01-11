MATCH (lib:Artifact)-[:relationship_AR]->(rel:Release)
WITH rel, lib,
apoc.date.format(rel.timestamp, 'ms', 'yyyy') AS year,
CASE
WHEN apoc.date.format(rel.timestamp, 'ms', 'MM') IN ['01', '02', '03'] THEN 'Q1'
WHEN apoc.date.format(rel.timestamp, 'ms', 'MM') IN ['04', '05', '06'] THEN 'Q2'
WHEN apoc.date.format(rel.timestamp, 'ms', 'MM') IN ['07', '08', '09'] THEN 'Q3'
WHEN apoc.date.format(rel.timestamp, 'ms', 'MM') IN ['10', '11', '12'] THEN 'Q4'
END AS quarter
RETURN year + '-' + quarter AS year_quarter,
COUNT(DISTINCT lib) AS libraries_per_quarter,
COUNT(DISTINCT rel) AS releases_per_quarter
ORDER BY year_quarter ASC
