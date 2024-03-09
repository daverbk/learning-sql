USE leetcode;

# Table: Activity
CREATE TABLE IF NOT EXISTS Activity
(
    machine_id    INT,
    process_id    INT,
    activity_type ENUM ('start', 'end'),
    timestamp     FLOAT
);

TRUNCATE TABLE Activity;

INSERT INTO Activity (machine_id, process_id, activity_type, timestamp)
VALUES ('0', '0', 'start', '0.712');

INSERT INTO Activity (machine_id, process_id, activity_type, timestamp)
VALUES ('0', '0', 'end', '1.52');

INSERT INTO Activity (machine_id, process_id, activity_type, timestamp)
VALUES ('0', '1', 'start', '3.14');

INSERT INTO Activity (machine_id, process_id, activity_type, timestamp)
VALUES ('0', '1', 'end', '4.12');

INSERT INTO Activity (machine_id, process_id, activity_type, timestamp)
VALUES ('1', '0', 'start', '0.55');

INSERT INTO Activity (machine_id, process_id, activity_type, timestamp)
VALUES ('1', '0', 'end', '1.55');

INSERT INTO Activity (machine_id, process_id, activity_type, timestamp)
VALUES ('1', '1', 'start', '0.43');

INSERT INTO Activity (machine_id, process_id, activity_type, timestamp)
VALUES ('1', '1', 'end', '1.42');

INSERT INTO Activity (machine_id, process_id, activity_type, timestamp)
VALUES ('2', '0', 'start', '4.1');

INSERT INTO Activity (machine_id, process_id, activity_type, timestamp)
VALUES ('2', '0', 'end', '4.512');

INSERT INTO Activity (machine_id, process_id, activity_type, timestamp)
VALUES ('2', '1', 'start', '2.5');

INSERT INTO Activity (machine_id, process_id, activity_type, timestamp)
VALUES ('2', '1', 'end', '5');

# Solution
SELECT machine_id,
       ROUND(SUM(IF(activity_type = 'start', timestamp * -1, timestamp)) * 1.0
                 / (SELECT COUNT(DISTINCT process_id)), 3) AS processing_time
FROM Activity
GROUP BY machine_id;
