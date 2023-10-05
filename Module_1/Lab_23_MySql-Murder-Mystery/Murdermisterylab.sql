select *
from crime_scene_report
where type = 'murder'
and date = '20180115'
and city = 'SQL City';
              

-- Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".


select name, address_street_name, id 
from person
where (address_street_name = 'Northwestern Dr' and address_number = (select max(address_number) from person where address_street_name = 'Northwestern Dr'))
   or (address_street_name like'%Franklin%' and name like '%Annabel%');



select person_id, transcript
from interview
where person_id in ('14887', '16371');


select p.*
from interview i 
left join get_fit_now_member m on i.person_id = m.person_id
left join get_fit_now_check_in s on m.id = s.membership_id
left join person p on m.person_id = p.id
left join drivers_license d on p.license_id = d.id
where m.membership_status like '%Gold%'
and s.membership_id like '48Z%'
and d.plate_number like '%H42W%';


select person_id, transcript
from interview
where person_id = '67318';


select p.name,d.*
from person p 
left join facebook_event_checkin e on p.id = e.person_id
left join drivers_license d on p.license_id = d.id
where 1=1
and d.gender = 'female'
and d.hair_color like '%red%'
and d.car_make like '%tesla%'
and d.car_model like '%s%'
and e.event_name = 'SQL Symphony Concert'
and date between 20171201 and 20171231
group by p.id
having count(e.event_name) = 3;