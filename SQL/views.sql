CREATE VIEW loan_analysis AS
SELECT
    l.loan_id,
    c.customer_id,
   
    c.employment_type,
    c.credit_segment,
    c.income_band,
    c.income_in_months,
    l.loan_amount,
    l.interest_rate,
    l.loan_term_months,
    r.loss_amount,
    
    COALESCE(r.default_flag, 0) AS default_flag
FROM loans l
JOIN customers c ON l.customer_id = c.customer_id
LEFT JOIN repayments r   ON l.loan_id = r.loan_id;
