CREATE MATERIALIZED VIEW non_null_grade as (
	SELECT *
	FROM CourseRegistrations
	WHERE grade > 0
);

