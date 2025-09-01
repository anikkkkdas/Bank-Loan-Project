
select * from bank_loan_data

-- ===================
--		KPI'S 
-- ===================
-- Total Loan Application
select count(id) as TotalLoanApplication from bank_loan_data
-- MTD Loan Application
select count(id) as MTDLoanApp from bank_loan_data where month(issue_date) = 12
-- MoM Loan Application
select count(id) as PMTDLoanApp from bank_loan_data where month(issue_date) = 11


-- Total Funded Amount
select sum(loan_amount) as TotalFundedAmount from bank_loan_data
-- MTD Funded Amount
select sum(loan_amount) as MTDTotalFundedAmount from bank_loan_data where month(issue_date) = 12
-- PMTD Funded Amount
select sum(loan_amount) as PMTDTotalFundedAmount from bank_loan_data where month(issue_date) = 11


-- Total Total Payment Recieved
select sum(total_payment) as TotalAmountRecvd from bank_loan_data
-- MTD Total Payment Recieved
select sum(total_payment) as MTDTotalAmountRecvd from bank_loan_data where month(issue_date) = 12 and YEAR(issue_date) = 2021
-- PMTD Funded Amount
select sum(total_payment) as PMTDTotalAmountRecvd from bank_loan_data where month(issue_date) = 11 and YEAR(issue_date) = 2021


-- Average Interest Rate
select round(avg(int_rate)*100,2) as AvgIntRate from bank_loan_data
-- MTD Average Interest Rate
select round(avg(int_rate)*100,2) as MTDAvgIntRate from bank_loan_data where month(issue_date) = 12 and YEAR(issue_date) = 2021
-- PMTD Average Interest Rate
select round(avg(int_rate)*100,2) as MoMAvgIntRate from bank_loan_data where month(issue_date) = 11 and YEAR(issue_date) = 2021


-- Avg Debt-to-Income Ratio
select round(avg(dti)*100,2) as AvgDTI from bank_loan_data
-- MTD Debt-to-Income Ratio
select round(avg(dti)*100,2) as AvgDTI from bank_loan_data where MONTH(issue_date) = 12 and year(issue_date) = 2021
-- PMTD Average Interest Rate
select round(avg(dti)*100,2) as AvgDTI from bank_loan_data where MONTH(issue_date) = 11 and year(issue_date) = 2021


-- Good Loan Application Percentage (Good Loan is when loan status is 'Fully Paid' or 'Current')
select (count(case when loan_status = 'Fully Paid' OR loan_status = 'Current' Then id end) * 100) / COUNT(id) as good_loan_percent from bank_loan_data
-- Good Loan Applications
select count(id) as GoodLoanApplicationCount from bank_loan_data where loan_status in ('Fully Paid','Current')
-- Good Loan Funded Amount
select sum(loan_amount) as GoodLoanFundedAmount from bank_loan_data where loan_status in ('Fully Paid','Current')
-- Good Loan TotalRecieved Amount
select sum(total_payment) as GoodLoanRecievedAmount from bank_loan_data where loan_status in ('Fully Paid','Current')


-- Bad Loan Application Percentage (Bad Loan is when loan status is Charged Off)
select (count(case when loan_status = 'Charged Off' Then id end) * 100) / COUNT(id) as bad_loan_percent from bank_loan_data
-- Bad Loan Applications
select count(id) as BadLoanApplicationCount from bank_loan_data where loan_status in ('Charged Off')
-- Bad Loan Funded Amount
select sum(loan_amount) as BadLoanFundedAmount from bank_loan_data where loan_status in ('Charged Off')
-- Good Loan TotalRecieved Amount
select sum(total_payment) as BadLoanRecievedAmount from bank_loan_data where loan_status in ('Charged Off')


-- ======================
-- Loan Status Summary
-- ======================
select
	loan_status,
	COUNT(id) as TotalLoanApplication,
	SUM(total_payment) as TotalAmountRecieved,
	sum(loan_amount) as TotalFundedAmount,
	round(avg(int_rate * 100),2) as InterestRate,
	round(avg(dti *100),2) as DTI
from bank_loan_data
	group by loan_status

-- MTD Amount Recieved and MTD TotalAmountFunded by Loan Status
select
	loan_status,
	SUM(total_payment) as MTDTotalAmountRecieved,
	sum(loan_amount) as MTDTotalFundedAmount
from bank_loan_data
	where MONTH(issue_date) = 12
	group by loan_status

--- ======================================
---				OverView KPI
--- ======================================
-- Total Loan Application, Total Loan Given and Total Amount Recieved by Month
select 
	month(issue_date) as MonthNo,
	Datename(month,issue_date) as Month,
	count(id) as TotalLoanApplication,
	sum(loan_amount) as TotalFundedAmount,
	sum(total_payment) as TotalPaymentRecieved
from bank_loan_data
group by month(issue_date), Datename(month,issue_date)
order by month(issue_date)

-- Total Loan Application, Total Loan Given and Total Amount Recieved by State
select 
	address_state,
	count(id) as TotalLoanApplication,
	sum(loan_amount) as TotalFundedAmount,
	sum(total_payment) as TotalPaymentRecieved
from bank_loan_data
group by address_state
order by sum(loan_amount) desc

-- Total Loan Application, Total Loan Given and Total Amount Recieved by Loan Term 
select 
	term,
	count(id) as TotalLoanApplication,
	sum(loan_amount) as TotalFundedAmount,
	sum(total_payment) as TotalPaymentRecieved
from bank_loan_data
group by term
order by term

-- Total Loan Application, Total Loan Given and Total Amount Recieved by Employment length
select 
	emp_length,
	count(id) as TotalLoanApplication,
	sum(loan_amount) as TotalFundedAmount,
	sum(total_payment) as TotalPaymentRecieved
from bank_loan_data
group by emp_length
order by emp_length

--Total Loan Application, Total Loan Given and Total Amount Recieved by Purpose
select 
	purpose,
	count(id) as TotalLoanApplication,
	sum(loan_amount) as TotalFundedAmount,
	sum(total_payment) as TotalPaymentRecieved
from bank_loan_data
group by purpose
order by sum(loan_amount) desc

--Total Loan Application, Total Loan Given and Total Amount Recieved by Home Ownership
select 
	home_ownership,
	count(id) as TotalLoanApplication,
	sum(loan_amount) as TotalFundedAmount,
	sum(total_payment) as TotalPaymentRecieved
from bank_loan_data
group by home_ownership
order by count(id) desc

