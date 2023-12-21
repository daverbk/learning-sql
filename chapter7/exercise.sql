# 7.1
SELECT substring('Please find substring in this string', 17, 9);

# 7.2
SELECT abs(-25.76823) absolute,
       sign(-25.76823) sign,
       round(-25.76823, 2) round;

# 7.3
SELECT extract(MONTH FROM current_date());