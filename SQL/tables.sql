CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    age INT,
    gender VARCHAR(10),
    employment_type VARCHAR(30),
    annual_income INT,
    credit_score INT,
    credit_segment VARCHAR(20),
    income_band VARCHAR(20),
    income_in_months float
    
);

CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_amount INT,
    interest_rate DECIMAL(5,2),
    loan_term_months INT,
    emi  float,
    disbursed_date DATE,
    
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE repayments (
    
    loan_id INT primary key,
    months_paid DATE,
    default_flag int,
    recovered_amount INT,
    loan_amount INT,
    loan_term_months INT,
    loss_amount float,
    interest_earned float,
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);


select * from customers;
select * from loans;


