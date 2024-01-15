CREATE TABLE number_tbl
(
    val SMALLINT
);

INSERT INTO number_tbl
VALUES (1);
INSERT INTO number_tbl
VALUES (3);
INSERT INTO number_tbl
VALUES (5);

# No nulls
SELECT COUNT(*)   num_rows,
       COUNT(val) num_vals,
       SUM(val)   total,
       MAX(val)   max_val,
       AVG(val)   avg_val
FROM number_tbl;

INSERT INTO number_tbl
VALUES (NULL);

# With a null record
# sum(), max(), avg(), count(*) work the same
# count(val) differs because it counts only values, not rows
SELECT COUNT(*)   num_rows,
       COUNT(val) num_vals,
       SUM(val)   total,
       MAX(val)   max_val,
       AVG(val)   avg_val
FROM number_tbl;
