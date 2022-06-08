/*
    DB: SQL Assignemnt Interns
    Username: interns
    Password: pw
/*

/*================================================*/

/* I. CREATE TABLES */

-- faculty (Khoa trong trường)
create table faculty (
	id number primary key,
	name nvarchar2(30) not null
);

-- subject (Môn học)
create table subject(
	id number primary key,
	name nvarchar2(100) not null,
	lesson_quantity number(2,0) not null -- tổng số tiết học
);

alter table subject
    modify name nvarchar2(40);

-- student (Sinh viên)
create table student (
	id number primary key,
	name nvarchar2(30) not null,
	gender nvarchar2(10) not null, -- giới tính
	birthday date not null,
	hometown nvarchar2(100) not null, -- quê quán
	scholarship number, -- học bổng
	faculty_id number not null constraint faculty_id references faculty(id) -- mã khoa
);

alter table student
    modify hometown nvarchar2(20);

-- exam management (Bảng điểm)
create table exam_management(
	id number primary key,
	student_id number not null constraint student_id references student(id),
	subject_id number not null constraint subject_id references subject(id),
	number_of_exam_taking number not null, -- số lần thi (thi trên 1 lần được gọi là thi lại) 
	mark number(4,2) not null -- điểm
);

/*================================================*/

/* II. INSERT SAMPLE DATA */

-- subject
insert into subject (id, name, lesson_quantity) values (1, n'Cơ sở dữ liệu', 45);
insert into subject values (2, n'Trí tuệ nhân tạo', 45);
insert into subject values (3, n'Truyền tin', 45);
insert into subject values (4, n'Đồ họa', 60);
insert into subject values (5, n'Văn phạm', 45);


-- faculty
insert into faculty values (1, n'Anh - Văn');
insert into faculty values (2, n'Tin học');
insert into faculty values (3, n'Triết học');
insert into faculty values (4, n'Vật lý');


-- student
insert into student values (1, n'Nguyễn Thị Hải', n'Nữ', to_date('19900223', 'YYYYMMDD'), 'Hà Nội', 130000, 2);
insert into student values (2, n'Trần Văn Chính', n'Nam', to_date('19921224', 'YYYYMMDD'), 'Bình Định', 150000, 4);
insert into student values (3, n'Lê Thu Yến', n'Nữ', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 150000, 2);
insert into student values (4, n'Lê Hải Yến', n'Nữ', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 170000, 2);
insert into student values (5, n'Trần Anh Tuấn', n'Nam', to_date('19901220', 'YYYYMMDD'), 'Hà Nội', 180000, 1);
insert into student values (6, n'Trần Thanh Mai', n'Nữ', to_date('19910812', 'YYYYMMDD'), 'Hải Phòng', null, 3);
insert into student values (7, n'Trần Thị Thu Thủy', n'Nữ', to_date('19910102', 'YYYYMMDD'), 'Hải Phòng', 10000, 1);


-- exam_management
insert into exam_management values (1, 1, 1, 1, 3);
insert into exam_management values (2, 1, 1, 2, 6);
insert into exam_management values (3, 1, 2, 2, 6);
insert into exam_management values (4, 1, 3, 1, 5);
insert into exam_management values (5, 2, 1, 1, 4.5);
insert into exam_management values (6, 2, 1, 2, 7);
insert into exam_management values (7, 2, 3, 1, 10);
insert into exam_management values (8, 2, 5, 1, 9);
insert into exam_management values (9, 3, 1, 1, 2);
insert into exam_management values (10, 3, 1, 2, 5);
insert into exam_management values (11, 3, 3, 1, 2.5);
insert into exam_management values (12, 3, 3, 2, 4);
insert into exam_management values (13, 4, 5, 2, 10);
insert into exam_management values (14, 5, 1, 1, 7);
insert into exam_management values (15, 5, 3, 1, 2.5);
insert into exam_management values (16, 5, 3, 2, 5);
insert into exam_management values (17, 6, 2, 1, 6);
insert into exam_management values (18, 6, 4, 1, 10);



/*================================================*/

/* III. QUERY */


 /********* A. BASIC QUERY *********/

-- 1. Liệt kê danh sách sinh viên sắp xếp theo thứ tự:
--      a. id tăng dần
--      b. giới tính
--      c. ngày sinh TĂNG DẦN và học bổng GIẢM DẦN

select * from student
order by id;

select * from student
    order by gender;

select * from student
    order by birthday asc, scholarship desc;

-- 2. Môn học có tên bắt đầu bằng chữ 'T'

select * from subject
where name like N'T%';

-- 3. Sinh viên có chữ cái cuối cùng trong tên là 'i'

select * from student
where name like N'%i';

-- 4. Những khoa có ký tự thứ hai của tên khoa có chứa chữ 'n'

select * from faculty
where name like N'_n%';

-- 5. Sinh viên trong tên có từ 'Thị'

select * from student
where name like N'%Thị%';

-- 6. Sinh viên có ký tự đầu tiên của tên nằm trong khoảng từ 'a' đến 'm', sắp xếp theo họ tên sinh viên

select * from student
where substr(name,0,1) between N'A' and N'M'
order by name;

-- 7. Sinh viên có học bổng lớn hơn 100000, sắp xếp theo mã khoa giảm dần

select * from student
where scholarship > 100000
order by faculty_id;

-- 8. Sinh viên có học bổng từ 150000 trở lên và sinh ở Hà Nội

select * from student 
where scholarship > 150000 and hometown like N'Hà Nội';

-- 9. Những sinh viên có ngày sinh từ ngày 01/01/1991 đến ngày 05/06/1992

select * from student
where to_char(birthday,'yyyymmdd') between '19910101' and '19920605';

-- 10. Những sinh viên có học bổng từ 80000 đến 150000

select * from student
where scholarship between 80000 and 150000;

-- 11. Những môn học có số tiết lớn hơn 30 và nhỏ hơn 45

select * from subject 
where lesson_quantity between 30 and 45;

-------------------------------------------------------------------

/********* B. CALCULATION QUERY *********/

-- 1. Cho biết thông tin về mức học bổng của các sinh viên, gồm: Mã sinh viên, Giới tính, Mã 
		-- khoa, Mức học bổng. Trong đó, mức học bổng sẽ hiển thị là “Học bổng cao” nếu giá trị 
		-- của học bổng lớn hơn 500,000 và ngược lại hiển thị là “Mức trung bình”.

select id, gender, faculty_id,
        case when (scholarship > 150000) 
            then N'Học bổng cao' 
            else N'Mức trung bình' 
        end as muc_hoc_bong
from student;
		
-- 2. Tính tổng số sinh viên của toàn trường

select count(id) as Tong_so_sv_toan_truong
from student;

-- 3. Tính tổng số sinh viên nam và tổng số sinh viên nữ.

select gender, count(id) as Tong_so_sv
from student
group by gender;

-- 4. Tính tổng số sinh viên từng khoa

select faculty.id, faculty.name, count(student.id) as tong_so_sv
from faculty left join student
on faculty.id = student.faculty_id
group by faculty.id, faculty.name;

-- 5. Tính tổng số sinh viên của từng môn học

select subject.id, subject.name, count(exam_management.student_id) as so_sv_hoc
from subject left join exam_management
on subject.id = exam_management.subject_id
group by subject.id, subject.name;

-- 6. Tính số lượng môn học mà sinh viên đã học

select student.id, student.name, count(exam_management.subject_id) as so_mon_hoc
from student left join exam_management
on student.id = exam_management.student_id
group by student.id, student.name;

-- 7. Tổng số học bổng của mỗi khoa	

select faculty.id, faculty.name, count(student.scholarship) as so_hb
from faculty left join student
on faculty.id = student.faculty_id
group by faculty.id, faculty.name;

-- 8. Cho biết học bổng cao nhất của mỗi khoa

select faculty.id, faculty.name, max(student.scholarship) as so_hb
from faculty left join student
on faculty.id = student.faculty_id
group by faculty.id, faculty.name;

-- 9. Cho biết tổng số sinh viên nam và tổng số sinh viên nữ của mỗi khoa

select faculty.id, faculty.name, 
        count(case when gender = N'Nữ' then 1 end) as so_sv_nu,
        count(case when gender = N'Nam' then 1 end) as so_sv_nam
from faculty left join student
on faculty.id = student.faculty_id
group by faculty.id, faculty.name;

-- 10. Cho biết số lượng sinh viên theo từng độ tuổi

select (extract(year from CURRENT_DATE) - extract(year from birthday)) as tuoi, count(student.id) as so_sv
from student
group by extract(year from birthday);

-- 11. Cho biết những nơi nào có ít nhất 2 sinh viên đang theo học tại trường

select hometown, count(id) as so_sv
from student
group by hometown
having count(id) >=2;

-- 12. Cho biết những sinh viên thi lại ít nhất 2 lần

select distinct student.id, student.name 
from exam_management join student
on student.id = exam_management.student_id
where number_of_exam_taking >= 2;

-- 13. Cho biết những sinh viên nam có điểm trung bình lần 1 trên 7.0 

select student.id, student.name, round(avg(mark),2) as dtb_lan1
from exam_management join student
on exam_management.student_id = student.id
where number_of_exam_taking = 1 and student.gender = N'Nam'
group by student.id, student.name;

-- 14. Cho biết danh sách các sinh viên rớt ít nhất 2 môn ở lần thi 1 
        --(rớt môn là điểm thi của môn không quá 4 điểm)

select distinct student.id, student.name
from exam_management join student
on exam_management.student_id = student.id
where number_of_exam_taking = 1 and mark <4;

-- 15. Cho biết danh sách những khoa có nhiều hơn 2 sinh viên nam

select faculty.id, faculty.name, count(student.id) as so_sv_nam
from faculty left join student
on faculty.id = student.faculty_id
where gender = N'Nam'
group by faculty.id, faculty.name
having count(student.id) > 2;

-- 16. Cho biết những khoa có 2 sinh viên đạt học bổng từ 200000 đến 300000
select faculty.id, faculty.name
from faculty left join student
on faculty.id = student.faculty_id
where scholarship between 130000 and 170000
group by faculty.id, faculty.name
having count(student.id) > 2;

-- 17. Cho biết sinh viên nào có học bổng cao nhất
select *
from student
where scholarship = (select max(scholarship) from student);

-------------------------------------------------------------------

/********* C. DATE/TIME QUERY *********/

-- 1. Sinh viên có nơi sinh ở Hà Nội và sinh vào tháng 02

select * from student
where hometown = N'Hà Nội' and extract(month from birthday) = 2;

-- 2. Sinh viên có tuổi lớn hơn 20

select * from student
where extract(year from CURRENT_DATE) - extract(year from birthday) > 30;

-- 3. Sinh viên sinh vào mùa xuân năm 1990

select * from student
where extract(year from birthday)= 1990
    and extract(month from birthday) between 1 and 3;


-------------------------------------------------------------------


/********* D. JOIN QUERY *********/

-- 1. Danh sách các sinh viên của khoa ANH VĂN và khoa VẬT LÝ

select student.id, student.name
from student join faculty
on student.faculty_id = faculty.id
where faculty.name = N'Anh - Văn' or faculty.name = N'Vật lý';

-- 2. Những sinh viên nam của khoa ANH VĂN và khoa TIN HỌC

select student.id, student.name
from student join faculty
on student.faculty_id = faculty.id
where student.gender = N'Nam'
    and (faculty.name = N'Anh - Văn' or faculty.name = N'Tin học');

-- 3. Cho biết sinh viên nào có điểm thi lần 1 môn cơ sở dữ liệu cao nhất
select * from student
where student.id = (
    select *
    from (
        select exam_management.student_id
        from exam_management join subject 
        on exam_management.subject_id = subject.id
        where subject.name = N'Cơ sở dữ liệu' and exam_management.number_of_exam_taking = 1
        order by mark desc
        )
    where rownum = 1
    );
    
-- 4. Cho biết sinh viên khoa anh văn có tuổi lớn nhất.

select student.*
from student join faculty
on student.faculty_id = faculty.id
where faculty.name = N'Anh - Văn'
    and extract(year from birthday) = 
            (
            select min(extract(year from birthday))
            from student
            );

-- 5. Cho biết khoa nào có đông sinh viên nhất

select * from faculty
where faculty.id = (
        select * from (
            select faculty_id
            from student
            group by faculty_id
            order by count(id) desc
            )
        where rownum = 1);

-- 6. Cho biết khoa nào có đông nữ nhất
select * from faculty
where faculty.id = (
        select * from (
            select faculty.id
            from faculty left join student
            on faculty.id = student.faculty_id
            group by faculty.id
            order by count(case when gender = N'Nữ' then 1 end) desc
            )
        where rownum = 1);

-- 7. Cho biết những sinh viên đạt điểm cao nhất trong từng môn

select exam_management.subject_id, max(mark)
from exam_management
group by exam_management.subject_id;


-- 8. Cho biết những khoa không có sinh viên học

-- 9. Cho biết sinh viên chưa thi môn cơ sở dữ liệu

-- 10. Cho biết sinh viên nào không thi lần 1 mà có dự thi lần 2
