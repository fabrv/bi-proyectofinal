-- Mas baratos en rango de edad
select p.planid, planvariantmarketingname, avg(individualrate) from rates
join plan p on rates.planid = p.planid
where age > 17 and age < 25
and statecode='NC'
and p.dentalonlyplan='No'
group by p.planid
order by avg(individualrate)
limit 10;

-- Mas beneficios por estado
select p.planid, planvariantmarketingname, count(*) as benefits from benefits
join plan p on benefits.planid = p.planid
group by p.planid
order by count(*) desc
limit 10;

-- mas beneficios y precio
select pbc.*, p.issuermarketplacemarketingname, pr.rate, p.diseasemanagementprogramsoffered from plan_benefits_count pbc
    join plan p on p.planid = pbc.planid
    join get_plan_rates(29, 35, 'TX') pr on pr.id = p.planid
where statecode = 'TX'
and pbc.planvariantmarketingname like 'Clear Gold + Vision + Adult Dental'
--and pbc.planvariantmarketingname = 'Clear Bronze + Vision + Adult Dental'
order by benefits desc, rate asc;

update benefits set women=true
where benefitname like '%natal%'
or benefitname like '%Delivery%'
or benefitname like '%Maternity%';

update benefits set child=true
where benefitname like '%Child%';

select * from plan where childonlyoffering = 'Allows Adult and Child-Only' limit 10;

create or replace function get_plan_rates(age_from integer, age_to integer, state_code text)
  returns table (id varchar, name text, rate numeric(10,2))
as
$body$
  select p.planid as id, planvariantmarketingname as name, AVG(individualrate)::numeric(10,2) as rate from rates
  join plan p on rates.planid = p.planid
  where age > age_from and age < age_to
  and statecode=state_code
  group by p.planid
  order by avg(individualrate)
$body$
language sql;

select planid from plan
where planvariantmarketingname = 'BSW Prime Silver HMO  003 (CMS Standardized Plan with $0 Pediatric PCP copay)'
and statecode = 'OH'
and diseasemanagementprogramsoffered = 'Asthma, Heart Disease, Depression, Diabetes, High Blood Pressure & High Cholesterol, Low Back Pain, Pain Management, Pregnancy'

select * from plans_profile