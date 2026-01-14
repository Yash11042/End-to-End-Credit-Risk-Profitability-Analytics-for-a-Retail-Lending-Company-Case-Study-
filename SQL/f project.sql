use acs;

select* from customers_clean;
select * from loans_clean;
select* from repayments_clean;

#PHASE 1 : 
# TOTAL LOAN BOOK SIZE

select distinct(count(loan_id)) as total_loan
from loans_clean;

#overall default rate

select 
count(r.loan_id) as total_loan , 
sum(r.default_flag) as total_default,
round(sum(r.default_flag) * 100 /count(r.loan_id) , 2) as total_default_pct
from repayments_clean r;


#AVERAGE INTEREST YIELD

with interest as (
select loan_amount , 
(emi * loan_term_months  - loan_amount) as total_interest
from loans_clean
)
select  
round(avg(total_interest),2) as avg_interest 
from interest;

# Defaulters vs NON DEFAULTERS LOAN
# Do defaulters take more loan than non defaulters?

select 
case 
when r.default_flag = 0 then "Non-Defaulter"
else "Defaulter"
end as default_segment,
count(*)  as total_loans ,
round(min(l.loan_amount) ,2 ) as min_loan_amount,
round(max(l.loan_amount),2) as max_loand_amount,
round(sum(l.loan_amount), 2 ) as total_loans
from repayments_clean r
join loans_clean l 
on l.loan_id = r.loan_id
group by default_segment;

# DEFAULTS CLASSIFICATION WITH CREDIT_SEGMENT

WITH customer_type AS (
    SELECT
        CASE 
            WHEN c.credit_score < 570 THEN 'Poor'
            WHEN c.credit_score BETWEEN 570 AND 649 THEN 'Fair'
            WHEN c.credit_score BETWEEN 650 AND 719 THEN 'Good'
            ELSE 'Excellent'
        END AS credit_segment,

        CASE 
            WHEN r.default_flag = 0 THEN 'Non-Defaulter'
            ELSE 'Defaulter'
        END AS default_segment,

        COUNT(r.loan_id) AS total_loans,
        SUM(l.loan_amount) AS total_loan_amount,
        ROUND(
            100.0 * SUM(r.default_flag) / COUNT(*),
            2
        ) AS default_pct

    FROM repayments_clean r
    JOIN loans_clean l 
        ON r.loan_id = l.loan_id
    JOIN customers_clean c 
        ON c.customer_id = l.customer_id

    GROUP BY
        credit_segment,
        default_segment
)

SELECT
    credit_segment,
    default_segment,
    total_loans,
    total_loan_amount,
    default_pct
FROM customer_type
ORDER BY credit_segment, default_segment;


#“What’s the default rate by credit segment overall?”
WITH customer_type AS (
    SELECT
        CASE 
            WHEN c.credit_score < 570 THEN 'Poor'
            WHEN c.credit_score BETWEEN 570 AND 649 THEN 'Fair'
            WHEN c.credit_score BETWEEN 650 AND 719 THEN 'Good'
            ELSE 'Excellent'
        END AS credit_segment,
        count(r.loan_id) as total_customers,
        sum(r.default_flag) as total_default,
        ROUND(100.0 * SUM(r.default_flag) / COUNT(*),2) AS default_pct
        from repayments_clean r
        join loans_clean l 
        on r.loan_id = l.loan_id
        join customers_clean c 
        on c.customer_id = l.customer_id
        
        group by credit_segment
        )
        select credit_segment ,
        total_customers,
        total_default,
        default_pct
        from customer_type;
        
# 	AVG LOAN_AMOUNT , AVG INTEREST , AVG TENURE

select sum(l.loan_amount) as total_loan,
	avg(l.loan_amount) as avg_loan,
	avg(l.interest_rate) as avg_interst_rate,
    round(avg((l.loan_term_months/12)),1) as avg_tenure_in_yr
    from loans_clean l;
    
# interst earned , loss , net profit

with loss as(
select
		l.loan_id,
        l.loan_amount,
        r.default_flag,
        l.emi,
        r.months_paid,
        r.recovered_amount,
	 round(l.emi * l.loan_term_months - l.loan_amount , 2) as total_interest,
     case when r.default_flag = 1 then r.loan_amount - r.recovered_amount 
     else 0 
     end as total_loss
     from repayments_clean r
     join loans_clean l 
     on r.loan_id = l.loan_id
     )
     select loan_id ,
     loan_amount , 
     default_flag , 
     total_interest , 
     total_loss,
     round(total_interest - total_loss,2) as net_loss
     from loss;
     
#RISK VS REWAED MATRICS

WITH loan_financials as (
select l.loan_id , 
		l.customer_id,
        r.default_flag,
        l.emi , 
        r.loan_term_months,
        l.loan_amount,
        r.recovered_amount,
        (l.emi * loan_term_month - l.loan_amount) as total_interest,
        case 
        when r.default_flag = 1 then l.loan_amount - r.recovered_amount
        else 0 
        end as total_loss
        from repayments_clean r
         join loans_clean l 
     on r.loan_id = l.loan_id
     ),
     credit_seg as (
     select customer_id,
     CASE 
            WHEN c.credit_score < 570 THEN 'Poor'
            WHEN c.credit_score BETWEEN 570 AND 649 THEN 'Fair'
            WHEN c.credit_score BETWEEN 650 AND 719 THEN 'Good'
            ELSE 'Excellent'
        END AS credit_segment
        from customers_clean),
        
        segment_metrics as (
        select cs.credit_segment,
        count(*) as total_loan,
        sum(lf.default_flag) as defaulted_loans,
        round( 100 * sum(lf.default_flag) / count(*),2) as default_rate_pct,
        round(sum(lf.net_profit) , 0) as net_profit
        from loan_financials lf 
        join credit_segment cs
        on lf.customer_id = cs.customer_id
        group by cs.credit_segment )
        
        select credit_segment,
        total_loan,
        default_rate_pct,
        net_profit,
        case
        when default_rate_pct <= 15 and net_profit > 0 then 'Scale'
        when default_rate_pct > 15 and net_profit > 0 then "Control"
        when default_rate_pct <= 15 and net_profit <= 0 then "Optimize"
        else "stop"
        end as business_actions
        from segment_metrics
        order by net_profit desc;
        
# EARLY WARNING ANALYTICS
# EMI/ INCOME RATIO
#HIGH LOAN AMOUNT WITH LOW INCOME 
with EMI_Ratio as (
select l.customer_id , 
		l.loan_id,
        l.loan_amount,
		l.emi,
        c.annual_income,
        (c.annual_income /12) as  monthly_income,
        round(l.emi / (c.annual_income/12)*100,2) as ratio
        from customers_clean c 
        join loans_clean l 
        on c.customer_id = l.customer_id 
        )
        
        select loan_id ,
				customer_id,
                loan_amount,
                round(monthly_income , 0) as monthly_income,
                round(emi,0) as emi,
                round(ratio * 100 , 2) as emi_income_pct,
                case
                when loan_amount >= 300000 and ratio > 40 then "High Risk"
                when loan_amount >= 300000 and ratio between 30 and 40 then "Moderate Risk"
                else "Low Risk"
                end as risk_flag
                from EMI_Ratio
                order by ratio;
        
        
				
        


     

     
     
    
    
    







 
